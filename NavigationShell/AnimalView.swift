//
//  AnimalView.swift
//  NavigationShell
//
//  Created by Nick Raptis on 9/10/22.
//

import SwiftUI

struct AnimalView: View {
    
    let text: String
    
    var body: some View {
        VStack {
            
            Spacer()
            HStack {
                
                Spacer()
                Text(text)
                    .font(.system(size: 120))
                
                Spacer()
                
            }
            Spacer()
            
        }
        .padding(.all, 24)
        .background(RoundedRectangle(cornerRadius: 20).fill().foregroundColor(.red.opacity(0.25)))
        
    }
}

struct AnimalView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalView(text: "🐐")
    }
}
