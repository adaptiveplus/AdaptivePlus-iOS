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
pod 'AdaptivePlus-iOS', '2.0.10'
```
and run following command.

```bash
$ pod install
```

## Usage

#### 1. Put following code to your AppDelegate.swift file (or in any suitable place to initialize SDK)
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let settings = AdaptivePlusSettings(
        url: "YOUR_ADAPTIVE_PLUS_API_URL",
        clientId: "YOUR_CLIENT_ID",
        clientSecret: "YOUR_CLIENT_SECRET",
        apiKey: "YOUR_API_KEY"
    )
    AdaptivePlus.initialize(settings: settings, verbose: true/false)

    return true
}
```
1. Create ```AdaptivePlusSettings``` with ```apiKey``` and other credentials that you received upon account registration
2. Initialize SDK with your AdaptivePlusSettings and optional boolean field (default value is 'false') 'verbose', when set to 'true' allows to observe network logs of the SDK

#### 2. Set locale of SDK as follows
```swift
AdaptivePlus.instance.set(language: .en)
```
Default locale is `.default`, which takes your app's preferred locale.
It can take one of the following values `.en/.ru/.kz/.default`.

#### 3. Start SDK
```swift
let user = AdaptivePlusUser(userId: {String?})

AdaptivePlus.start(user: user, completion: { isStarted in
    if isStarted {
        print("AdaptivePlus started successfully")
    } else {
        print("AdaptivePlus did not start")
    }
})
```
Method takes 2 optional arguments:
1) AdaptivePlusUser - user of your system/service, useful for identifying the same user across multiple devices 
2) Completion - completion handler which will be called after start method completed with boolean `isStarted`.

#### 4. Create and use APView
```swift
let apView = APView(publicationPageKey: "YOUR_PUBLICATION_PAGE_KEY")
view.addSubview(apView)
NSLayoutConstraint.activate([
    apView.leftAnchor.constraint(equalTo: leftAnchor),
    apView.rightAnchor.constraint(equalTo: rightAnchor),
    apView.centerYAnchor.constraint(equalTo: centerYAnchor)
])
```
Note that the height of `APView` will be calculated automatically and it's constraint should not be set by the developer.

#### 5. Create and use APViewless for instructions
```swift
let apViewless = APViewless(publicationPageKey: "YOUR_PUBLICATION_PAGE_KEY")

func preloadContents() {
    apViewless.preloadContents()
}

func showStory() {
    apViewless.showStory()
}
```
Note that the method ```preloadContents()``` should be called  before method ```showStory()```. If ```showStory()``` gets called before ```preloadContents()``` nothing will be shown.


## More info about AdaptivePlus SDK features
### AdaptivePlus Personalized Experience
To make SDK experience more personalized, you can provide following user data to `AdaptivePlusUser`:
```swift
let user = AdaptivePlusUser(
    // In app Client Identifier (Email/Phone/Internal user id)
    userId: "test user id",
    // Client location (latitude & longitude)
    userCoordinate: CLLocationCoordinate2D(latitude: 10.0, longitude: 123.0),
    // Clinet gender
    gender: AdaptivePlusUser.Gender.male,
    // Client age
    age: 22,
    // In app Client Properties (Country/VIP Status, etc)
    properties: ["education": "Bachelor", "country": "Kazakhstan"])
```
`userId: String?` - In app Client Identifier (Email/Phone/Internal user id)\
`userCoordinate: CLLocationCoordinate2D?` - user location (latitude & longitude). Required to display geo-oriented content to the user\
`properties: [String: String]?` - user properties, e.g. - country, education, etc. User properties help SDK to select and show content relevant to the user

### APView
* You can reload the content of an `APView` via corresponding method:
```swift
apView.reload()
```
* You can implement `APViewDelegate` and set `delegate` property of `APView` as follows:
```swift
extension YourClass {
    func setAPViewDelegate() {
        apView.delegate = self
    }
}

extension YourClass: APViewDelegate {
    func apViewDidUpdateContent(view: APView) {
        // handle content update action
    }

    func apViewDidTriggerCustomAction(view: APView, name: String, parameters: [String : Any]) {
        // implementation of AdaptivePlus CustomAction
    }
}
```

### APViewless
* You can implement `APViewlessDelegate` and set `delegate` property of `APViewless` as follows:
```swift
extension YourClass {
    func setAPViewlessDelegate() {
        apViewless.delegate = self
    }
}

extension YourClass: APViewlessDelegate {
    func apViewlessDidFinishStories(viewless: APViewless) {
        // do some your actions when story closed if needed
    }

    func apViewlessDidTriggerCustomAction(name: String, parameters: [String: Any]) {
        // implementation of AdaptivePlus CustomAction
    }
}
```
Note that the method ```apViewlessDidFinishStories``` gets called after ```showStory()``` even it didn't show any story.

### AdaptivePlus Verbose Mode
To observe network logs of the SDK - pass `true` to `verbose` method:
```swift
AdaptivePlus.initialize(settings: adaptivePlusSettings, verbose: true)
```
Do not forget to switch *Verbose Mode* off for the release build of your app.

## AdaptivePlus-iOS SDK (2.0.10)
1) Shows SDK generated content: able to display Images & GIFs & Texts, execute simplest set of actions on click, etc.
2) Action list contains:\
(1) *Web URL Opening in WebView dialog window*,\
(2) *DeepLink call to any application in iOS*,\
(3) *Send SMS & Call Phone*,\
(4) *Custom action*
