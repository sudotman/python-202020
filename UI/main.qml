import QtQuick 2.15
import QtQuick.Controls 2.15
ApplicationWindow {
    visible: true
    width: 400
    height: 600
    title: "202020"

    property string currTime: "00:00:00" // A variable for storing current time (from our python file)
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
        }
    }

    Connections {
        target: backend

        function onUpdated(msg) {
            currTime = msg;
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