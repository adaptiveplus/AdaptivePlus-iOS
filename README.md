# AdaptivePlus iOS SDK

## Introduction
**AdaptivePlus** is the control center for marketing campaigns in mobile applications.

#### Requirements
- iOS 11.0 or later
- Xcode 12.0 or later
- Swift 4.2 or later


## Installation (CocoaPods)
[CocoaPods](http://cocoapods.org/) is a dependency manage which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile
Add following to your Podfile
```
platform :ios, '11.0'
pod 'AdaptivePlus-iOS', '2.0.0'
```
and run following command.

```bash
$ pod install
```

## Usage

#### 1. Put following code to your AppDelegate.swift file
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let settings = AdaptivePlusSettings(apiKey: "YOUR_API_KEY")
    AdaptivePlus.initialize(settings: settings, verbose: true/false)
    
    return true
}
```
1. Create ```AdaptivePlusSettings``` with ```apiKey``` that you received upon account registration
2. Initialize SDK with your AdaptivePlusSettings and optional boolean field (default value is 'false') 'verbose', when set to 'true' allows to observe network logs of the SDK

#### 2. Show AdaptivePlus Splash Screen on app startup or after user log in (or at any suitable moment)
```swift
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        AdaptivePlus.showSplashScreen()
    }
}
```

Now, you can visit the admin panel and create some content. Do not forget to change the status of the content to **active**. 
On the first `showSplashScreen` method call, the SDK preloads the splash screen contents to your device, and will skip the splash screen show to avoid loading delay. On the subsequent method calls, probably, the splash screen contents are already preloaded, and the splash screen will be displayed on the screen

If you are not able to observe the created content - probable reasons are:
- You forgot to activate the content in the AdaptivePlus admin panel
- Check again the integration guide, maybe you missed something out
- The SDK couldn't preload the contents on the previous `showSplashScreen` method calls due to network issues or internal sdk issues

## More info about AdaptivePlus SDK features
### AdaptivePlus Personalized Experience
To make SDK experience more personalized, you can provide following user data:
```swift
AdaptivePlus.showSplashScreen(
    user: user,
    hasDrafts: true,
    customActionTriggered: customActionTriggered,
    finished: finished)
```
`user` - user of your system/service, useful for identifying the same user across multiple devices
```swift
let user = AdaptivePlusUser(
    // In app Client Identifier (Email/Phone/Internal user id)
    userId: "test user id",
    // Client location (latitude & longitude)
    userCoordinate: CLLocationCoordinate2D(latitude: 10.0, longitude: 123.0),
    // In app Client Properties (Age/Gender/Country/VIP Status, etc)
    properties: ["gender": "MALE", "age": "20"])
```
`userId: String?` - In app Client Identifier (Email/Phone/Internal user id)\
`userCoordinate: CLLocationCoordinate2D?` - user location (latitude & longitude). Required to display geo-oriented content to the user\
`properties: [String: String]?` - user properties, e.g. - age, gender, etc. User properties help SDK to select and show content relevant to the user

### Splash Screen Draft Campaigns
To take a look at splash screen campaigns that are on moderation (not active) state pass `hasDrafts` parameter as `true` to `showSplashScreen` method:
```swift
AdaptivePlus.showSplashScreen(hasDrafts: true)
```

### Splash Screen Callbacks
To handle splash screen callbacks you should provide:
```swift
let customActionTriggered: ((String, [String : Any]) -> Void) = { name, parameters in
    // TODO: your implementation of Adaptive Plus Custom Action
}

let splashScreenFinished: (() -> Void) = {
    // TODO: actions to do on the splash screen finish
}
AdaptivePlus.showSplashScreen(
    customActionTriggered: customActionTriggered,
    finished: splashScreenFinished
)
```
### AdaptivePlus Debug Mode
To observe network logs of the SDK - pass `true` to `verbose` method:
```swift
AdaptivePlus.initialize(settings: AdaptivePlusSettings(apiKey: apiKey), verbose: true)
```
Do not forget to switch *Debug Mode* off for the release build of your app.

## AdaptivePlus-iOS SDK (v2.0.0)
1) Shows SDK generated Splash Screen with countdown timer: able to display Images & GIFs & Texts, execute simplest set of actions on click, etc.
2) Action list contains:\
(1) *Web URL Opening in WebView dialog window*,\
(2) *DeepLink call to any application in iOS*,\
(3) *Send SMS & Call Phone*,\
(4) *Custom action*
