//
//  ViewController.swift
//  AdaptivePlusExample
//
//  Created by Yerassyl Yerlanov on 20.04.2021.
//

import UIKit
import AdaptivePlus

class ViewController: UIViewController {

//    var apView: APView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

//        setupApativeView()
        showSplashScreen()
    }

//    func setupApativeView() {
//        apView = AdaptivePlus.instance.createAPView()
//        view.addSubview(apView)
//
//        NSLayoutConstraint.activate([
//            apView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
//            apView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            apView.rightAnchor.constraint(equalTo: view.rightAnchor)
//        ])
//
//    }

    func showSplashScreen() {
        let user = AdaptivePlusUser(
            // In app Client Identifier (Email/Phone/Internal user id)
            userId: nil,
            // Client location
            userCoordinate: nil,
            // In app Client Properties (Age/Gender/Country/VIP Status, etc)
            properties: ["gender": "MALE", "age": "20"])

        let customActionTriggered: ((String, [String : Any]) -> Void) = { name, parameters in
            print("Custom action name: \(name)")
            print("Custom action parameters: \(parameters)")
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

    @IBAction func reloadButtonTouched(_ sender: Any) {
//        apView.reload()
    }

    @IBAction func scrollToStart(_ sender: Any) {
//        apView.scrollToStart()
    }

    @IBAction func showSplashScreenTouched(_ sender: Any) {
        showSplashScreen()
    }

}

