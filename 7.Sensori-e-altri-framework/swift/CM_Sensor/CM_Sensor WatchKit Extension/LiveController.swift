//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import CoreMotion
import Foundation
import WatchKit

class LiveController: WKInterfaceController {
    
    @IBOutlet weak var stepsLabel: WKInterfaceLabel!
    @IBOutlet weak var distanceLabel: WKInterfaceLabel!
    @IBOutlet weak var floorsLabel: WKInterfaceLabel!
    @IBOutlet weak var altitudeLabel: WKInterfaceLabel!
    @IBOutlet weak var imageActivity: WKInterfaceImage!
    
    let cm_motion = CMMotionActivityManager()
    let pedometer = CMPedometer()
    let altimeter = CMAltimeter()
    
    let lengthFormatter = NSLengthFormatter()
    
    var altitudeDelta: Double = 0.0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Formatting delle distanze
        lengthFormatter.numberFormatter.usesSignificantDigits = false
        lengthFormatter.numberFormatter.maximumSignificantDigits = 2
        lengthFormatter.unitStyle = .Short
        
        fetchDataFromMotionActivity()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    // MARK: - Private Methods
    
    private func fetchDataFromMotionActivity() {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            self.cm_motion.startActivityUpdatesToQueue(NSOperationQueue(), withHandler: { (activity: CMMotionActivity?) -> Void in
                if activity!.running {
                    self.imageActivity.setImageNamed("running")
                    
                } else if activity!.walking {
                    self.imageActivity.setImageNamed("walking")
                    
                } else if activity!.cycling {
                    self.imageActivity.setImageNamed("cycling")
                    
                } else {
                    self.imageActivity.setImageNamed("standing")
                }
            })
            
            self.altimeter.startRelativeAltitudeUpdatesToQueue(NSOperationQueue()) { (altitudeData: CMAltitudeData?, error: NSError?) -> Void in
                if error == nil {
                    if let altitude = altitudeData?.relativeAltitude {
                        self.altitudeDelta += altitude as Double
                        self.altitudeLabel.setText("\(self.lengthFormatter.stringFromValue(self.altitudeDelta / 1000.0, unit: NSLengthFormatterUnit.Kilometer))")
                        
                    } else {
                        self.altitudeLabel.setText("n/d")
                    }
                }
            }
            
            self.pedometer.startPedometerUpdatesFromDate(NSDate(), withHandler: { (pedometerData: CMPedometerData?, error: NSError?) -> Void in
                if error == nil {
                    if let floors = pedometerData?.floorsAscended {
                        self.floorsLabel.setText("\(floors)")
                        
                    } else {
                        self.floorsLabel.setText("n/d")
                    }
                    
                    if let steps = pedometerData?.numberOfSteps {
                        self.stepsLabel.setText("\(steps)")
                        
                    } else {
                        self.stepsLabel.setText("n/d")
                    }
                    
                    if let distance = pedometerData?.distance {
                        self.distanceLabel.setText("\(self.lengthFormatter.stringFromValue((distance as Double) / 1000.0, unit: NSLengthFormatterUnit.Kilometer))")
                        
                    } else {
                        self.distanceLabel.setText("n/d")
                    }
                }
            })
        })
    }
}
