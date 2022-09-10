//
//  ControlPanelView.swift
//  NavigationShell
//
//  Created by Nick Raptis on 9/10/22.
//

import SwiftUI

struct ControlPanelView: View {
    
    @ObservedObject var viewModel: GenericViewModel
    
    @State var page = AppPage.🐐
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
                .frame(height: 24)
            
            HStack {
                //this is all of our animals
                
                Picker("", selection: $page) {
                    ForEach(viewModel.pages, id: \.self) {
                        Text($0.rawValue)
                            .font(.system(size: 32))
                    }
                    
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 24)
                
            }
            
            HStack {
                
                Spacer()
                Button {
                    print("pop")
                    viewModel.pop()
                    
                } label: {
                    Image(systemName: "arrow.left.square.fill")
                        .font(.system(size: 52))
                }
                Spacer()
                Button {
                    print("pushed \(page)")
                    viewModel.push(page: page)
                    
                } label: {
                    Image(systemName: "arrowtriangle.right.square.fill")
                        .font(.system(size: 52))
                }
                Spacer()
                Button {
                    print("pop to root...")
                    viewModel.popToRoot()
                    
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 42))
                }
                Spacer()
                Button {
                    print("replacing root with \(page)")
                    viewModel.replaceRoot(page: page)
                    
                } label: {
                    Image(systemName: "house.fill")
                        .font(.system(size: 44))
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            
            Spacer()
                .frame(height: 24)
            
        }
        .background(RoundedRectangle(cornerRadius: 18).fill().foregroundColor(.black.opacity(0.95)))
        
    }
}

struct ControlPanelView_Previews: PreviewProvider {
    static var previews: some View {
        ControlPanelView(viewModel: GenericViewModel.mock)
    }
}
