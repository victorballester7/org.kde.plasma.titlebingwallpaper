import QtQuick 2.6
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.1
import org.kde.kquickcontrolsaddons 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.plasmoid 2.0

Item {
    // Plasmoid.toolTipItem: Loader {
    //     id: tooltipLoader
    //     source: ""
    // }

    id: root

    property string bing: "https://www.bing.com/search?q="
    property string duckduckgo: "https://duckduckgo.com/?q="
    property string ecosia: "https://www.ecosia.org/search?q="
    property string google: "https://www.google.com/search?q="
    property string qwant: "https://www.qwant.com/?q="
    property string startpage: "https://www.startpage.com/do/search?q="

    function executeCommand(text) {
        let command = "";
        if (plasmoid.configuration.searchEngine === "bing")
            command = bing;
        else if (plasmoid.configuration.searchEngine === "duckduckgo")
            command = duckduckgo;
        else if (plasmoid.configuration.searchEngine === "ecosia")
            command = ecosia;
        else if (plasmoid.configuration.searchEngine === "google")
            command = google;
        else if (plasmoid.configuration.searchEngine === "qwant")
            command = qwant;
        else if (plasmoid.configuration.searchEngine === "startpage")
            command = startpage;
        command += text.replace(/ /g, "+"); // replace spaces with +
        command = "xdg-open " + command;
        executable.exec(command);
    }

    // this removes the tooltip shown when hovering over the plasmoid
    Plasmoid.toolTipSubText: ""
    Plasmoid.toolTipMainText: ""
    Plasmoid.backgroundHints: PlasmaCore.Types.ShadowBackground | PlasmaCore.Types.ConfigurableBackground
    width: units.gridUnit * 10
    height: units.gridUnit * 4
    Plasmoid.fullRepresentation: null
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    PlasmaCore.DataSource {
        id: executable

        function exec(cmd) {
            executable.connectSource(cmd);
        }

        engine: "executable"
        connectedSources: []
        onNewData: disconnectSource(sourceName)
    }

    Plasmoid.compactRepresentation: CompactRepresentation {
    }

}
