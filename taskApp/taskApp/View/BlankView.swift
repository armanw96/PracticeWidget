//
//  BlankView.swift
//  taskApp
//
//  Created by ArmanTW on 8/29/21.
//

import SwiftUI

// this is the semi transparant view that will be able to get out of the new task item easier 

struct BlankView: View {
    //MARK: - Properties
    
    var backgroundColor: Color
    var backgroundOpacity: Double
    
    
    //MARK: - Body
    var body: some View {
        VStack{
            
        Spacer()
            
        
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}


//MARK: - Preview

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgroundColor: Color.black, backgroundOpacity: 0.3)
            .background(backgroundImageView())
            .background(backgroundGradient.ignoresSafeArea(.all))
    }
}

//.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
