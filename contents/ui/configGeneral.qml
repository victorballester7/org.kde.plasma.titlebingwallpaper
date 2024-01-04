import QtQuick 2.0
import QtQuick.Controls 2.3 as QtControls
import QtQuick.Dialogs 1.1 as QtDialogs
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrolsaddons 2.0 // For KCMShell
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.workspace.calendar 2.0 as PlasmaCalendar

ColumnLayout {
    id: generalConfigPage

    property alias cfg_autoFontAndSize: autoFontAndSizeRadioButton.checked
    property alias cfg_fontFamily: fontDialog.fontChosen.family
    property alias cfg_bold: fontDialog.fontChosen.bold
    property alias cfg_italic: fontDialog.fontChosen.italic
    property alias cfg_fontWeight: fontDialog.fontChosen.weight
    property alias cfg_fontStyleName: fontDialog.fontChosen.styleName
    property alias cfg_fontSize: fontDialog.fontChosen.pointSize
    property alias cfg_showLocation: showLocation.checked
    property alias cfg_oneLineMode: oneLineMode.checked
    property alias cfg_locale: locale.currentText
    property string defaultLocale: plasmoid.configuration.locale

    Kirigami.FormLayout {
        Layout.fillWidth: true

        RowLayout {
            Kirigami.FormData.label: i18n("Locale:")

            QtControls.ComboBox {
                id: locale

                visible: Plasmoid.formFactor !== PlasmaCore.Types.Vertical
                model: [i18n("de-DE"), i18n("en-CA"), i18n("en-US"), i18n("en-GB"), i18n("es-ES"), i18n("fr-CA"), i18n("fr-FR"), i18n("it-IT"), i18n("ja-JP"), i18n("zn-CN"), i18n("Other")]
                currentIndex: model.indexOf(i18n(defaultLocale))
                onActivated: {
                    cfg_locale = currentText;
                }
            }

        }

        Item {
            Kirigami.FormData.isSection: true
        }

        RowLayout {
            // QtControls.ComboBox {
            //     id: dateDisplayFormat
            //     enabled: showLocation.checked
            //     visible: Plasmoid.formFactor !== PlasmaCore.Types.Vertical
            //     model: [i18n("Adaptive location"), i18n("Always beside time"), i18n("Always below time")]
            //     onActivated: cfg_dateDisplayFormat = currentIndex
            // }

            Kirigami.FormData.label: i18n("Information:")

            QtControls.CheckBox {
                id: showLocation

                text: i18n("Show location")
            }

        }

        QtControls.CheckBox {
            id: oneLineMode

            enabled: showLocation.checked
            text: i18n("Use one line mode")
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        QtControls.ButtonGroup {
            buttons: [autoFontAndSizeRadioButton, manualFontAndSizeRadioButton]
        }

        QtControls.RadioButton {
            id: autoFontAndSizeRadioButton

            Kirigami.FormData.label: i18nc("@label:group", "Text display:")
            text: i18nc("@option:radio", "Automatic")
        }

        QtControls.Label {
            text: i18nc("@label", "Text will follow the system font and expand to fill the available space.")
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            font: PlasmaCore.Theme.smallestFont
        }

        RowLayout {
            QtControls.RadioButton {
                id: manualFontAndSizeRadioButton

                text: i18nc("@option:radio setting for manually configuring the font settings", "Manual")
                checked: !cfg_autoFontAndSize
                onClicked: {
                    if (cfg_fontFamily === "")
                        fontDialog.fontChosen = PlasmaCore.Theme.defaultFont;

                }
            }

            QtControls.Button {
                text: i18nc("@action:button", "Choose Style…")
                icon.name: "settings-configure"
                enabled: manualFontAndSizeRadioButton.checked
                onClicked: {
                    fontDialog.font = fontDialog.fontChosen;
                    fontDialog.open();
                }
            }

        }

        QtControls.Label {
            visible: manualFontAndSizeRadioButton.checked
            text: i18nc("@info %1 is the font size, %2 is the font family", "%1pt %2", cfg_fontSize, fontDialog.fontChosen.family)
            font: fontDialog.fontChosen
        }

    }

    Item {
        Layout.fillHeight: true
    }

    QtDialogs.FontDialog {
        id: fontDialog

        property font fontChosen: Qt.Font()

        title: i18nc("@title:window", "Choose a Font")
        modality: Qt.WindowModal
        onAccepted: {
            fontChosen = font;
        }
    }

}
