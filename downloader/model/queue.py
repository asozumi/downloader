# Copyright (c) 2026 Asano Sumi

from dataclasses import dataclass, fields
from enum import IntEnum, auto

from PySide6.QtCore import (
    QAbstractListModel,
    QByteArray,
    QModelIndex,
    QPersistentModelIndex,
    Qt,
)
from typing_extensions import override

_NO_PARENT = QModelIndex()


@dataclass
class DownloadItem:
    url: str
    progress: float = 0.0


class DownloadItemRoles(IntEnum):
    URL = Qt.ItemDataRole.UserRole
    PROGRESS = auto()


_ROLE_FIELDS: dict[int, str] = {
    DownloadItemRoles.URL: "url",
    DownloadItemRoles.PROGRESS: "progress",
}

# Convert the mapping into the format that Qt wants
_ROLE_NAMES: dict[int, QByteArray] = {
    role: QByteArray(field.encode()) for role, field in _ROLE_FIELDS.items()
}


def _validate_roles() -> None:
    """Fail at import time if the role mapping drifts from the enum or dataclass."""

    missing = [r.name for r in DownloadItemRoles if r not in _ROLE_FIELDS]
    if missing:
        msg = f"_ROLE_FIELDS has no entry for roles: {', '.join(missing)}"
        raise ValueError(msg)

    unknown = set(_ROLE_FIELDS.values()) - {f.name for f in fields(DownloadItem)}
    if unknown:
        msg = f"_ROLE_FIELDS names unknown DownloadItem fields: {', '.join(sorted(unknown))}"  # noqa: E501
        raise ValueError(msg)


_validate_roles()


class QueueModel(QAbstractListModel):
    _NO_PARENT: QModelIndex = QModelIndex()

    def __init__(self) -> None:
        super().__init__()
        self._items: list[DownloadItem] = []

    @override
    def data(
        self,
        index: QModelIndex | QPersistentModelIndex,
        role: int = Qt.ItemDataRole.DisplayRole,
    ) -> object:
        if not self.checkIndex(index, self.CheckIndexOption.IndexIsValid):
            return None

        field = _ROLE_FIELDS.get(role)
        if field is None:
            return None

        return getattr(self._items[index.row()], field)  # pyright: ignore[reportAny]

    @override
    def roleNames(self) -> dict[int, QByteArray]:
        return _ROLE_NAMES

    @override
    def rowCount(self, parent: QModelIndex | QPersistentModelIndex = _NO_PARENT) -> int:
        return 0 if parent.isValid() else len(self._items)

    def add(self, url: str) -> None:
        row = len(self._items)
        self.beginInsertRows(_NO_PARENT, row, row)
        self._items.append(DownloadItem(url))
        self.endInsertRows()

    def clear(self) -> None:
        self.beginResetModel()
        self._items.clear()
        self.endResetModel()
