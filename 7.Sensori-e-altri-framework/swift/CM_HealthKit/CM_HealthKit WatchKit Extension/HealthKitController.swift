//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//


import Foundation
import HealthKit
import WatchKit

class HealthKitController: WKInterfaceController {
    
    @IBOutlet weak var actionButton: WKInterfaceButton!
    @IBOutlet weak var rateLabel: WKInterfaceLabel!
    @IBOutlet weak var grpPermissionON: WKInterfaceGroup!
    @IBOutlet weak var grpPermissionOFF: WKInterfaceGroup!
    @IBOutlet weak var heartImage: WKInterfaceImage!
    
    let hk = HKHealthStore()
    let hkRateType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!
    let hkRateUnit = HKUnit(fromString: "count/min")

    var timerAnimation: NSTimer?
    var timerEnabled: Bool = false
    
    var hkRateQuery: HKQuery?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        guard HKHealthStore.isHealthDataAvailable() else {
            self.setPermission(false)
            
            return
        }
        
        hk.requestAuthorizationToShareTypes(nil, readTypes: Set([hkRateType]), completion: { (success: Bool, error: NSError?) -> Void in
            if success {
                self.setPermission(true)
                
                if self.timerEnabled {
                    self.hearthAnimationEnabled(true)
                }
                
            } else {
                self.setPermission(false)
            }
        })
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    // MARK: - Private Methods
    
    func setPermission(value: Bool) {
        self.grpPermissionOFF.setHidden(value)
        self.grpPermissionON.setHidden(!value)
    }
    
    func updateAnimation() {
        let animatedTime = 0.4
        
        animateWithDuration(animatedTime) { () -> Void in
            self.heartImage .setWidth(30)
            self.heartImage.setHeight(30)
            
            let when = dispatch_time(DISPATCH_TIME_NOW, Int64(animatedTime * double_t(NSEC_PER_SEC)))
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            
            dispatch_after(when, queue) { () -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    self.animateWithDuration(animatedTime, animations: { () -> Void in
                        self.heartImage.setWidth(60)
                        self.heartImage.setHeight(60)
                    })
                })
            }
        }
    }
    
    private func makeQuery() -> HKQuery {
        let predicate = HKQuery.predicateForSamplesWithStartDate(NSDate(), endDate: nil, options: .None)
        
        let query = HKAnchoredObjectQuery(type: hkRateType, predicate: predicate, anchor: nil, limit: Int(HKObjectQueryNoLimit)) { (query: HKAnchoredObjectQuery, sampleObjects: [HKSample]?, deletedObjects: [HKDeletedObject]?, newAnchor: HKQueryAnchor?, error: NSError?) -> Void in
            if let samples = sampleObjects {
                self.addHearthDataSamples(samples)
            }
        }
        
        // update data
        query.updateHandler = { (query: HKAnchoredObjectQuery, sampleObjects: [HKSample]?, deletedObjects: [HKDeletedObject]?, newAnchor: HKQueryAnchor?, error: NSError?) -> Void in
            if let samples = sampleObjects {
                self.addHearthDataSamples(samples)
            }
        }
        
        return query
    }
    
    private func hearthAnimationEnabled(value: Bool) {
        if let timer = timerAnimation {
            timer.invalidate()
        }
        
        timerEnabled = false
        
        if value {
            timerAnimation = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateAnimation", userInfo: nil, repeats: true)
            timerEnabled = true
        }
    }
    
    private func addHearthDataSamples(sampleObjectss: [HKSample]?) {
        guard let samples = sampleObjectss as? [HKQuantitySample] else { return }
        guard let quantity = samples.last?.quantity else { return }
        
        self.rateLabel.setText("\(quantity.doubleValueForUnit(hkRateUnit))")
    }
    
    // MARK: - IBOutlet Methods
    
    @IBAction func actionStartStopHK() {
        if self.hkRateQuery == nil {
            // action START
            self.hkRateQuery = self.makeQuery()
            self.hk.executeQuery(self.hkRateQuery!)
            self.actionButton.setTitle("Stop")
            self.rateLabel.setText("")
            
            hearthAnimationEnabled(true)
            
        } else {
            // action STOP
            self.hk.stopQuery(self.hkRateQuery!)
            self.hkRateQuery = nil
            self.actionButton.setTitle("Start")
            
            hearthAnimationEnabled(false)
        }
    }
    
}
