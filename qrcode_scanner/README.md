# qrcode_scanner

QR Code Scanner is a Flutter app to help you scan QR code. It is made with Flutter (visit https://flutter.io/) and it is just for educational purposes.


<img src="http://i66.tinypic.com/5ut8j.jpg">

<img src="http://i64.tinypic.com/2uo1ezs.jpg">

<img src="http://i67.tinypic.com/2z569kz.jpg">


### Android

For Android, you have to do this in order to run the application (it is already done in this app):

* Add the camera permission to your AndroidManifest.xml, just below the Internet permission.

  `<uses-permission android:name="android.permission.CAMERA" />`

* Add the Barcode activity to your AndroidManifest.xml so that you can launch the QR scanner with your camera
  `<activity android:name="com.apptreesoftware.barcodescan.BarcodeScannerActivity"/>`

### iOS

And for iOS, open the file Info.plist located in the Runner directory.

    <key>NSCameraUsageDescription</key>
    <string>Camera permission is required for QR scanning</string>

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).
