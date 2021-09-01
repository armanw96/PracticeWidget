//
//  ContentView.swift
//  taskApp
//
//  Created by ArmanTW on 8/27/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: - Properties
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @State var task: String = ""
    // initialize the state variable with an empty string
    // so task is located iin two of the files
    
    @State private var showNewTaskItem: Bool = false
    
    
    //MARK: - Fetching Data
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //MARK: - Function
    
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    //MARK: - Body
    var body: some View {
        NavigationView  {
            ZStack {
                
                //MARK: - Main View
                VStack {
                    
                    //MARK: - Header
                    
                    HStack(spacing: 10) {
                        // Title
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        // edit button
                        EditButton()
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        
                        //MARK: - APPEARANCE BUTTON
                        
                        Button(action: {
                            // toggle appearance
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                            haptics.notificationOccurred(.success)
                        }, label: {
                            Image(systemName:isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title , design: .rounded))
                        })
                        
                        
                        
                    }// end of the Hstack
                    .padding()
                    .foregroundColor(.white)
                    Spacer(minLength: 80)
                    
                    //MARK: - New task button
                    Button(action: {
                        
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                        haptics.notificationOccurred(.success)
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }) // BUTTON
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                        
                    )
                    .clipShape(Capsule())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0, y: 4.0)
                    //MARK: - Task
                    
                    
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    } // LIST
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 16)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
            
                } // END OF THE VSTACK
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                
                //MARK: - New task Item
                
                if showNewTaskItem {
                    BlankView(
                        backgroundColor: isDarkMode ? Color.black : Color.gray,
                        backgroundOpacity: isDarkMode ?  0.3 : 0.5)
                        .onTapGesture(perform: {
                            withAnimation() {
                                showNewTaskItem = false
                            }
                        })
                    
                    
                    NewTaskItemView(isShowing: $showNewTaskItem)
                    
                }
            
              
            } // ENF OF ZSTACK
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.clear
            })
            .navigationBarTitle("Daily Task", displayMode: .large)
            .navigationBarHidden(true)
            .background(
                backgroundImageView()
                    .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
            )
            
            .background(backgroundGradient.ignoresSafeArea(.all))
            
            
        } // END OF THE NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
