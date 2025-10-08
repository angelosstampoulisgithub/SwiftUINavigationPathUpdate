//
//  MovieDetailViewModel.swift
//  SwiftUINavigationPathUpdate
//
//  Created by Angelos Staboulis on 8/10/25.
//

import Foundation
import Combine
@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var detail: MovieDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?

    let service: NetworkService
    let movieId: Int

    init(movieId: Int, service: NetworkService) {
        self.movieId = movieId
        self.service = service
    }

    func loadDetail() async {
        isLoading = true
        errorMessage = nil
        do {
            let d = try await service.fetchMovieDetail(id: movieId)
            detail = d
        } catch {
            errorMessage = "Could not fetch movie detail: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
