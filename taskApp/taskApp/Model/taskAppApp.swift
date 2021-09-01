//
//  taskAppApp.swift
//  taskApp
//
//  Created by ArmanTW on 8/27/21.
//

import SwiftUI

@main
struct taskAppApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark: .light)
            
            
            
            
            
        }
    }
}
