# tut

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



## Additional native code

error: SocketException: Insecure socket connections are disallowed by platform:

ios folder -> runner folder -> info.plist
Then add the following lines to enable HTTP requests:

<key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>

To enable in Android:
Android folder -> app -> src -> main -> AndroidManifest.xml

Add this permission:
<uses-permission android:name="android.permission.INTERNET"/>

then add the following line inside application tag:
android:usesCleartextTraffic="true"
-----------------------------------------------
