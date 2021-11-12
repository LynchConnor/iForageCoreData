//
//  LocationManager.swift
//  iForageCoreData
//
//  Created by Connor A Lynch on 11/11/2021.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager = CLLocationManager()
    
    static var shared = LocationManager()
    
    @Published var currentLocation: CLLocation?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 250, longitudinalMeters: 250)
    
    override init(){
        super.init()
        locationManager.delegate = self
        self.locationManager.activityType = .other
        self.locationManager.desiredAccuracy =     kCLLocationAccuracyBest
        enableLocationServices()
    }
    
    func enableLocationServices() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            self.locationManager.requestLocation()
        case .restricted, .notDetermined, .denied:
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestLocation()
        @unknown default:
            fatalError()
        }
    }
    
    func requestLocation(){
        self.locationManager.requestLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            enableLocationServices()
        default:
            enableLocationServices()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("DEBUG: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        DispatchQueue.main.async {
            self.currentLocation = location
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.region = MKCoordinateRegion(center: center, latitudinalMeters: 250, longitudinalMeters: 250)
        }

    }
}
