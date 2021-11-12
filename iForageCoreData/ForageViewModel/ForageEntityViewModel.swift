//
//  ForageEntityViewMode.swift
//  iForageCoreData
//
//  Created by Connor A Lynch on 11/11/2021.
//

import Foundation
import CoreData
import CoreLocation
import UIKit

struct ForageEntityViewModel: Identifiable {
    
    let entity: ForageEntity
    
    var id: NSManagedObjectID {
        return entity.objectID
    }
    
    var title: String {
        return entity.title ?? ""
    }
    
    var caption: String {
        return entity.caption ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: entity.lat, longitude: entity.lng)
    }
    
    var image: UIImage {
        return UIImage(data: entity.imageData ?? Data.init()) ?? UIImage(systemName: "photo")!
    }
}
