//
//  allUApp.swift
//  allU
//
//  Created by Dawson Bauer on 9/18/22.
//

import SwiftUI

@main
struct allUApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
