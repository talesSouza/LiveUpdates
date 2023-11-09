//
//  Market.swift
//  LiveUpdates
//
//  Created by Tales Souza on 08/11/23.
//

import Foundation

struct Market: Codable, Hashable {
    
    var key: String?
    var last_update: Date
    var outcomes: [Outcome]
}
