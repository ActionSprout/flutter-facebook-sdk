# facebook

Flutter integration for the Android and iOS Facebook SDKs.

## Installation

To install, add the following to the `dependencies` section of your `pubspec.yaml` file:

```
facebook: ^1.0.0
```

Then, ensure Flutter has installed it with `flutter pub get`.

## Setup

The first API you'll need to connect is the FacebookLogin SDK:

### Android

Follow the steps in the Facebook SDK guidelines for Android, starting after those for downloading and installing the SDK itself, which is taken care up by `flutter pub get`, above, and ending before making a change to the UI itself (e.g. "Add the Facebook Login Button").

https://developers.facebook.com/docs/facebook-login/android

### iOS

Follow the steps in the Facebook SDK guidelines for iOS, starting after those for downloading and installing the SDK itself, which is taken care up by `flutter pub get`, above, and ending before making a change to the AppDelegate (e.g. "Connect Your App Delegate").

https://developers.facebook.com/docs/facebook-login/ios
