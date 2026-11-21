import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

RowLayout {
    id: queueController

    Layout.fillWidth: true
    Layout.alignment: Qt.AlignCenter
    
    spacing: Kirigami.Units.smallSpacing

    Controls.Button {
        display: Controls.AbstractButton.IconOnly
        icon.name: "media-playback-start"
    }

    Controls.Button {
        display: Controls.AbstractButton.IconOnly
        icon.name: "process-stop"
    }

    // Controls.TextField {
    //     id: urlField
    //     Layout.fillWidth: true
    //     placeholderText: "Put URL here..."
    //     onAccepted: addButton.click()

    //     property bool valid: {
    //         try {
    //             new URL(text);
    //             return true;
    //         } catch (err) {
    //             return false;
    //         }
    //     }
    // }

    // Controls.ComboBox {
    //     textRole: "text"
    //     valueRole: "value"

    //     model: [
    //         { value: "aria2", text: "aria2" },
    //         { value: "yt-dlp", text: "yt-dlp" }
    //     ]
    // }

    // Controls.Button {
    //     id: addButton
    //     display: Controls.AbstractButton.IconOnly
    //     icon.name: "list-add"
    //     enabled: urlField.valid
        
    //     onClicked: {
    //         queue.add(urlField.text)
    //         urlField.clear();
    //     }
    // }
}
