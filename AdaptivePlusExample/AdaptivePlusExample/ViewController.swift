//
//  ViewController.swift
//  AdaptivePlusExample
//
//  Created by Yerassyl Yerlanov on 20.04.2021.
//

import UIKit
import AdaptivePlus

class ViewController: UIViewController {

    var apView: APView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupApativeView()
    }

    func setupApativeView() {
        apView = AdaptivePlus.instance.createAPView()
        view.addSubview(apView)

        NSLayoutConstraint.activate([
            apView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            apView.leftAnchor.constraint(equalTo: view.leftAnchor),
            apView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

    }

    @IBAction func reloadButtonTouched(_ sender: Any) {
        apView.reload()
    }

    @IBAction func scrollToStart(_ sender: Any) {
        apView.scrollToStart()
    }

}

