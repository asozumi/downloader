# Copyright (c) 2026 Asano Sumi

import os
import signal
import sys
from pathlib import Path

from PySide6.QtCore import QUrl
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QApplication

from .backend.queue_controller import QueueController


class Application:
    def __init__(self) -> None:
        os.environ.setdefault("QT_QUICK_CONTROLS_STYLE", "org.kde.desktop")

        self.app: QApplication = QApplication(sys.argv)
        self.app.setApplicationName("downloader")
        self.app.setApplicationDisplayName("Downloader")

        self.engine: QQmlApplicationEngine = QQmlApplicationEngine()

        self.queue_controller: QueueController = QueueController()
        self.engine.rootContext().setContextProperty("queueController", self.queue_controller)

    def load_gui(self) -> bool:
        qml_file = Path(__file__).parent / "gui" / "ApplicationWindow.qml"
        self.engine.load(QUrl.fromLocalFile(str(qml_file)))
        return bool(self.engine.rootObjects())

    def start(self) -> int:
        if not self.load_gui():
            return -1

        return self.app.exec()


def main() -> int:
    signal.signal(signal.SIGINT, signal.SIG_DFL)
    app = Application()

    return app.start()


if __name__ == "__main__":
    sys.exit(main())
