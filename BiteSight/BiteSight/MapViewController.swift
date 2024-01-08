//
//  MapViewController.swift
//  BiteSight
//
//  Created by Tiffany Zhang on 12/7/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var receivedAddress: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        let mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
        getLocation(from: receivedAddress) { coordinates in
            if let location = coordinates {
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = "Location"
                mapView.addAnnotation(annotation)

                let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
                mapView.setRegion(region, animated: true)
            } else {
                print("Geocoding failed for address: \(self.receivedAddress ?? "")")
            }
        }
    }
    
    func getLocation(from address: String?, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address ?? "") { (placemarks, error) in
            if let location = placemarks?.first?.location?.coordinate {
                completion(location)
            } else {
                print("Error geocoding address: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
    }
}
