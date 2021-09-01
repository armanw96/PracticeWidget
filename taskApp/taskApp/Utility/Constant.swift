//
//  Constant.swift
//  taskApp
//
//  Created by ArmanTW on 8/28/21.
//

import SwiftUI



//MARK: - Formatter
// remember to remove the pricate keyword sot hat the rest of the application can read from this constnat



let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


//MARK: - UI

var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}


//MARK: - UX

let haptics = UINotificationFeedbackGenerator()
// notice how this is different compare to the ones we used previous ly i guess this is what apple does with they haptics feedbacks so that you know which one is wrong and which one is right without trying to make them customize like we did iin previous videos / built

// we can create either success warnning or error type feedback 
