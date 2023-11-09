//
//  OddsBoxView.swift
//  LiveUpdates
//
//  Created by Tales Souza on 08/11/23.
//

import SwiftUI

enum OutcomeViewStatus {
    
    case up
    case down
    case none
    
    // MARK: - Computed Properties
    var color: Color {
        switch self {
        case .up:
            return Color.green
        case .down:
            return Color.red
        case .none:
            return Color.gray
        }
    }
}

struct OutcomeView: View {
    
    // MARK: - Wrapped Properties
    @State private var borderColor: Color?
    @State private var lineWidth: CGFloat = 1
    
    // MARK: - Stored Properties
    let outcome: Outcome
    let status: OutcomeViewStatus
    
    // MARK: - Actions
    var didTapButtonAction: (Outcome) -> Void
    
    // MARK: - Initializers
    init(outcome: Outcome, 
         status: OutcomeViewStatus,
         didTapButtonAction: @escaping (Outcome) -> Void) {
        self.outcome = outcome
        self.status = status
        self.didTapButtonAction = didTapButtonAction
    }
    
    var body: some View {
        Button(action: {
            didTapButtonAction(outcome)
        }, label: {
            VStack {
                Text(outcome.name)
                    .lineLimit(2)
                    .font(.callout)
                
                Text(String(format: "%.2f", outcome.price))
            }
            .foregroundStyle(.black)
        })
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: 80)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(borderColor ?? Color.gray, lineWidth: lineWidth)
        )
        .onAppear {
            borderColor = status.color
            lineWidth = 2
            withAnimation(.easeOut(duration: 3)) {
                borderColor = .gray
                lineWidth = 1
            }
        }
    }
}

#Preview {
    OutcomeView(outcome: Outcome(name: "Team 1", price: 2.5), 
                status: .down,
                didTapButtonAction: { _ in })
}
