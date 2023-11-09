//
//  Bookmakers.swift
//  LiveUpdates
//
//  Created by Tales Souza on 08/11/23.
//

import Foundation

struct Bookmakers: Codable {
    
    var key: String?
    var title: String?
    var last_update: Date?
    var markets: [Market]
}
