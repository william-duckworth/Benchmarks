//
//  ViewController.swift
//  Benchmarks
//
//  Created by William Duckworth on 01/04/2018.
//  Copyright © 2018 William Duckworth. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    let annotation = MKPointAnnotation()
    let annotation1 = MKPointAnnotation()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        annotation.title = "TEST"
        annotation.subtitle = "test"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.694583, longitude: -2.217459)
        mapView.addAnnotation(annotation)
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 51.697451, longitude: -2.218123)
        mapView.addAnnotation(annotation1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
//        self.mapView.setRegion(region, animated: true)
        
        let initialLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        centerMapOnLocation(location: initialLocation)
    }
}

