pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

BackendSettings {
    Controls.TextField {
        id: urlField
        Layout.fillWidth: true
        placeholderText: "https://..."
    }

    function submit() {
        queue.add(urlField.text)
        return true;
    }
}
