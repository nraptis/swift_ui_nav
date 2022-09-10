//
//  GenericViewModel.swift
//  NavigationShell
//
//  Created by Nick Raptis on 9/10/22.
//

import SwiftUI

class GenericViewModel: ObservableObject {
    
    let text: String
    
    //array of enimal emojis
    let pages = AppPage.allCases
    
    init(text: String) {
        self.text = text
    }
    
    static var mock: GenericViewModel {
        return GenericViewModel(text: "🐢")
    }
    
    deinit {
        print("deallocated \(text)")
    }
    
    // MARK - Intent(s)
    
    func push(page: AppPage) {
        rootViewModel.push(page: page)
    }
    
    func pop() {
        rootViewModel.pop()
    }
    
    func replaceRoot(page: AppPage) {
        rootViewModel.replaceRoot(page: page)
    }
    
    func popToRoot() {
        rootViewModel.popToRoot()
    }
    
}

