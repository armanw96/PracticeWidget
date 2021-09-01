//
//  backgroundImageView.swift
//  taskApp
//
//  Created by ArmanTW on 8/29/21.
//

import SwiftUI

struct backgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
        
    }
}

struct backgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        backgroundImageView()
    }
}
