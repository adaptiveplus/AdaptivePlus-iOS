//
//  ViewController.swift
//  AdaptivePlusExample
//
//  Created by Yerassyl Yerlanov on 20.04.2021.
//

import UIKit
import AdaptivePlus

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        showSplashScreen()
    }

    func showSplashScreen() {
        let user = AdaptivePlusUser(
            // In app Client Identifier (Email/Phone/Internal user id)
            userId: nil,
            // Client location
            userCoordinate: nil,
            // In app Client Properties (Age/Gender/Country/VIP Status, etc)
            properties: ["gender": "MALE", "age": "20"])

        let customActionTriggered: ((String, [String : Any]) -> Void) = { name, parameters in
            print("Custom action triggered with name: \(name) and parameters: \(parameters)")
        }

        let splashScreenFinished: (() -> Void) = {
            print("Splash screen finished")
        }

        AdaptivePlus.showSplashScreen(
            user: user, // optional
            hasDrafts: true, // optional, default value - false
            customActionTriggered: customActionTriggered, // optional
            finished: splashScreenFinished // optional
        )
    }

    @IBAction func showSplashScreenTouched(_ sender: Any) {
        showSplashScreen()
    }

}

