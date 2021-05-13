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
pod 'AdaptivePlus-iOS'
```
and run following command.

```bash
$ pod install
```

## Usage

#### 1. Put following code to your AppDelegate.swift file
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // #1
    let settings = AdaptivePlusSettings(apiKey: "YOUR_API_KEY")
    
    // #2
    AdaptivePlus.instance.initialize(settings: settings, verbose: true/false)
    
    // #3
    let properties = AdaptivePlusUserProperties(
        // In app Client Identifier (Email/Phone/Internal user id)
        userId: nil,
        userCoordinate: nil,
        // In app Client Properties (Age/Gender/Country/VIP Status, etc)
        properties: [
            "gender": "MALE",
            "age": "20"
        ])
        
    // #4
    AdaptivePlus.instance.start(properties: properties)

    return true
}
```
1. Set AdaptivePlus Settings where apiKey is the apiKey from your admin panel on https://adaptive.plus/
2. Initialize SDK with your AdaptivePlusSettings and optional boolean field (default value is 'false') 'verbose', when set to 'true' allows to see server response in debugging console
3. Set AdaptivePlus user properties, where all fields are optional and are 'nil' by default
4. Start AdaptivePlus SDK with your user properties

#### 2. Create AdaptivePlus views and add to your code
```swift
// Example
class ViewController: UIViewController {

    var apView: APView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAdaptiveView()
    }

    func setupAdaptiveView() {
        apView = AdaptivePlus.instance.createAPView()
        
        view.addSubview(apView)

        NSLayoutConstraint.activate([
            apView.leftAnchor.constraint(equalTo: view.leftAnchor),
            apView.rightAnchor.constraint(equalTo: view.rightAnchor),
            apView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
```

