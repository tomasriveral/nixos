import Quickshell
import QtQuick
import "bar" as Bar
import "notifs" as Notifs
//import "launcher" as Launcher
import "screenshot" as Screenshot
//import "lock" as Lock

ShellRoot {
    //Bg {}

    Bar.Bar {
        id: bar
    }

    Notifs.Overlay {
        bar: bar
    }

    Component.onCompleted: () => {
        //Launcher.Controller.init();
        Screenshot.Controller.init();
        //Lock.Controller.init();
    }
}
