//
//  PlaceRowController.swift
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 20/02/16.
//  Copyright © 2016 Guida alla programmazione su watchOS 2. All rights reserved.
//

import WatchKit
import Foundation


class PlaceRowController: WKInterfaceController {

	@IBOutlet var lblPlace: WKInterfaceLabel!
	
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

}
