from PySide6.QtCore import QObject, Slot

class Backend(QObject):
    def __init__(self):
        super().__init__()

    @Slot(str)
    def test(self, name):
        print(f"hello {name}")

    @Slot(str, str)
    def queue(self, url, backend):
        print(f"Queued: {url} - {backend}")