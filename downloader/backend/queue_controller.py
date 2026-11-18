# Copyright (c) 2026 Asano Sumi

from PySide6.QtCore import QObject, Slot


class QueueController(QObject):
    def __init__(self) -> None:
        super().__init__()

    @Slot()
    def clear(self) -> None:
        print("hi")
