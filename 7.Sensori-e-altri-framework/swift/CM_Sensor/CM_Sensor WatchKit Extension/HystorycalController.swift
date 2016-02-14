//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import CoreMotion
import Foundation
import WatchKit

class HystorycalController: WKInterfaceController {
    
    @IBOutlet weak var groupPermissionON: WKInterfaceGroup!
    @IBOutlet weak var groupPermissionOFF: WKInterfaceGroup!
    
    @IBOutlet weak var messageLbl: WKInterfaceLabel!
    @IBOutlet weak var hystorycalTable: WKInterfaceTable!
    
    let cm_motion = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    let dateFormatter = NSDateFormatter()
    let lengthFormatter = NSLengthFormatter()
    
    var collectionActivity = [CMMotionActivity]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Formatting delle date
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.timeStyle = .ShortStyle
        
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
            if CMMotionActivityManager.isActivityAvailable() {
                self.setPermission(true)
                
                let fetchTime = 0.5 * 60 * 60 as NSTimeInterval
                
                self.cm_motion.queryActivityStartingFromDate(NSDate(timeIntervalSinceNow: -fetchTime),
                    toDate: NSDate(),
                    toQueue: NSOperationQueue(),
                    withHandler: { (activity: [CMMotionActivity]?, error: NSError?) -> Void in
                        if nil != error {
                            self.setPermission(false)
                            
                        } else {
                            self.collectionActivity = activity!
                            
                            self.hystorycalTable.setNumberOfRows(self.collectionActivity.count, withRowType: hystorycalCell.cellIdentifier())
                            
                            for (index, value) in self.collectionActivity.enumerate() {
                                let row = self.hystorycalTable.rowControllerAtIndex(index) as! hystorycalCell
                                
                                row.startDate.setText("\(self.dateFormatter.stringFromDate(value.startDate))")
                                
                                if value.running || value.walking || value.cycling {
                                    self.pedometer.queryPedometerDataFromDate(value.startDate, toDate: NSDate(), withHandler: { (activity: CMPedometerData?, error: NSError?) -> Void in
                                        if nil == error {
                                            row.distance.setText("\(self.lengthFormatter.stringFromValue((activity?.distance as! Double) / 1000.0, unit: NSLengthFormatterUnit.Kilometer))")
                                            
                                            if value.running {
                                                row.imageActivity.setImageNamed("running")
                                                
                                            } else if value.walking {
                                                row.imageActivity.setImageNamed("walking")
                                                
                                            } else if value.cycling {
                                                row.imageActivity.setImageNamed("cycling")
                                            }
                                            
                                        } else {
                                            row.distance.setText("-")
                                            row.imageActivity.setImage(nil)
                                        }
                                    })
                                    
                                } else {
                                    row.distance.setText("-")
                                    row.imageActivity.setImageNamed("standing")
                                }
                            }
                        }
                })
                
            } else {
                self.setPermission(false)
            }
        })
    }
    
    private func setPermission(value: Bool) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.groupPermissionON.setHidden(!value)
            self.groupPermissionOFF.setHidden(value)
            
            self.messageLbl.setText(!value ? "Il sensore di Motion non è avviabile per il dispositivo" : "")
        }
    }
    
    // MARK: - IBAction Methods
    
    @IBAction func actionUpdate() {
        fetchDataFromMotionActivity()
    }
    
}

class hystorycalCell: NSObject {
    
    @IBOutlet weak var startDate: WKInterfaceLabel!
    @IBOutlet weak var imageActivity: WKInterfaceImage!
    @IBOutlet weak var distance: WKInterfaceLabel!
    
    class func cellIdentifier() -> String {
        return "cell.hystorycal"
    }
}
