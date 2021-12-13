//
//  APViewsViewController.swift
//  AdaptivePlusQAApp
//
//  Created by a1pamys on 15.03.2021.
//

import UIKit
import AdaptivePlus
import CoreLocation

final class APViewsViewController: UIViewController {
    
    // MARK: - Paremeters
    
    private let channelSecret: String

    var tags: [String] {
        set { UserDefaults.standard.setValue(newValue, forKey: "\(channelSecret)/tags") }
        get { (UserDefaults.standard.array(forKey: "\(channelSecret)/tags") as? [String]) ?? [] }
    }
    
    // MARK: - UI

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let instructionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Instructions", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(openInstruction), for: .touchUpInside)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    // MARK: - Life cycle

    init(channelSecret: String) {
        self.channelSecret = channelSecret
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupNavigationBar()
        setupViews()

        tags.forEach { addContainerViewToStackViewWith($0) }

        print("token: \(AdaptivePlus.getAuthorizationToken())")
    }
    
    // MARK: - Functions

    func addContainerViewToStackViewWith(_ tag: String) {
        let containerView = ContainerView(publicationPageKey: tag)
        containerView.apView.delegate = self

        stackView.addArrangedSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        containerView.removed = { [weak self, weak containerView] in
            guard let self = self, let containerView = containerView else { return }
            self.stackView.removeArrangedSubview(containerView)
            containerView.removeFromSuperview()
            self.tags = self.tags.filter { $0 != tag }
        }
    }
}

// MAKR: - Private functions

private extension APViewsViewController {
    func setupNavigationBar() {
        title = "AP: v2"
        let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload))
        let scrollButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(scrollToStart))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPublicationPage))
        navigationItem.rightBarButtonItems = [reloadButton, scrollButton, addButton]
    }

    func setupViews() {
        view.addSubview(instructionsButton)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            instructionsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            instructionsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            instructionsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            instructionsButton.heightAnchor.constraint(equalToConstant: 30),

            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: instructionsButton.bottomAnchor, constant: 16),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

// MARK: - Actions

private extension APViewsViewController {
    @objc func addPublicationPage() {
        let alert = UIAlertController(
            title: "Add a publication page key",
            message: "Enter last 3 digits of your key: APV-00000***",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.text = ""
        }
         
        let alertAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { [weak self, weak alert] _ in
                guard let self = self, let text = alert?.textFields?.first?.text else { return }
                let tag = "APV-00000" + text
                self.tags = self.tags + [tag]
                self.addContainerViewToStackViewWith(tag)
            }
        )

        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }

    @objc func reload() {
        for view in stackView.arrangedSubviews {
            if let containerView = view as? ContainerView {
                containerView.apView.reload()
            }
        }
    }

    @objc func scrollToStart() {
        for view in stackView.arrangedSubviews {
            if let containerView = view as? ContainerView {
                containerView.apView.scrollToStart()
            }
        }
    }

    @objc func openInstruction() {
        navigationController?.pushViewController(InstructionViewController(), animated: true)
    }
}

// MARK: - APViewDelegate

extension APViewsViewController: APViewDelegate {
    func apViewDidUpdateContent(view: APView) {
        print("contentUpdated: ", view)
    }

    func apViewDidTriggerCustomAction(view: APView, name: String, parameters: [String: Any]) {
        let alert = UIAlertController(title: "CUSTOM ACTION \(name)", message: "\(parameters)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
