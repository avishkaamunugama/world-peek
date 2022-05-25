//
//  MapViewModel.swift
//  WorldPeek
//
//  Created by Avishka Amunugama on 5/19/22.
//

import Foundation
import MapKit

extension MapView {
    @MainActor class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        
        private static let defaultSpan = MKCoordinateSpan(latitudeDelta: 12.0, longitudeDelta: 12.0)
        private static let defaultCoordinates = CLLocationCoordinate2D(latitude: 59.403295, longitude: 18.326333)
        
        @Published var mapRegion = MKCoordinateRegion(center: defaultCoordinates, span: defaultSpan)
        @Published var selection: Int?
        @Published var viewButtonTitles: Bool = false

        var locationManager: CLLocationManager?
        
        func checkIfLocationsEnabled() {
            if CLLocationManager.locationServicesEnabled() {
                locationManager = CLLocationManager()
                locationManager!.delegate = self
            }
        }
        
        func checkLocationAuthorization() {
            guard let locationManager = locationManager else { return }
            
            switch locationManager.authorizationStatus{
                
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Location services restricted.")
            case .denied:
                print("Location access denied by user.")
            case .authorizedAlways, .authorizedWhenInUse:
                mapRegion = MKCoordinateRegion(center: locationManager.location?.coordinate ?? MapView.MapViewModel.defaultCoordinates, span: MapView.MapViewModel.defaultSpan)
            @unknown default:
                break
            }
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationAuthorization()
        }
        
        func selectedLocation() -> Location {
            return Location(id: UUID(), latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
        }
    }
}
