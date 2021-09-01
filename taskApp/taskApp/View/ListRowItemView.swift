//
//  ListRowItemView.swift
//  taskApp
//
//  Created by ArmanTW on 8/29/21.
//

import SwiftUI

struct ListRowItemView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    // this observe object and saves checkbox changes everytime we toggle the checkbox this object serves as the pot where it is saved in
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : Color.primary)
                .padding(.vertical, 12)
                .animation(.default)
            
        } // TOGGLE
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange, perform: { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
                // on receive has two parameters it and with this parts it adds an action to perform each time when the view detects any change
                // first parameter item.objectwilchange everytime there is a change it will run the hange
                
                // second is trying to safe the viewcontext  safley and trying to update the store by doing that
                
            }
        })
        
    }
}

