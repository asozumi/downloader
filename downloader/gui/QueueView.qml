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
        model: queue.model

        delegate: Controls.ItemDelegate {
            id: row

            required property string url
            required property real progress

            text: url
        }
    }
}
