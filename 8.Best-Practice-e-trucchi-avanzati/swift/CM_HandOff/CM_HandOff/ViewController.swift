//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func restoreUserActivityState(activity: NSUserActivity) {
        if let local_activity = activity.userInfo {
            if let option = local_activity["option"] {
                let alert = UIAlertController(title: "Popup", message: "Scelta: \(option)", preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "Close", style: .Destructive, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        super.restoreUserActivityState(activity)
    }
    
}
