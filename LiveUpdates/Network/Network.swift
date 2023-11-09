//
//  Network.swift
//  LiveUpdates
//
//  Created by Tales Souza on 09/11/23.
//

import Foundation

struct Network {
    
    // MARK: - Stored Properties
    static private var apiKey = "b178fa4d19eea674608ffc8590dd45d9"
    static var api = "https://api.the-odds-api.com/v4/sports/upcoming/odds/?regions=eu&markets=h2h&apiKey=\(apiKey)"
}
