//
//  MapView.swift
//  iForage
//
//  Created by Connor A Lynch on 01/11/2021.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocation
    var isZoomEnabled: Bool = true
    var isRotateEnabled: Bool = true
    var isScrollEnabled: Bool = true
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        
        mapView.delegate = context.coordinator
        
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: centerCoordinate.coordinate.latitude, longitude: centerCoordinate.coordinate.longitude), latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = isZoomEnabled
        mapView.isScrollEnabled = isScrollEnabled
        mapView.isRotateEnabled = isRotateEnabled
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, ObservableObject, MKMapViewDelegate {
        var parent: MapView
        
        init(parent: MapView){
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            self.parent.centerCoordinate = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        }
    }
}
