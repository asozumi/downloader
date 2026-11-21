pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

BackendSettings {
    RowLayout {
        Controls.TextField {
            id: urlField
            Layout.fillWidth: true
            placeholderText: "https://youtube.com/..."
        }

        Controls.Button {
            id: resolveButton
            display: Controls.AbstractButton.TextBesideIcon
            icon.name: "view-refresh"
            text: "Resolve"
        }
    }

    function submit() {
        return false;
    }
}
