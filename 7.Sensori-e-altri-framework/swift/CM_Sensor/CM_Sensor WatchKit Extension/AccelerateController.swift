//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import CoreMotion
import Foundation
import WatchKit

class AccelerateController: WKInterfaceController {
    
    let kImageWidth = 35.0
    let kImageHeight = 35.0
    let kMaxWidth = (WKInterfaceDevice.currentDevice().screenBounds.size.width - 35.0)
    let kMaxHeight = (WKInterfaceDevice.currentDevice().screenBounds.size.height - 35.0 - 20.0) // 20.0 corrispondono alla barra dell'orologio
    
    @IBOutlet weak var group: WKInterfaceGroup!
    @IBOutlet weak var image: WKInterfaceImage!
    
    let motionManager = CMMotionManager()
    var imagePoint: CGPoint = CGPointZero
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        imagePoint = CGPointMake(kMaxWidth / 2.0, 0.0)
        moveImage(imagePoint)
    }
    
    override func willActivate() {
        super.willActivate()
        
        startAccelerate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        
        if motionManager.accelerometerActive == true {
            motionManager.stopAccelerometerUpdates()
        }
    }
    
    // MARK: - Private Methods
    
    private func startAccelerate() {
        if motionManager.accelerometerAvailable == true {
            motionManager.accelerometerUpdateInterval = 1.0/60.0
            
            let handler: CMAccelerometerHandler = { [unowned self](data: CMAccelerometerData?, error: NSError?) -> Void in
                var x = self.imagePoint.x
                var y = self.imagePoint.y
                
                x -= CGFloat((data?.acceleration.x)!)
                y += CGFloat((data?.acceleration.y)!)
                
                x = (x < 0) ? 0 : x;
                x = (x > self.kMaxWidth) ? self.kMaxWidth : x;
                y = (y < 0) ? 0 : y;
                y = (y > self.kMaxHeight) ? self.kMaxHeight : y;
                
                self.imagePoint = CGPointMake(x, y);
                
                self.moveImage(self.imagePoint)
            }
            
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: handler)
        }
    }
    
    private func moveImage(point: CGPoint) {
        group.setContentInset(UIEdgeInsetsMake(point.y, point.x, 0.0, 0.0))
    }
    
}
