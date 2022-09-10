//
//  RootView.swift
//  NavigationShell
//
//  Created by Nick Raptis on 9/10/22.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject var viewModel: RootViewModel
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(viewModel.list) { container in
                    GenericView(viewModel: container.viewModel)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: container.translationX * geometry.size.width,
                                y: container.translationY * geometry.size.height)
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: RootViewModel.mock)
    }
}
