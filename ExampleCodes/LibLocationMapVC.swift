//
//  LibLocationMapVC.swift
//  ExampleCodes
//
//  Created by boqian cheng on 2017-10-03.
//  Copyright © 2017 boqiancheng. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LibLocationMapVC: UIViewController {
    
    public var theLibStruct: Library?
    let locationManager = CLLocationManager()
    var loc: Location?

    @IBOutlet weak var locationMap: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let _theLibStruct = self.theLibStruct {
            self.nameLabel.text = _theLibStruct.name_
            self.addressLabel.text = _theLibStruct.address
            self.openTimeLabel.text = _theLibStruct.hours_of_operation
            self.loc = _theLibStruct.location
        }
        
        self.locationMap.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.annotateTheMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func annotateTheMap() {
        
        // looks this statement has no effect, could be commited out
        self.locationManager.startUpdatingLocation()
        
        if let _loc = self.loc {
            let la = _loc.latitude
            let lo = _loc.longitude
            let latitude = CLLocationDegrees(Double(la!)!)
            let longitude = CLLocationDegrees(Double(lo!)!)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let viewRegion: MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
            // let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, 100000, 100000)
            let adjustedRegion: MKCoordinateRegion = self.locationMap.regionThatFits(viewRegion)
            self.locationMap.setRegion(adjustedRegion, animated: true)
            self.locationMap.setCenter(coordinate, animated: true)
            
            //  let annotation = MKPointAnnotation()
            let annotation = CustomMapPointAnnotation()
            annotation.coordinate = coordinate
            
       // annotation title must not be nil to show callout bubble
            annotation.title = "5"
          //  self.locationMap.addAnnotations([annotation])
            self.locationMap.addAnnotation(annotation)
            // looks this statement has no effect, it has been commited out
            //    self.locationMap.showAnnotations([annotation], animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LibLocationMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Don't do anything if it's the user's location point
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        // We could display multiple types of point annotations
        if annotation.isKind(of: CustomMapPointAnnotation.self) {
            let pin = CustomMapPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            pin.image = UIImage(named: "mappin")
            pin.setAnnotationLabel(annotationtext: "5")
            pin.setCalloutBtn()
            return pin
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("ch--9988--ch")
    }
}

