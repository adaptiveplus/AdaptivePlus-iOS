//
//  AppDelegate.swift
//  AdaptivePlusExample
//
//  Created by Yerassyl Yerlanov on 20.04.2021.
//

import UIKit
import AdaptivePlus

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Use here your own credentials generated from AdaptivePlus admin panel
    enum Constants {
        static let url = "http://test.adaptive.plus:3000/v1/"
        static let clientId = "43f4a067-aa4b-4e19-888f-05237cf8a865"
        static let clientSecret = "BpLnfgDsc2WD8F2qNfHK5a84jjJkwzDkh9h2fhfUVuS9jZ8uVbhV3vC5AWX39IVU"
        static let channelSecret = "uHMYZLfGaEFPyynhwJyzAHyfjXUlrGhblTtxWduqtCDMLxiDHIMGFpXzpLGIehps"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let settings = AdaptivePlusSettings(url: Constants.url,
                                            clientId: Constants.clientId,
                                            clientSecret: Constants.clientSecret,
                                            channelSecret: Constants.channelSecret)
        AdaptivePlus.instance.initialize(settings: settings)
        // Set user properties which will be idendified by AdaptivePlus
        let properties = AdaptivePlusUserProperties(userId: UIDevice.current.identifierForVendor?.uuidString ?? "Unknown device id",
                                                gender: .male,
                                                age: 20)
        AdaptivePlus.instance.start(properties: properties)

        return true
    }
    

}

