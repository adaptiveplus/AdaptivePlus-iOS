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
    // Use here your own tag id generated from AdaptivePlus admin panel
    let tagId: String = "65ff0c32-4a6f-4431-83d3-eb340f62f405"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupApativeView()
    }

    func setupApativeView() {
        apView = AdaptivePlus.instance.createAPView(with: tagId)
        view.addSubview(apView)

        NSLayoutConstraint.activate([
            apView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            apView.leftAnchor.constraint(equalTo: view.leftAnchor),
            apView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    @IBAction func reloadButtonTouched(_ sender: Any) {
        apView.reloadView()
    }

}

