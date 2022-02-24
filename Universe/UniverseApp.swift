//
//  UniverseApp.swift
//  Universe
//
//  Created by Vincenzo Tipacti Moran on 24/02/22.
//

import SwiftUI

@main
struct UniverseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
