//
//  UltimatePortfolioApp.swift
//  UltimatePortfolio
//
//  Created by Lawrence Archer on 05/10/2022.
//

import SwiftUI

@main
struct UltimatePortfolioApp: App {
    @StateObject var dataController: DataController // essentially a StateObject wrapper with a data controller inside
    
    init() {
        let dataController = DataController() // gives access to underlying dataController directly
        _dataController = StateObject(wrappedValue: dataController) // _ refers to the wrapper - StateObject
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext) //tells SwiftUI what context it works in and allows SwiftUI to read Core Data values
                .environmentObject(dataController) // This allows our own code to read those Core Data values
        }
    }
}
