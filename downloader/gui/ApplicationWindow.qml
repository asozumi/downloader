pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root

    title: "Downloader"
    width: 640
    height: 400

    pageStack.initialPage: Kirigami.Page {
        title: "Downloader"

        actions: [
            Kirigami.Action {
                icon.name: "edit-clear"
                enabled: true
                tooltip: "Clear queue"

                onTriggered: clearConfirmationDialog.open()
            }
        ]

        ColumnLayout {
            anchors.fill: parent

            QueueView {

            }

            QueueBox {

            }
        }

        Kirigami.PromptDialog {
            id: clearConfirmationDialog

            title: "Clear download queue?"
            subtitle: "Are you sure you want to clear all items from the queue? This action cannot be undone."

            standardButtons: Kirigami.Dialog.Ok | Kirigami.Dialog.Cancel

            onAccepted: queueController.clear()
        }
    }
}
