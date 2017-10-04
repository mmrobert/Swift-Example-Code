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

class LibLocationMapVC: UIViewController, MKMapViewDelegate {
    
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
        self.locationManager.startUpdatingLocation()
        
        if let _loc = self.loc {
            let la = _loc.latitude
            let lo = _loc.longitude
            let latitude = CLLocationDegrees(Double(la!)!)
            let longitude = CLLocationDegrees(Double(lo!)!)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(String(describing: self.nameLabel.text!))"
            
            self.locationMap.addAnnotation(annotation)
            self.locationMap.showAnnotations([annotation], animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
