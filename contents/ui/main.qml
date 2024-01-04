import QtQuick 2.6
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.1
import org.kde.kquickcontrolsaddons 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.plasmoid 2.0

Item {
    id: root

    function executeCommand() {
        executable.exec(plasmoid.configuration.command);
    }

    width: units.gridUnit * 10
    height: units.gridUnit * 4
    Plasmoid.fullRepresentation: null
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.ShadowBackground | PlasmaCore.Types.ConfigurableBackground

    Plasmoid.compactRepresentation: CompactRepresentation {
    }

}
