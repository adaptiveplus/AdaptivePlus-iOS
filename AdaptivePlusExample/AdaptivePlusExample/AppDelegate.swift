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
    let apiKey = "GDP60U9b2QNCQVEu"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        AdaptivePlus.initialize(
            settings: AdaptivePlusSettings(apiKey: apiKey),
            verbose: false // optional, default value - false
        )
        return true
    }

}

