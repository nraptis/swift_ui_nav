//
//  NavigationShellApp.swift
//  NavigationShell
//
//  Created by Nick Raptis on 9/10/22.
//

import SwiftUI

let rootViewModel = RootViewModel()

@main
struct NavigationShellApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: rootViewModel)
        }
    }
}
