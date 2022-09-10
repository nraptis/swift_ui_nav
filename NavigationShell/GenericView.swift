//
//  GenericView.swift
//  NavigationShell
//
//  Created by Nick Raptis on 9/10/22.
//

import SwiftUI

struct GenericView: View {
    
    @ObservedObject var viewModel: GenericViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            AnimalView(text: viewModel.text)
            ControlPanelView(viewModel: viewModel)
            
        }
    }
}

struct GenericView_Previews: PreviewProvider {
    static var previews: some View {
        GenericView(viewModel: GenericViewModel.mock)
    }
}
