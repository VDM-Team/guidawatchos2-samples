//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import WatchKit
import Foundation

class CoordinatorController: WKInterfaceController {

    @IBOutlet var picker: WKInterfacePicker!
    @IBOutlet var group: WKInterfaceGroup!
    
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
        var images = [UIImage]()
        
        for index in 0..<100 {
            images.append(UIImage(named: "circle-\(index)")!)
            
            let pickerItem = WKPickerItem()
            
            pickerItem.title = "\(index+1)"
            pickerItems.append(pickerItem)
        }
        
        let imageAnimated = UIImage.animatedImageWithImages(images, duration: 0.0)
        group.setBackgroundImage(imageAnimated)
        
        picker.setCoordinatedAnimations([group])
        picker.setItems(pickerItems)
    }
    
    @IBAction func actionPicker(value: Int) {
        
    }
    
}
