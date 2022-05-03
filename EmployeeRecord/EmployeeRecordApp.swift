//
//  EmployeeRecordApp.swift
//  EmployeeRecord
//
//  Created by Anuj Soni on 03/05/22.
//

import SwiftUI

@main
struct EmployeeRecordApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
