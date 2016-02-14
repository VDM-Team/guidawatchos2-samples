//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    // MARK: - IBAction Methods

    @IBAction func actionHaptickClick() {
        WKInterfaceDevice.currentDevice().playHaptic(.Click)
    }
    
    @IBAction func actionHaptickSuccess() {
        WKInterfaceDevice.currentDevice().playHaptic(.Success)
    }
    
    @IBAction func actionHaptickStop() {
        WKInterfaceDevice.currentDevice().playHaptic(.Stop)
    }
    
    @IBAction func actionHaptickRetry() {
        WKInterfaceDevice.currentDevice().playHaptic(.Retry)
    }
    
    @IBAction func actionHaptickNotification() {
        WKInterfaceDevice.currentDevice().playHaptic(.Notification)
    }
    
    @IBAction func actionHaptickFailure() {
        WKInterfaceDevice.currentDevice().playHaptic(.Failure)
    }
    
    @IBAction func actionHaptickStart() {
        WKInterfaceDevice.currentDevice().playHaptic(.Start)
    }
    
    @IBAction func actionHaptickDirectionUP() {
        WKInterfaceDevice.currentDevice().playHaptic(.DirectionUp)
    }
    
    @IBAction func actionHaptickDirectionDown() {
        WKInterfaceDevice.currentDevice().playHaptic(.DirectionDown)
    }
}
