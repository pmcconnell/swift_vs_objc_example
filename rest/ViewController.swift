//
//  ViewController.swift
//  rest
//
//  Created by Patrick McConnell on 6/5/14.
//  Copyright (c) 2014 Patrick McConnell. All rights reserved.
//

import UIKit
import MapKit

extension NSData {
    /// Converts NSData to an ASCII encoded string
    func toASCIIString() -> String {
        return NSString(data: self, encoding: NSASCIIStringEncoding)
    }
}

class ViewController: UIViewController {
   
    @IBOutlet var textField : UITextField
    @IBOutlet var mapView : MKMapView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseTextField() -> String {
        let originalString = textField.text
        return originalString.stringByReplacingOccurrencesOfString(" ", withString:"+")
    }
    
    func addPinToMapAt(lat : Double, lng : Double) {
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        pin.title = self.textField.text
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: pin.coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        
        self.mapView.addAnnotation(pin)
        self.mapView.setNeedsDisplay()
    }

    func fetchLocation() {
        let httpService = HTTPService()
        let urlString = "http://maps.googleapis.com/maps/api/geocode/json?address=" + parseTextField()
        httpService.getDataFromURL(urlString, {(data: NSData?, urlResponse: NSURLResponse?, error: NSError?) -> Void in
            var parseError : NSError?
            if let response : AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parseError) {
                if let location : AnyObject? = response?["results"]![0]!["geometry"]!["location"]! {
                    let lat = location!["lat"]! as? Double
                    let lng = location!["lng"]! as? Double
                    println("Lat: \(lat) Lng: \(lng)")
                    
                    self.addPinToMapAt(lat!, lng: lng!)
                }
            }
        })
    }

    @IBAction func buttonClick(sender : AnyObject) {
        if textField.text != "" {
            view.endEditing(true)
            fetchLocation()
        } else {
            println("No Address entered!")
        }
    }
}

