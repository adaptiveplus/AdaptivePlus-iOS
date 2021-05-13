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
        apView.delegate = self
        
        view.addSubview(apView)

        NSLayoutConstraint.activate([
            apView.leftAnchor.constraint(equalTo: view.leftAnchor),
            apView.rightAnchor.constraint(equalTo: view.rightAnchor),
            apView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension ViewController: APViewDelegate {
    func didUpdateContent(view: APView) {
        // continue logic after apView did update content
    }
}
```

Now, you can visit your https://adaptive.plus/ admin panel and create some content. Do not forget to change the status of the content to active. Refresh the app page containing the APView. You should be able to observe the created content in your app.

If you are not able to observe the created content - probable reasons are:
- You forgot to activate the content in the AdaptivePlus admin panel
- Check again the integration guide, maybe you missed something out

## More info about AdaptivePlus SDK features
### AdaptivePlus SDK switching off
If at some point your app no longer needs the AdaptivePlus services, you can stop the work of it:
```
    AdaptivePlus.instance.stop()
```
### Removing cached data
To delete AdaptivePlus cached data:
```
    AdaptivePlus.instance.removeCachedData()
```
### AdaptivePlusView
To refresh the content of an APView:
```
    apView.reload()
```
To scroll APView content to start:
```
    apView.scrollToStart()
```
    
## AdaptivePlus-iOS SDK (v2.0.0)
Shows Instagram-like stories where you are able to display:
 - images
 - GIFs
 - texts
 - execute simplest set of actions on click/swipe

Action list contains:
1. Web URL Opening in WebView dialog window,
2. Custom Action (should be implemented, nothing will happen otherwise)
