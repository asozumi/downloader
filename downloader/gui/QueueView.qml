import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Controls.ScrollView {
    id: queueBox

    Layout.fillHeight: true
    Layout.fillWidth: true

    Kirigami.StyleHints.showFramedBackground: true

    contentItem: ListView {
        id: listView
        clip: true
        spacing: Kirigami.Units.mediumSpacing

        model: [
            { name: "Item 1", detail: "Details for item 1" },
            { name: "Item 2", detail: "Details for item 2" },
            { name: "Item 3", detail: "Details for item 3" }
        ]

        delegate: Controls.ItemDelegate {
            required property var modelData

            width: ListView.view.width
            text: modelData.name
            padding: Kirigami.Units.largeSpacing
        }
    }
}
