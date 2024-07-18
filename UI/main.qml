import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

ApplicationWindow {

    id: rootWindow
    visible: true
    width: 200
    height: 300

    flags: Qt.FramelessWindowHint | Qt.Window

    title: "202020"

    property string currTime: "00:00:00"
    property string breakCountdown: "00"
    property string breakCountdownText: 'Break in: ' + breakCountdown +' seconds'
    property string breakCountdownColor: "transparent"
    property string breakPromptColor: "white"
    property QtObject backend
    property string imagePath: "./Images/image1.jpg"

    Component.onCompleted: {
        x = Screen.width - width - 20
        y = Screen.height - height - 20
    }

    Rectangle {
        id: mainRect
        width: parent.width
        height: parent.height
        color: "transparent"

        MouseArea {
    id: dragArea
    anchors.fill: parent
    cursorShape: Qt.OpenHandCursor

    property int dragStartX: 0
    property int dragStartY: 0

    onPressed: {
        dragStartX = mouse.x;
        dragStartY = mouse.y;
        dragArea.cursorShape = Qt.ClosedHandCursor;
    }

    onReleased: {
        dragArea.cursorShape = Qt.OpenHandCursor;
        rootWindow.x += mouse.x - dragStartX;
        rootWindow.y += mouse.y - dragStartY;
    }

    onPositionChanged: {
        rootWindow.x += mouse.x - dragStartX;
        rootWindow.y += mouse.y - dragStartY;
        dragStartX = mouse.x;
        dragStartY = mouse.y;
    }
}

        Image {
            anchors.fill: parent
            source: imagePath
            fillMode: Image.PreserveAspectCrop
        }

        Text {
            anchors {
                top: parent.top
                topMargin: 12
                right: parent.right
                rightMargin: 12
            }
            text: currTime
            font.pixelSize: 24
            font.family: "Helvetica"
            color: "white"
        }

        Text {
            anchors {
                top: parent.top
                topMargin: 14
                left: parent.left
                leftMargin: 14
            }
            text: breakCountdownText
            font.pixelSize: 20
            color: breakCountdownColor
        }

        Text {
            anchors {
                bottom: parent.bottom
                bottomMargin: 14
                left: parent.left
                leftMargin: 14
            }
            text: "Rest your eyes :)"
            font.pixelSize: 14
            color: breakPromptColor
        }
    }

    Connections {
        target: backend

        function onUpdated(msg) {
            currTime = msg;
        }
        function onSecondUpdated(msg){
            breakCountdown = msg;
        }
        function onBreakTextUpdated(msg){
            breakCountdownColor = msg;
        }
        function onPromptTextUpdated(msg){
            breakPromptColor = msg;
        }
        function onBringToFrontUpdated(msg){
            raise();
        }
    }
}
