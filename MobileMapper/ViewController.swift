//
//  ViewController.swift
//  MobileMapper
//
//  Created by Christian Carnalla on 4/28/21.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var currentLocation:CLLocation!
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    var parks:[MKMapItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
    
            
    
    }
   
    @IBAction func whenZoomButtonPressed(_ sender: Any) {
    
    
     //   let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)

let center = currentLocation.coordinate
        
        let span = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)

let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        
    
    }
    @IBAction func whenSearchButtonPressed(_ sender: Any) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Parks"
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {return}
            for currentMapItem in response.mapItems {
                self.parks.append(currentMapItem)
                let annotation = MKPointAnnotation()
                annotation.coordinate = currentMapItem.placemark.coordinate
                annotation.title = currentMapItem.name
                self.mapView.addAnnotation(annotation)
                
            }
        }

    
    }


        
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        let button = UIButton(type: .detailDisclosure)
        pin.rightCalloutAccessoryView = button
        return pin
        
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        var currentMapItem = MKMapItem()
        if let coordinate = view.annotation?.coordinate {
            for mapItem in parks {
                currentMapItem = mapItem
            }
        }
        let placemark = currentMapItem
        if let parkName = placemark.name, let streetNumber =  placemark.subThouroughFare, let streetName = placemark.subThouroughFare {
            
        }
    }
    
    
}



