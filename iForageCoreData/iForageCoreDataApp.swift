//
//  iForageCoreDataApp.swift
//  iForageCoreData
//
//  Created by Connor A Lynch on 11/11/2021.
//

import SwiftUI

@main
struct iForageCoreDataApp: App {
    
    var body: some Scene {
        
            WindowGroup {
                
                let viewContext = CoreDataManager.shared.viewContext
                NavigationView {
                
                HomeView(viewModel: HomeView.ViewModel(context: viewContext))
                    .environment(\.managedObjectContext, viewContext)
                    .navigationTitle("")
                    .navigationBarHidden(true)
                }
            }
    }
}
