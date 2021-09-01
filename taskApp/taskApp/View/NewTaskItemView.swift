//
//  NewTaskItemView.swift
//  taskApp
//
//  Created by ArmanTW on 8/29/21.
//

import SwiftUI

struct NewTaskItemView: View {
    //MARK: - Properties
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    // with this code we get access to the managed object context which is required to make the addItem function work
    @State private var task: String = ""
    // this is to make the private var works again here as well
    
    @Binding var isShowing : Bool

    private var isButtonDisabled : Bool {
        task.isEmpty
    }
    
    //MARK: - Function
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
               
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    
    
    //MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(12)
                Button(action: {
                    addItem()
                    playSound(sound: "sound-ding", type: "mp3")
                }, label: {
                    Spacer()
                    Text("SAVE")
                    Spacer()
                  
                    
                })
                .disabled(isButtonDisabled)
                .onTapGesture {
                    if isButtonDisabled {
                        playSound(sound: "sound-tap", type: "mp3")
                        haptics.notificationOccurred(.success)
                    }
                }
                .padding()
                .font(.system(size: 24, weight: .bold, design: .rounded))
//                .font(.headline)
                // deleted coz we don't need it anymore
                .foregroundColor(.white)
                .background(isButtonDisabled ? Color.blue : Color.pink)
                .cornerRadius(12)
                
            }// end of Vstack
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
            )
            .cornerRadius(12)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        } // vstack
        .padding()
    }
}


//MARK: - Preview
struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
