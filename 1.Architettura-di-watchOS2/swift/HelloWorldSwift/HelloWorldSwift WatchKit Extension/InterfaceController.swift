//
//  InterfaceController.swift
//  HelloWorldSwift WatchKit Extension
//
//  Created by vdmAuthors on 19/02/16.
//  Copyright © 2016 vdmAuthors. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var lblMessaggio: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func buttonPressed() {
        self.lblMessaggio.setText("Sono un orologio")
    }
}
