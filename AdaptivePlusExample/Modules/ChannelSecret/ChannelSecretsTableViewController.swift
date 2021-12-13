//
//  ChannelSecretsTableViewController.swift
//  AdaptivePlusQAApp
//
//  Created by Alpamys Duimagambetov on 21.04.2021.
//

import AdaptivePlus
import UIKit
import CoreLocation

final class ChannelSecretsTableViewController: UITableViewController {
    
    // MARK: - Parameters
    
    private let cellId = "cellId"
    private let userDefaultsKey = "channelSecretsArray"
    
    private var channelSecretsArray: [String] = .init()
    private var userConfig: UserConfig = UserConfig(
         
        userId: UIDevice.current.identifierForVendor?.uuidString ?? "Unknown device id",
        gender: "MALE",
        age: 20,
        locale: "")
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        checkForFirstLaunch()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchChannelSecretsFromUserDefaults()
        title = "userId: " + userConfig.userId
    }
}

// MARK: - Private functions

private extension ChannelSecretsTableViewController {
    func checkForFirstLaunch() {
        let isLaunchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if isLaunchedBefore == false {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            saveChannelSecretsToUserDefaults()
        }
    }

    func saveChannelSecretsToUserDefaults() {
        UserDefaults.standard.setValue(channelSecretsArray, forKey: userDefaultsKey)
        UserDefaults.standard.synchronize()
    }

    func fetchChannelSecretsFromUserDefaults() {
        if let channelSecretsArray = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] {
            self.channelSecretsArray = channelSecretsArray
            tableView.reloadData()
        }

        if let data = UserDefaults.standard.object(forKey: "userConfig") as? Data,
           let userConfig = try? JSONDecoder().decode(UserConfig.self, from: data) {
            self.userConfig = userConfig
        }
    }
    
    func setup() {
        setupNavigationBar()
        setupTableView()
    }

    func setupNavigationBar() {
        title = "AP: v2"
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(openUserConfig)),
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addChannelSecret))
        ]
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

// MARK: - TableView functions

extension ChannelSecretsTableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            channelSecretsArray.remove(at: indexPath.row)
            saveChannelSecretsToUserDefaults()
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelSecretsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        cell.textLabel?.text = channelSecretsArray[indexPath.row]
        return cell
    }
}

// MARK: - TableView functions

extension ChannelSecretsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelSecret = channelSecretsArray[indexPath.row]

        let settings = AdaptivePlusSettings(
            url: "", /// Your `URL`
            clientId: "", /// Your `clientId`
            clientSecret: "", /// Your `clientSecret`
            apiKey: channelSecret
        )
        
        AdaptivePlus.initialize(settings: settings, verbose: true)
        var locale: APLanguage = .default
        if userConfig.locale == "EN" {
            locale = .en
        } else if userConfig.locale == "RU" {
            locale = .ru
        } else if userConfig.locale == "KZ" {
            locale = .kz
        } else {
            locale = .default
        }

        AdaptivePlus.set(language: locale)

        var location: CLLocationCoordinate2D?
        if let lat = userConfig.latitude, let long = userConfig.longitude {
            location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        let user = AdaptivePlusUser(
            userId: userConfig.userId,
            gender: AdaptivePlusUser.Gender(rawValue: userConfig.gender),
            age: userConfig.age,
            userCoordinate: location
        )

        AdaptivePlus.start(user: user, completion: nil)
        let vc = APViewsViewController(channelSecret: channelSecret)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Actions

private extension ChannelSecretsTableViewController {
    @objc func addChannelSecret() {
         
        let alert = UIAlertController(
            title: "Add a channel secret",
            message: "Enter your channel secret to get your content",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.text = ""
        }
        
         
        let alertAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { [weak self, weak alert] _ in
                guard let self = self, let text = alert?.textFields?.first?.text, !text.isEmpty else { return }
                self.channelSecretsArray.append(text)
                self.saveChannelSecretsToUserDefaults()
                self.tableView.reloadData()
            }
        )

         
        alert.addAction(alertAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    @objc func openUserConfig() {
        let vc = UserConfigViewController(userConfig: userConfig)
        navigationController?.pushViewController(vc, animated: true)
    }
}
