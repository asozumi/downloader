pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

import "backend"

Kirigami.ApplicationWindow {
    id: root

    title: "Downloader"

    minimumWidth: 640
    minimumHeight: 400

    width: minimumWidth
    height: minimumHeight

    pageStack.initialPage: Kirigami.Page {
        title: "Downloader"

        actions: [
            Kirigami.Action {
                icon.name: "list-add"
                enabled: true
                tooltip: "Add new download item"
                onTriggered: addDownloadDialog.open()
            },

            Kirigami.Action {
                icon.name: "edit-clear"
                enabled: true
                tooltip: "Clear queue"
                onTriggered: clearConfirmationDialog.open()
            },
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

            onAccepted: queue.clear()
        }

        Kirigami.Dialog {
            id: addDownloadDialog

            title: "Add download"
            padding: Kirigami.Units.largeSpacing
            standardButtons: Kirigami.Dialog.NoButton
            preferredWidth: Kirigami.Units.gridUnit * 30

            customFooterActions: [
                Kirigami.Action {
                    text: "Add"
                    onTriggered: {
                        if ((settingsLoader.item as BackendSettings).submit() === true) {
                            addDownloadDialog.close()
                        }
                    }
                },

                Kirigami.Action {
                    text: "Cancel"
                }
            ]

            ColumnLayout {
                spacing: Kirigami.Units.largeSpacing
                Layout.fillWidth: true
                
                Controls.ComboBox {
                    id: backendBox

                    Layout.fillWidth: true
                    popup.width: backendBox.width

                    textRole: "text"
                    valueRole: "value"
                    model: [
                        { text: "aria2", value: "aria2", page: "backend/Aria2Settings.qml" },
                        { text: "yt-dlp", value: "yt-dlp", page: "backend/YtDlpSettings.qml" },
                    ]
                }

                Kirigami.Separator { Layout.fillWidth: true }

                Loader {
                    id: settingsLoader
                    Layout.fillWidth: true
                    source: backendBox.model[backendBox.currentIndex].page
                }
            }
        }
    }
}
