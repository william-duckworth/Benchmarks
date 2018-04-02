//
//  ViewController.swift
//  Benchmarks
//
//  Created by William Duckworth on 01/04/2018.
//  Copyright © 2018 William Duckworth. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let regionRadius: CLLocationDistance = 1000
    let annotation = MKPointAnnotation()
    let annotation1 = MKPointAnnotation()
    
    var benchmarkDictionary = [String:String]()
    var benchmarkArray = NSMutableArray()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set initial location in Nailsworth
        let initialLocation = CLLocation(latitude: 51.694583, longitude: -2.217459)
        centerMapOnLocation(location: initialLocation)
        
        annotation.title = "TEST"
        annotation.subtitle = "test"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.694583, longitude: -2.217459)
        mapView.addAnnotation(annotation)
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 51.697451, longitude: -2.218123)
        mapView.addAnnotation(annotation1)
        
        let path = Bundle.main.path(forResource: "Benchmarks", ofType: "csv")
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: path!) {
            do {
                let fullText = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                var readings = fullText.components(separatedBy: "\n") as [String]
                for i in 2..<(readings.count) {
                    let benchmarkData = readings[i].components(separatedBy: ",")

                    benchmarkDictionary["NG_LETTERS"] = "\(benchmarkData[0])"
                    benchmarkDictionary["EASTING"] = "\(benchmarkData[1])"
                    benchmarkDictionary["NORTHING"] = "\(benchmarkData[2])"
                    benchmarkDictionary["HEIGHT"] = "\(benchmarkData[3])"
                    benchmarkDictionary["DATUM"] = "\(benchmarkData[4])"
                    benchmarkDictionary["NETWORK"] = "\(benchmarkData[5])"
                    benchmarkDictionary["ORDER"] = "\(benchmarkData[6])"
                    benchmarkDictionary["TYPE_OF_MARK"] = "\(benchmarkData[7])"
                    benchmarkDictionary["HEIGHT_ABOVE_GROUND"] = "\(benchmarkData[8])"
                    benchmarkDictionary["VERIFIED_DATE"] = "\(benchmarkData[9])"
                    benchmarkDictionary["LEVELING DATE"] = "\(benchmarkData[10])"
                    benchmarkDictionary["DESCRIPTION"] = "\(benchmarkData[11])"

                    print("Parsed: ", i)
                    
                    benchmarkArray.add(benchmarkDictionary)
                }
            } catch let error as NSError {
                print("Error: \(error)")
            }
        }
        print("Benchmark Total:")
        print(benchmarkArray.count)
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
}

