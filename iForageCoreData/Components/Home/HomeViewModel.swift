//
//  HomeViewModel.swift
//  iForageCoreData
//
//  Created by Connor A Lynch on 12/11/2021.
//

import Foundation
import CoreData

extension HomeView {
    class ViewModel: ObservableObject {
        
        @Published var forageEntities: [ForageEntityViewModel] = [ForageEntityViewModel]()
        @Published var showAddEntityView: Bool = false
        
        private var context: NSManagedObjectContext
        
        init(context: NSManagedObjectContext){
            self.context = context
        }
        
        func fetchEntities(){
            self.forageEntities = CoreDataManager.shared.fetchPosts().map(ForageEntityViewModel.init)
        }
    }
}
