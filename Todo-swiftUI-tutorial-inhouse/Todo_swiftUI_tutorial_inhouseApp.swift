//
//  Todo_swiftUI_tutorial_inhouseApp.swift
//  Todo-swiftUI-tutorial-inhouse
//
//  Created by Michele Byman on 2020-11-24.
//

import SwiftUI
import Firebase

@main
struct Todo_swiftUI_tutorial_inhouseApp: App {
    
    init() {
           FirebaseApp.configure()
       }
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
          
        }
    }
}
