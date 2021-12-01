import QtQuick 2.15
import QtQuick.Controls 2.15
ApplicationWindow {
    visible: true
    width: 400
    height: 600
    title: "202020"

    property string currTime: "00:00:00" // A variable for storing current time (from our python file)

    //Break countdown stuff
    property string breakCountdown: "00"
    property string breakCountdownText: 'Break in: ' + breakCountdown +' seconds'
    property string breakCountdownColor: "transparent"
    property string breakPromptColor: "white"

    property QtObject backend // a variable for receiving our backend object
    property string imagePath: "./Images/image1.jpg"
    
    Rectangle {
        anchors.fill: parent
        Image {
            sourceSize.width: parent.width
            sourceSize.height: parent.height
            source: imagePath
            fillMode: Image.PreserveAspectCrop
        }
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            Text {
                anchors {
                    top: parent.top
                    topMargin: 12
                    right: parent.right
                    rightMargin: 12
                }
                text: currTime //earlier we had specified a string : '2123'
                font.pixelSize: 24
                color: "white"
            }
            
            Text {
                anchors {
                    top: parent.top
                    topMargin: 14

                    left: parent.left
                    leftMargin: 14
                }
                text: breakCountdownText //earlier we had specified a string : '2123'
                font.pixelSize: 20
                color: breakCountdownColor
            }

            Text {
                anchors {
                    top: parent.top
                    topMargin: 14

                    left: parent.left
                    leftMargin: 14
                }
                text: "Rest your eyes :)" //earlier we had specified a string : '2123'
                font.pixelSize: 20
                color: breakPromptColor
            }
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
    }
}


// Previous Obsolete Renditions:

// A basic window:

// import QtQuick 2.15
// import QtQuick.Controls 2.15
// ApplicationWindow {
//     visible: true
//     width: 600
//     height: 500
//     title: "202020"
//     Text {
//         anchors.centerIn: parent
//         text: "Hey there :)"
//         font.pixelSize: 24
//     }
// }