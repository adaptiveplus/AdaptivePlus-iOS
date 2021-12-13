//
//  UserConfigViewController.swift
//  AdaptivePlusQAApp
//
//  Created by Alpamys Duimagambetov on 13.05.2021.
//

import UIKit

final class UserConfigViewController: UIViewController {
    
    // MARK: - Parameters

    var userConfig: UserConfig!

    var localeItems = ["DEFAULT", "EN", "RU", "KZ"]
    var genderItems = ["MALE", "FEMALE"]
    
    // MARK: - UI

    lazy var userIdTextField: UITextField = {
        let textField = UITextField()
        textField.text = userConfig.userId
        textField.placeholder = "user id"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()

    lazy var ageTextField: UITextField = {
        let textField = UITextField()
        textField.text = String(userConfig.age)
        textField.placeholder = "age"
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()

    lazy var genderSegmentedControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: genderItems)
        segmentControl.selectedSegmentIndex = userConfig.gender == genderItems[0] ? 0 : 1
        if #available(iOS 13.0, *) {
            segmentControl.selectedSegmentTintColor = .systemGreen
        } else {
            segmentControl.tintColor = .systemGreen
        }
        return segmentControl
    }()

    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "gender: "
        return label
    }()

    lazy var localeSegmentedControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: localeItems)
        var index = localeItems.firstIndex { userConfig.locale == $0 }
        segmentControl.selectedSegmentIndex = index ?? 0
        if #available(iOS 13.0, *) {
            segmentControl.selectedSegmentTintColor = .systemGreen
        } else {
            segmentControl.tintColor = .systemGreen
        }
        return segmentControl
    }()

    lazy var localeLabel: UILabel = {
        let label = UILabel()
         
        label.text = "locale: "
        return label
    }()

    lazy var latitudeTextField: UITextField = {
        let textField = UITextField()
        if let latitude = userConfig.latitude {
            textField.text = String(latitude)
        }
        textField.placeholder = "latitude"
        textField.keyboardType = .decimalPad
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()

    lazy var longitudeTextField: UITextField = {
        let textField = UITextField()
        if let longitude = userConfig.longitude {
            textField.text = String(longitude)
        }
        textField.placeholder = "longitude"
        textField.keyboardType = .decimalPad
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    // MARK: - Life cycle

    init(userConfig: UserConfig) {
        super.init(nibName: nil, bundle: nil)
        self.userConfig = userConfig
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SUBMIT", style: .plain, target: self, action: #selector(submit))

        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        setupViews()
    }
    
    // MARK: - Functions

    func setupViews() {
        view.add(subviews: userIdTextField, ageTextField, genderLabel,
                 genderSegmentedControl, localeLabel, localeSegmentedControl,
                 latitudeTextField, longitudeTextField)

        userIdTextField.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            } else {
                $0.top.equalToSuperview().offset(16)
            }
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
        }

        ageTextField.snp.makeConstraints {
            $0.top.equalTo(userIdTextField.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
        }

        genderLabel.snp.makeConstraints {
            $0.top.equalTo(ageTextField.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
        }

        genderSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
        }

        localeLabel.snp.makeConstraints {
            $0.top.equalTo(genderSegmentedControl.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
        }

        localeSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(localeLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
        }
        
        latitudeTextField.snp.makeConstraints {
            $0.top.equalTo(localeSegmentedControl.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
        }

        longitudeTextField.snp.makeConstraints {
            $0.top.equalTo(latitudeTextField.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
        }
    }
}

// MARK: - Actions

extension UserConfigViewController {
    @objc func submit() {
        let config = UserConfig(
            userId: userIdTextField.text!,
            gender: genderItems[genderSegmentedControl.selectedSegmentIndex],
            age: Int(ageTextField.text!) ?? 20,
            locale: localeItems[localeSegmentedControl.selectedSegmentIndex],
            latitude: Double(latitudeTextField.text?.replacingOccurrences(of: ",", with: ".") ?? "-"),
            longitude: Double(longitudeTextField.text?.replacingOccurrences(of: ",", with: ".") ?? "-")
        )
        if let encoded = try? JSONEncoder().encode(config) {
            UserDefaults.standard.set(encoded, forKey: "userConfig")
        }
        navigationController?.popViewController(animated: true)
    }
}
