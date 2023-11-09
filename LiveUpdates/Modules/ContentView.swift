//
//  ContentView.swift
//  LiveUpdates
//
//  Created by Tales Souza on 08/11/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Wrapped Properties
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .scaleEffect(x: 2, y: 2)
        } else {
            createContent()
        }
    }
    
    // MARK: - Private Methods
    @ViewBuilder
    private func createContent() -> some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(viewModel.updatedGames) { game in
                    let oldGame = viewModel.oldGames.first(where: { $0.id == game.id })
                    GameView(currentGame: game, oldGame: oldGame)
                    Divider().frame(height: 2).overlay(.black.opacity(0.8))
                }
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    ContentView()
}
