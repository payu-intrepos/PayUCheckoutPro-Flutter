# PayUCheckoutPro-Flutter

### Flutter Plugin to implement PayUMoney Latest CheckoutPro SDK in Android & iOS App.

### Step 1: Android Implementation

There are few steps you need to follow to implement PayUMoney SDK:

- Open file **android/app/build.gradle** in your flutter project and update **minSdkVersion** under "defaultConfig" to **21** (if greater than leave)

- Open **AndroidManifest.xml** located at **android/app/src/main** and add following code:

```java

xmlns:tools="http://schemas.android.com/tools"

```

```java

<manifest xmlns:android="http://schemas.android.com/apk/res/android"

xmlns:tools="http://schemas.android.com/tools" <--- paste here

package="yourPackageName">

```

_also add this code:_

```java

tools:replace="android:label"

```

```java

<application

android:name="io.flutter.app.FlutterApplication"

android:label="YourAppName"

tools:replace="android:label" <-- Paste here

android:icon="@mipmap/ic_launcher">

```

### Step 2: iOS Implementation

<-- No additional steps required for iOS -->

### Step 3: Flutter Implementation

Run this command in project terminal to add dependency

`flutter pub add payu_checkoutpro_flutter`

[ Visit For Code Integration ](https://devguide.payu.in/flutter-sdk-integration/payu-checkout-pro-flutter/integration-with-checkout-pro-flutter-app/)

