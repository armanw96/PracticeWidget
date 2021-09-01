//
//  hideKeyboardExtension.swift
//  taskApp
//
//  Created by ArmanTW on 8/29/21.
//

import SwiftUI


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil  )
    }// the resignFirstResponder is the key that will hide the keyboard automatically since SwiftUI iss o ealry it neeeds help from UIKit
}

#endif
// this only runs when we can import the UIKit
