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

    // Use an Api Key generated from the adaptive.plus admin panel, go to "Integrations"
    let apiKey = "kz2SNtDdQcCMACvh"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let settings = AdaptivePlusSettings(
            url: "", // Your url
            clientId: "", // Your client id
            clientSecret: "", // Your client secret
            apiKey: apiKey
        )
        AdaptivePlus.initialize(settings: settings, verbose: true)
        return true
    }

}

