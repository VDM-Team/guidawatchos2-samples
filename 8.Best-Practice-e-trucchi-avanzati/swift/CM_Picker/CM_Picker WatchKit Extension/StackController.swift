//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import WatchKit
import Foundation

class StackController: WKInterfaceController {

    @IBOutlet var picker: WKInterfacePicker!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.createPickerItems()
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    // MARK: Private Methods
    
    private func createPickerItems() {
        var pickerItems = [WKPickerItem]()
        
        for index in 1...4 {
            let pickerItem = WKPickerItem()
            
            pickerItem.contentImage = WKImage(imageName: "card_0\(index).png")
            pickerItems.append(pickerItem)
        }
        
        picker.setItems(pickerItems)
    }
    
    @IBAction func actionPicker(value: Int) {
        
    }
    
}
