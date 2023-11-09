//
//  BookmakerView.swift
//  LiveUpdates
//
//  Created by Tales Souza on 08/11/23.
//

import SwiftUI

struct GameView: View {
    
    // MARK: - Stored Properties
    let currentGame: Game
    let oldGame: Game?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(currentGame.home_team)
                        .font(.title3)
                    Text(currentGame.away_team)
                        .font(.title3)
                }
                
                Spacer()
                Text(currentGame.sport_title)
                    .foregroundStyle(.black.opacity(0.7))
            }
            
            if let currentMarket = currentGame.bookmakers.first?.markets.first {
                let oldMarket = oldGame?.bookmakers.first?.markets.first
                MarketView(market: currentMarket, oldMarket: oldMarket)
            }
        }
    }
}

#Preview {
    GameView(currentGame: Game(sport_title: "Italy Serie B",
                               commence_time: Date(),
                               home_team: "Juventus",
                               away_team: "Milan",
                               bookmakers: [
                                Bookmakers(last_update: Date(),
                                           markets: [
                                            Market(key: "",
                                                   last_update: Date(),
                                                   outcomes: [Outcome(name: "Juventus",
                                                                      price: 3.5),
                                                              Outcome(name: "Milan",
                                                                      price: 1.7),
                                                              Outcome(name: "Draw",
                                                                      price: 2.5)
                                                   ])
                                           ])]
                              ),
             oldGame: Game(sport_title: "Italy Serie B",
                           commence_time: Date(),
                           home_team: "Juventus",
                           away_team: "Milan",
                           bookmakers: [
                            Bookmakers(last_update: Date(),
                                       markets: [
                                        Market(key: "",
                                               last_update: Date(),
                                               outcomes: [Outcome(name: "Juventus",
                                                                  price: 3.3),
                                                          Outcome(name: "Milan",
                                                                  price: 1.7),
                                                          Outcome(name: "Draw",
                                                                  price: 2.5)
                                               ])
                                       ])]
                          )
    )
}
