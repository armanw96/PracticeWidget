//
//  CheckboxStyle.swift
//  taskApp
//
//  Created by ArmanTW on 8/29/21.
//

import SwiftUI
//CUSTOM TOGGLE STYLE

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack{
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    if configuration.isOn {
                        playSound(sound: "sound-rise", type: "mp3")
                    } else {
                        playSound(sound: "sound-tap", type: "mp3")
                        haptics.notificationOccurred(.success)
                    }
                    
                }
            
            configuration.label
        } // : HSTACK
    }
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder label", isOn: . constant(false))
            .toggleStyle(CheckboxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
