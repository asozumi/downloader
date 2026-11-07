pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    required property var backend

    title: "Downloader"
    width: 640
    height: 400

    Connections {
        target: root.backend
        function onLogMessage(msg) { log.append(msg) }
    }

    pageStack.initialPage: Kirigami.Page {
        title: "Downloader"

        ColumnLayout {
            anchors.fill: parent
            spacing: Kirigami.Units.smallSpacing

            Controls.ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Controls.TextArea {
                    id: log
                    readOnly: true
                    wrapMode: TextEdit.Wrap
                    font.family: "monospace"
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: Kirigami.Units.smallSpacing

                Controls.TextField {
                    id: urlField
                    Layout.fillWidth: true
                    placeholderText: "Paste URL…"
                    onAccepted: queueButton.clicked()
                }

                Controls.ComboBox {
                    id: backendBox
                    textRole: "text"
                    valueRole: "value"
                    model: [
                        { text: "auto",   value: "auto",   icon: "tools-wizard" },
                        { text: "aria2",  value: "aria2",  icon: "download" },
                        { text: "yt-dlp", value: "native", icon: "video-x-generic" }
                    ]

                    delegate: Controls.MenuItem {
                        required property var modelData
                        required property int index
                        width: parent ? parent.width : implicitWidth
                        text: modelData.text
                        icon.name: modelData.icon
                        highlighted: backendBox.highlightedIndex === index
                    }
                }

                Controls.Button {
                    display: Controls.AbstractButton.TextBesideIcon
                    icon.name: "configure"
                    text: "Settings"
                    Controls.ToolTip.text: "Backend settings"
                    Controls.ToolTip.visible: hovered
                    Controls.ToolTip.delay: Kirigami.Units.toolTipDelay
                    onClicked: settingsDialog.open()
                }

                Controls.Button {
                    id: queueButton
                    display: Controls.AbstractButton.TextBesideIcon
                    icon.name: "bqm-addqueue"
                    text: "Queue"
                    enabled: urlField.text.trim().length > 0
                    onClicked: {
                        root.backend.queue(urlField.text, backendBox.currentValue)
                        urlField.clear()
                    }
                }
            }
        }
    }
}