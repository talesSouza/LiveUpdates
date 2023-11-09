//
//  MarketView.swift
//  LiveUpdates
//
//  Created by Tales Souza on 08/11/23.
//

import SwiftUI

struct MarketView: View {
    
    // MARK: - Stored Properties
    var market: Market
    var oldMarket: Market?
    
    // MARK: - Computed Properties
    var lastUpdateFormatted: String {
        market.last_update.toString()
    }
    
    // MARK: - Initializers
    init(market: Market, oldMarket: Market? = nil) {
        self.market = market
        self.oldMarket = oldMarket
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Divider()
            
            VStack(alignment: .leading) {
                Text("Last update:")
                    .font(.callout)
                Text(lastUpdateFormatted)
                    .font(.headline)
            }
            .foregroundStyle(Color.black.opacity(0.7))
            
            HStack(spacing: 16) {
                ForEach(market.outcomes, id: \.self) { outcome in
                    let oldOutcomes = oldMarket?.outcomes.first(where: { $0.name == outcome.name })
                    OutcomeView(outcome: outcome,
                                status: compareOutcomes(current: outcome, old: oldOutcomes),
                                didTapButtonAction: { outcome in
                        //do what you need with the outcome
                    })
                }
            } //: HStack
        } //: Main VStack
        .padding(.vertical, 16)
    }
    
    // MARK: - Private Methods
    private func compareOutcomes(current: Outcome, old: Outcome? = nil) -> OutcomeViewStatus {
        guard let oldPrice = old?.price else {
            return .none
        }
        let difference = current.price - oldPrice
        switch difference {
        case let x where x > 0:
            return .up
        case let x where x < 0:
            return .down
        default:
            return .none
        }
    }
}

#Preview {
    MarketView(market: Market(key: "",
                              last_update: Date(),
                              outcomes: [Outcome(name: "Team 1", price: 3.5),
                                         Outcome(name: "Team 2", price: 1.7),
                                         Outcome(name: "Draw", price: 2.5)]))
}
