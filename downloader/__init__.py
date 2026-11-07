import sys
import signal

from pathlib import Path
from PySide6.QtCore import QTimer, QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from .backend import Backend

def main() -> int:
    app = QGuiApplication(sys.argv)
    signal.signal(signal.SIGINT, lambda *args: app.quit())

    timer = QTimer()
    timer.start(100)
    timer.timeout.connect(lambda: None)

    engine = QQmlApplicationEngine()

    backend = Backend()
    engine.setInitialProperties({"backend": backend})

    qml_entry = Path(__file__).parent / "gui" / "Main.qml"
    engine.load(QUrl.fromLocalFile(str(qml_entry)))

    if not engine.rootObjects():
        print(f"Failed to load QML: {qml_entry}", file=sys.stderr)
        return -1

    return app.exec()
    
if __name__ == "__main__":
    sys.exit(main())
