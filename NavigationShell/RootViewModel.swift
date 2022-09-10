//
//  RootViewModel.swift
//  NavigationShell
//
//  Created by Nick Raptis on 9/10/22.
//

import SwiftUI

enum AppPage: String, CaseIterable {
    case 🦩
    case 🐩
    case 🦍
    case 🐢
    case 🐁
    case 🐐
}

private var appPageId = 0
struct AppPageContainer: Identifiable {
    let page: AppPage
    
    // these go from -1 to 1...
    var translationX: CGFloat
    var translationY: CGFloat
    let id: Int
    let viewModel: GenericViewModel
    
    init(page: AppPage, viewModel: GenericViewModel) {
        self.page = page
        self.translationX = 0
        self.translationY = 0
        self.id = appPageId
        self.viewModel = viewModel
        appPageId += 1
    }
    
}

class RootViewModel: ObservableObject {
    
    init() {
        push(page: .🦍)
    }
    
    @Published var list = [AppPageContainer]()
    
    static var mock: RootViewModel {
        return RootViewModel()
    }
    
    private func viewModelFor(_ page: AppPage) -> GenericViewModel {
        return GenericViewModel(text: page.rawValue)
    }
    
    private func snapToCenter(_ cont: inout AppPageContainer) {
        cont.translationY = 0
        cont.translationX = 0
    }
    
    private func snapToLeft(_ cont: inout AppPageContainer) {
        cont.translationY = 0
        cont.translationX = -1
    }
    
    private func snapToRight(_ cont: inout AppPageContainer) {
        cont.translationY = 0
        cont.translationX = 1
    }
    
    private func snapToTop(_ cont: inout AppPageContainer) {
        cont.translationY = -1
        cont.translationX = 0
    }
    
    private func snapToBottom(_ cont: inout AppPageContainer) {
        cont.translationY = 1
        cont.translationX = 0
    }
    
    private static let dur: TimeInterval = 0.5
    private static let dur_epsilon: TimeInterval = 0.05
    
    
    func withAnimationAndCompletion(_ block: () -> Void, _ completion: @escaping () -> Void) {
        withAnimation(Animation.easeInOut(duration: Self.dur)) {
            block()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Self.dur + Self.dur_epsilon) {
            completion()
        }
    }
    
    private var _isAnimating: Bool = false
    
    // MARK - Intent(s)
    
    func push(page: AppPage) {
        
        if _isAnimating { print("already animating"); return }
        
        let newContainer = AppPageContainer(page: page, viewModel: viewModelFor(page))
        
        if list.count <= 0 {
            list.append(newContainer)
        } else {
            
            //we want to animate!!!
            _isAnimating = true
            
            list.append(newContainer)
            
            // < - []
            
            snapToRight(&list[list.count - 1])
            snapToCenter(&list[list.count - 2])
            
            withAnimationAndCompletion({
                self.snapToLeft(&self.list[self.list.count - 2])
                self.snapToCenter(&self.list[self.list.count - 1])
            }, {
                self._isAnimating = false
            })
        }
    }
    
    func pop() {
        if _isAnimating { print("already animating"); return }
        
        if list.count <= 1 { return }
        
        _isAnimating = true
        
        // [] ->
        snapToCenter(&list[list.count - 1])
        snapToLeft(&list[list.count - 2])
        
        withAnimationAndCompletion({
            self.snapToCenter(&self.list[self.list.count - 2])
            self.snapToRight(&self.list[self.list.count - 1])
        }, {
            self.list.removeLast()
            self._isAnimating = false
        })
    }
    
    func replaceRoot(page: AppPage) {
        if _isAnimating { print("already animating"); return }
        
        let newContainer = AppPageContainer(page: page, viewModel: viewModelFor(page))
        
        if list.count <= 0 {
            list.append(newContainer)
        } else {
            
            _isAnimating = true
            list.append(newContainer)
            
            snapToBottom(&list[list.count - 1])
            snapToCenter(&list[list.count - 2])
            
            withAnimationAndCompletion({
                self.snapToTop(&self.list[self.list.count - 2])
                self.snapToCenter(&self.list[self.list.count - 1])
            }, {
                
                self.list = [self.list[self.list.count - 1]]
                self._isAnimating = false
            })
            
            
        }
        
        
    }
    
    func popToRoot() {
        
        if _isAnimating { print("already animating"); return }
        
        if list.count <= 1 {
            return
        }
        
        _isAnimating = true
        
        snapToCenter(&list[list.count - 1])
        snapToLeft(&list[0])
        
        // [] ->
        
        withAnimationAndCompletion({
            self.snapToCenter(&self.list[0])
            self.snapToRight(&self.list[self.list.count - 1])
        }, {
            self._isAnimating = false
            self.list = [self.list[0]]
        })
        
        
    }
    
}

