//
//  ContentView.swift
//  SwiftUINavigationPathUpdate
//
//  Created by Angelos Staboulis on 8/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator:AppCoordinator
    @StateObject private var viewModel: MovieViewModel
    @State var isSearching:Bool
    @State var getMovie:Movie
    init(apiKey: String,isSearching:Bool,getMovie:Movie) {
        _viewModel = StateObject(wrappedValue: MovieViewModel(service: NetworkService(apiKey: apiKey)))
        _coordinator = StateObject(wrappedValue: AppCoordinator())
        self.isSearching = isSearching
        self.getMovie = getMovie
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                // MARK: Search bar
                HStack {
                    TextField("Search movies...", text: $viewModel.searchText, onCommit: {
                        Task {
                            isSearching = true
                            await viewModel.searchMovies()
                        }
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                    Button("Search") {
                        Task {
                            isSearching = true
                            await viewModel.searchMovies()
                        }
                    }
                    .padding(.trailing)
                }
                .padding(.top)

                // MARK: List / Results
                if viewModel.isLoading {
                    ProgressView("Loading…")
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                        Button("Retry") {
                            Task {
                                if viewModel.searchText.isEmpty {
                                    await viewModel.loadPopularMovies()
                                } else {
                                    isSearching = true
                                    await viewModel.searchMovies()
                                }
                            }
                        }
                    }
                    Spacer()
                } else {
                    ScrollView{
                        ForEach(isSearching ? viewModel.searchMovies : viewModel.movies) { movie in
                          
                            MovieRowView(movie: movie).onTapGesture {
                                getMovie = movie
                                coordinator.push(.detail)
                            }

                                                
                        }
                    }
                    .listStyle(.plain)
                }
            }.navigationDestination(for: Route.self) { route in
                if route == .detail{
                    MovieDetailView(movieId: getMovie.id, service: viewModel.service)
                }
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
           
        }.environmentObject(coordinator)
        .task {
                await viewModel.loadPopularMovies()
        }
        
    }
}
