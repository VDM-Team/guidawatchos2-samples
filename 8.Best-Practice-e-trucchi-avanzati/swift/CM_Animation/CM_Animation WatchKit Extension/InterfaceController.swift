//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    let maxSize: (width: CGFloat, height: CGFloat) = (100.0, 100.0)
    let minSize: (width: CGFloat, height: CGFloat) = (50.0, 50.0)
    
    @IBOutlet var btnMegaman: WKInterfaceButton!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    // MARK: IBAction Methods
    
    @IBAction func actionZoom() {
        self.animateWithDuration(0.5) { () -> Void in
            self.btnMegaman.setWidth(self.maxSize.width)
            self.btnMegaman.setHeight(self.maxSize.height);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                self.animateWithDuration(0.5) { () -> Void in
                    self.btnMegaman.setWidth(self.minSize.width)
                    self.btnMegaman.setHeight(self.minSize.height);
                }
            })
        }
    }
}
