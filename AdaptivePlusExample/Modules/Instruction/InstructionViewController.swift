//
//  InstructionViewController.swift
//  AdaptivePlusQAApp
//
//  Created by Yerassyl Yerlanov on 04.08.2021.
//

import UIKit
import AdaptivePlus
import SnapKit

final class InstructionViewController: UIViewController {
    
    // MARK: - Parameters
    
    var publicationPageKey: String? {
        set { UserDefaults.standard.setValue(newValue, forKey: "asd") }
        get { UserDefaults.standard.string(forKey: "asd") }
    }

    private var apViewless: APViewless! {
        didSet {
            apViewless.delegate = self
        }
    }
    
    // MARK: - UI

    private let textField: UITextField = {
        let textField = UITextField()
         
        textField.placeholder = "Enter last 3 digits of key"
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
        return textField
    }()

    private let preloadButton: UIButton = {
        let button = UIButton()
         
        button.setTitle("Preload", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(preloadInstructions), for: .touchUpInside)
        return button
    }()

    private let showButton: UIButton = {
        let button = UIButton()
         
        button.setTitle("Show", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(showActionTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        apViewless = APViewless(publicationPageKey: publicationPageKey ?? "")
        textField.text = publicationPageKey?.replacingOccurrences(of: "APV-00000", with: "")

        view.backgroundColor = .white
        view.add(subviews: textField, preloadButton, showButton)

        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        preloadButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(44)
        }
        showButton.snp.makeConstraints {
            $0.top.equalTo(preloadButton.snp.bottom).offset(16)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(44)
        }
    }
}

// MARK: - APViewlessDelegate

extension InstructionViewController: APViewlessDelegate {
    func apViewlessDidFinish(viewless: APViewless) {
         
        let alert = UIAlertController(
            title: "Finished",
            message: "This is callback",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }

    func apViewlessDidTriggerCustomAction(name: String, parameters: [String: Any]) {
         
        let alert = UIAlertController(
            title: "CUSTOM ACTION \(name)",
            message: "\(parameters)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Actions

private extension InstructionViewController {
    @objc func preloadInstructions() {
        apViewless.preloadContents()
    }

    @objc func showActionTapped() {
        apViewless.show()
    }

    @objc func valueChanged() {
        publicationPageKey = "APV-00000" + (textField.text ?? "")
        apViewless = APViewless(publicationPageKey: publicationPageKey ?? "")
    }
}
