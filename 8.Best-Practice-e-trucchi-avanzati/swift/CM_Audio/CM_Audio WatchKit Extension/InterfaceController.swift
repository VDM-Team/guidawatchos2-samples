//
//  Copyright © 2015 WhiteTiger "sgama la rete". All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    // MARK: - Private Methods
    
    @IBAction func actionRecorder() {
        let container = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.cm_audio")
        let fileURL = container!.URLByAppendingPathComponent("audio.mp4")
        let options = [
            WKAudioRecorderControllerOptionsMaximumDurationKey : 10,
            WKAudioRecorderControllerOptionsActionTitleKey : "Test"
        ]
        
        self.presentAudioRecorderControllerWithOutputURL(fileURL, preset: .NarrowBandSpeech, options: options) { (value: Bool, error: NSError?) -> Void in
            // NOP
        }
    }
    
    @IBAction func actionPlay() {
        let container = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.cm_audio")
        let fileURL = container!.URLByAppendingPathComponent("audio.mp4")
        
        self.presentMediaPlayerControllerWithURL(fileURL, options: nil) { (value: Bool, time: NSTimeInterval, error: NSError?) -> Void in
            // NOP
        }
    }
}
