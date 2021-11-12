//
//  AddEntityViewModel.swift
//  iForageCoreData
//
//  Created by Connor A Lynch on 12/11/2021.
//

import Foundation
import SwiftUI
import CoreLocation
import CoreData

extension AddEntityView {
    class ViewModel: ObservableObject {
        
        @ObservedObject var locationManager = LocationManager()
        
        @Published var showMap = false
        
        private let viewContext: NSManagedObjectContext
        
        @Published var titleTextField: String = ""
        @Published var captionTextField: String = "Write your notes here..."
        
        @Published var showShareSheet: Bool = false
        @Published var showConfirmationSheet: Bool = false
        
        @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
        
        @Published var selectedImage: UIImage?
        
        init(viewContext: NSManagedObjectContext){
            self.viewContext = viewContext
            self.locationManager.requestLocation()
        }
        
        func addEntity(){
            let entity = ForageEntity(context: viewContext)
            entity.title = titleTextField
            entity.caption = captionTextField
            
            guard let image = selectedImage else { return }
            
            entity.imageData = image.jpegData(compressionQuality: 0.5)
            entity.lat = locationManager.currentLocation?.coordinate.latitude ?? 0
            entity.lng = locationManager.currentLocation?.coordinate.longitude ?? 0
            CoreDataManager.shared.save()
        }
    }
}
