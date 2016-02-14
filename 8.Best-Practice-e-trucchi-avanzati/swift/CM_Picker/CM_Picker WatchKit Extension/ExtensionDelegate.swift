//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        WKInterfaceController.reloadRootControllers([("listController", ""), ("stackController", ""), ("sequenceController", ""), ("coordinatorController", "")])
    }

    func applicationDidBecomeActive() {
    
    }

    func applicationWillResignActive() {
    
    }

}
