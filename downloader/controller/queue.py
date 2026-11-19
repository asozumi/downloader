# Copyright (c) 2026 Asano Sumi

from PySide6.QtCore import Property, QObject, Slot

from downloader.model.queue import QueueModel


class QueueController(QObject):
    def __init__(self) -> None:
        super().__init__()
        self._model: QueueModel = QueueModel()

    @Property(QObject, constant=True)
    def model(self) -> QueueModel:
        return self._model

    @Slot(str)
    def add(self, url: str) -> None:
        self._model.add(url)

    @Slot()
    def clear(self) -> None:
        self._model.clear()

