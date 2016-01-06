//
//  Map.swift
//  LAP
//
//  Created by kevin on 12/19/15.
//  Copyright © 2015 Kevin Argumedo. All rights reserved.
//

import Foundation
import MapKit

import UIKit

class Map: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var Option: UIBarButtonItem!
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var options: UIBarButtonItem!
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    var counter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        options.target = self.revealViewController()
        options.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        Option.target = self.revealViewController()
        Option.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        self.mapView.delegate = self;
        
        mapView.showsUserLocation = true
        
//        let newYorkLocation = CLLocationCoordinate2DMake(40.730872, -74.003066)
        // Drop a pin
//        let dropPin = MKPointAnnotation()
//        dropPin.coordinate = newYorkLocation
//        dropPin.title = "New York City"
//        mapV.addAnnotation(dropPin)
    }
    
    @IBAction func LongPress(sender: AnyObject) {
        
        
        if sender.state != UIGestureRecognizerState.Began { return }
        
        
        mapView.removeAnnotations(mapView.annotations)
        
        let touchLocation = sender.locationInView(mapView)
        let locCoord = mapView.convertPoint(touchLocation, toCoordinateFromView: mapView)
        print("tapped at \(locCoord)")
        
        let pin = MKPointAnnotation()
        
        pin.coordinate = CLLocationCoordinate2D(latitude: locCoord.latitude, longitude: locCoord.longitude)
        
        mapView.addAnnotation(pin)
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse
        {
            
        }
    }
    
}