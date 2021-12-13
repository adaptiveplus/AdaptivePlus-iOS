//
//  UserConfig.swift
//  AdaptivePlusQAApp
//
//  Created by Alpamys Duimagambetov on 13.05.2021.
//

import Foundation

struct UserConfig: Codable, Equatable {
    var userId: String
    var gender: String
    var age: Int
    var locale: String
    var latitude: Double?
    var longitude: Double?
}
