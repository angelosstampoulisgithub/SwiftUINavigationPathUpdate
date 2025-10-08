//
//  AppCoordinator.swift
//  SwiftUINavigationPathUpdate
//
//  Created by Angelos Staboulis on 8/10/25.
//

import Foundation
import SwiftUI
import Combine
class AppCoordinator: ObservableObject {
    @Published var path: [Route] = [Route]()
    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

   
}
