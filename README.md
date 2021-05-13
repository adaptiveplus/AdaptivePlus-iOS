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
    // 1 SDK initialization
    AdaptivePlus.instance.initialize(settings: AdaptivePlusSettings(apiKey: apiKey))
    // Set user properties which will be idendified by AdaptivePlus
    let properties = AdaptivePlusUserProperties(
        //In app Client Identifier (Email/Phone/Internal user id)
        userId: nil,
        //In app Client Properties (Age/Gender/Country/Vip Status, etc)
        userCoordinate: nil,
        properties: [
            "gender": "MALE",
            "age": "20"
        ])
    // 2 SDK start with user properties
    AdaptivePlus.instance.start(properties: properties)

    return true
}
AdaptivePlus.instance.initialize(settings: AdaptivePlusSettings(apiKey: apiKey))
```
where 
- apiKey is apiKey from your admin panel on https://adaptive.plus/,
- gender is either MALE or FEMALE

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
        apView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(apView)

        NSLayoutConstraint.activate([
            apView.leftAnchor.constraint(equalTo: view.leftAnchor),
            apView.rightAnchor.constraint(equalTo: view.rightAnchor),
            apView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
```

