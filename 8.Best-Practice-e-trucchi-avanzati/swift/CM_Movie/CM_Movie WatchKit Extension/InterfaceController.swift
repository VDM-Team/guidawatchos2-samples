//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var btnMovie: WKInterfaceMovie!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        btnMovie.setMovieURL(NSBundle.mainBundle().URLForResource("movie", withExtension: "m4v")!)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    @IBAction func actionAutoplay() {
        self.presentMediaPlayerControllerWithURL(NSBundle.mainBundle().URLForResource("movie", withExtension: "m4v")!, options: [ WKMediaPlayerControllerOptionsAutoplayKey : true]) { (value: Bool, time: NSTimeInterval, error: NSError?) -> Void in
            // NOP
        }
    }
}
