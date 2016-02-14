//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import CoreLocation
import Foundation
import WatchKit

class LocationController: WKInterfaceController, CLLocationManagerDelegate {
    
    @IBOutlet weak var groupPermissionON: WKInterfaceGroup!
    @IBOutlet weak var groupPermissionOFF: WKInterfaceGroup!
    @IBOutlet var map: WKInterfaceMap!
    @IBOutlet var loadingLabel: WKInterfaceLabel!
    
    let location_manager = CLLocationManager()
    // let geocoder = CLGeocoder()
    
    var zoomLevel = MKCoordinateSpanMake(0.25, 0.25)
    var coordinate = CLLocationCoordinate2DMake(0.0, 0.0)
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        setup()
    }
    
    override func willActivate() {
        super.willActivate()
        
        checkAuthorization()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        location_manager.delegate = self
        location_manager.desiredAccuracy = kCLLocationAccuracyBest
        location_manager.requestWhenInUseAuthorization()
        location_manager.stopUpdatingLocation()
    }
    
    private func showPermission(value: Bool) {
        groupPermissionOFF.setHidden(value)
        groupPermissionON.setHidden(!value)
    }
    
    private func checkAuthorization() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if (authorizationStatus == .AuthorizedWhenInUse || authorizationStatus == .AuthorizedAlways) {
            showPermission(true)
            
            // Richiesta di localizzazione
            location_manager.requestLocation()
            
        } else if (authorizationStatus == .NotDetermined) {
            location_manager.requestWhenInUseAuthorization()
            
        } else {
            showPermission(false)
        }
    }
    
    // MARK: - IBAction Methods
    
    @IBAction func actionRequestLocation() {
        self.animateWithDuration(0.3) { () -> Void in
            self.loadingLabel.setRelativeHeight(0.1, withAdjustment: 0.0)
            self.map.setRelativeHeight(0.6, withAdjustment: 0.0)
        }
        
        location_manager.requestLocation()
    }
    
    @IBAction func actionZoomIN() {
        zoomLevel = MKCoordinateSpanMake(zoomLevel.latitudeDelta * 2.0, zoomLevel.longitudeDelta * 2.0)
        map.setRegion(MKCoordinateRegion(center: coordinate, span: zoomLevel))
    }
    
    @IBAction func actionZoomOUT() {
        zoomLevel = MKCoordinateSpanMake(zoomLevel.latitudeDelta / 2.0, zoomLevel.longitudeDelta / 2.0)
        map.setRegion(MKCoordinateRegion(center: coordinate, span: zoomLevel))
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.animateWithDuration(0.3) { () -> Void in
            self.loadingLabel.setRelativeHeight(0.0, withAdjustment: 0.0)
            self.map.setRelativeHeight(0.7, withAdjustment: 0.0)
        }
        
        WKInterfaceDevice.currentDevice().playHaptic(.Failure)
        
        let actionClose = WKAlertAction(title: "Close", style:WKAlertActionStyle.Cancel) { () -> Void in
            // NOP
        }
        
        presentAlertControllerWithTitle("Error", message: "errore nel servizio di localizzazione...", preferredStyle: WKAlertControllerStyle.Alert, actions: [actionClose])
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let _coordinate = locations.first {
            coordinate = _coordinate.coordinate
            
            map.removeAllAnnotations()
            map.setRegion(MKCoordinateRegion(center: coordinate, span: zoomLevel))
            
            map.addAnnotation(coordinate, withImageNamed: "Pin", centerOffset: CGPointZero)
            
            // geocoder.reverseGeocodeLocation(_coordinate, completionHandler: { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            //     if let placeArray = placemarks as [CLPlacemark]! {
            //         let placeMark: CLPlacemark! = placeArray[0]
            //
            //         var address = ""
            //
            //         if let locationName = placeMark.addressDictionary?["Name"] as? NSString {
            //             address = locationName as String
            //         }
            //
            //         if let city = placeMark.addressDictionary?["City"] as? NSString {
            //             address += " " + (city as String)
            //         }
            //     }
            // })
        }
        
        self.animateWithDuration(0.3) { () -> Void in
            self.loadingLabel.setRelativeHeight(0.0, withAdjustment: 0.0)
            self.map.setRelativeHeight(0.7, withAdjustment: 0.0)
        }
        
        WKInterfaceDevice.currentDevice().playHaptic(.Success)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch (status) {
        case .NotDetermined:
            print("NotDetermined")
            
        case .AuthorizedAlways:
            print("AuthorizedAlways")
            
        case .AuthorizedWhenInUse:
            print("AuthorizedWhenInUse")
            
        case .Denied:
            print("Denied")
            
        case .Restricted:
            print("Restricted")
        }
    }
    
}
