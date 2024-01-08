// LocationFetcher.swift
import Foundation
import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    static let shared = LocationFetcher()
    let locationManager = CLLocationManager()
    var completion: ((CLLocation) -> Void)?

    func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
        locationManager.stopUpdatingLocation()
    }
    
    func getCity(from location: CLLocation, completion: @escaping (String?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            let city = placemarks?.first?.locality
            completion(city)
        }
    }

}
