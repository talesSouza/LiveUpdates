//
//  ViewModel.swift
//  LiveUpdates
//
//  Created by Tales Souza on 08/11/23.
//

import Foundation

@MainActor
class ViewModel: ObservableObject {
    
    // MARK: - Wrapped Properties
    @Published var updatedGames: [Game] = []
    @Published var oldGames: [Game] = []
    @Published var isLoading: Bool = true
    
    // MARK: - Stored Properties
    private var timer: Timer?
    
    // MARK: - Initializers
    init() {
        Task { await fetchData() }
        scheduleDataFetch()
    }
    
    deinit {
        timer?.invalidate()
    }
}

// MARK: - Private Methods
extension ViewModel {
    
    private func scheduleDataFetch() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in
            guard let self else { return }
            Task {
//                await self.fetchData()
                self.mockRequestChanges()
            }
        }
    }
    
    private func updateGames(with newGames: [Game]) {
        oldGames = updatedGames
        updatedGames = newGames
    }
    
    private func mockRequestChanges() {
        oldGames = updatedGames
        updatedGames.forEach { game in
            if let currentGameIndex = updatedGames.firstIndex(where: { $0.id == game.id }) {
                if currentGameIndex%2 == 0 {
                    updatedGames[currentGameIndex].bookmakers[0].markets[0].outcomes[0].price -= 0.1
                    updatedGames[currentGameIndex].bookmakers[0].markets[0].outcomes[1].price += 0.6
                } else {
                    updatedGames[currentGameIndex].bookmakers[0].markets[0].outcomes[0].price += 0.6
                    updatedGames[currentGameIndex].bookmakers[0].markets[0].outcomes[1].price -= 0.2
                }
            }
        }
    }
}

// MARK: - Network
extension ViewModel {
    
    func fetchData() async {
        guard let url = URL(string: Network.api) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedGames = try decoder.decode([Game].self, from: data)
            
            DispatchQueue.main.async {
                self.updateGames(with: decodedGames)
                self.isLoading = false
            }
        } catch {
            print("Error fetching or decoding data: \(error)")
        }
    }
}
