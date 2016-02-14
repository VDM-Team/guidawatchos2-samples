//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import WatchKit
import Foundation

class ListController: WKInterfaceController {
    
    @IBOutlet var picker: WKInterfacePicker!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.createPickerItems()
        picker.focus()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    // MARK: Private Methods
    
    private func createPickerItems() {
        let itemList = [
            ("Caption 1", "UNO"),
            ("Caption 2", "DUE"),
            ("Caption 3", "TRE"),
            ("Caption 4", "QUATTRO"),
            ("Caption 5", "CINQUE"),
            ("Caption 6", "SEI"),
            ("Caption 7", "SETTE"),
            ("Caption 8", "OTTO"),
            ("Caption 9", "NOVE"),
            ("Caption 10", "DIECI")]
        
        let pickerItems: [WKPickerItem] = itemList.map {
            let pickerItem = WKPickerItem()
            
            pickerItem.caption = $0.0
            pickerItem.title = $0.1
            
            return pickerItem
        }
        
        picker.setItems(pickerItems)
    }
    
    @IBAction func actionPicker(value: Int) {
        
    }
}
