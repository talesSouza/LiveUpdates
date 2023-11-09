//
//  Bookmarkers.swift
//  LiveUpdates
//
//  Created by Tales Souza on 08/11/23.
//

import SwiftUI

struct Game: Codable, Identifiable {
    
    var id: String?
    var sport_key: String?
    var sport_title: String
    var commence_time: Date
    var home_team: String
    var away_team: String
    var bookmakers: [Bookmakers]
}
