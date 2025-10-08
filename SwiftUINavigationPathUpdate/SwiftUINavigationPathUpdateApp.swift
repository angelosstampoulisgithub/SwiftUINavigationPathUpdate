//
//  SwiftUINavigationPathUpdateApp.swift
//  SwiftUINavigationPathUpdate
//
//  Created by Angelos Staboulis on 8/10/25.
//

import SwiftUI

@main
struct SwiftUINavigationPathUpdateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(apiKey: "d8d8c423", isSearching: false, getMovie: .init(id: 0, title: "", overview: "",posterPath: "",releaseDate: "",genreIDs: [],voteAverage: 0.0))
        }
    }
}
