import QtQuick 2.15
import QtQuick.Controls 2.15
ApplicationWindow {
    visible: true
    width: 400
    height: 600
    title: "HelloApp"

    property string currTime: "00:00:00" // A variable for storing current time (from our python file)
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