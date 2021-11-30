import QtQuick 2.15
import QtQuick.Controls 2.15
ApplicationWindow {
    visible: true
    width: 400
    height: 600
    title: "HelloApp"
    Rectangle {
        anchors.fill: parent
        Image {
            sourceSize.width: parent.width
            sourceSize.height: parent.height
            source: "./Images/image1.jpg"
            fillMode: Image.PreserveAspectCrop
        }
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            Text {
                anchors {
                    bottom: parent.bottom
                    bottomMargin: 12
                    left: parent.left
                    leftMargin: 12
                }
                text: "16:38:33"
                font.pixelSize: 24
                color: "white"
            }
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