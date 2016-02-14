//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        invalidateUserActivity()
    }

    override func willActivate() {
        super.willActivate()
        
        invalidateUserActivity()
    }

    override func didDeactivate() {
        super.didDeactivate()
        
        invalidateUserActivity()
    }

    // MARK: - IBAction Methods
    
    @IBAction func actionOption1() {
        updateUserActivity("it.book.handoff-active", userInfo: ["option" : "opzione 1"], webpageURL: nil)
    }
    
    @IBAction func actionOption2() {
        updateUserActivity("it.book.handoff-active", userInfo: ["option" : "opzione 2"], webpageURL: nil)
    }
    
    @IBAction func actionOption3() {
        updateUserActivity("it.book.handoff-active", userInfo: ["option" : "opzione 3"], webpageURL: nil)
    }
}
