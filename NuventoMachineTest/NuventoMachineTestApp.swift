//
//  NuventoMachineTestApp.swift
//  NuventoMachineTest
//
//  Created by Thirumalai Ganesh G on 29/01/26.
//

import SwiftUI
import CoreData

@main
struct NuventoMachineTestApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            LoginScreenView()
        }
    }
}
