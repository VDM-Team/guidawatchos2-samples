//
//  Copyright © 2016 WhiteTiger "sgama la rete". All rights reserved.
//

#import "InterfaceController.h"

@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}

#pragma mark - Private Methods

- (IBAction)actionRecorder {
    NSURL *container = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.cm_audio"];
    NSURL *fileURL = [container URLByAppendingPathComponent:@"audio.mp4"];
    
    NSDictionary *options = @{ WKAudioRecorderControllerOptionsMaximumDurationKey : @(10),
                               WKAudioRecorderControllerOptionsActionTitleKey : @"Test" };
    
    [self presentAudioRecorderControllerWithOutputURL:fileURL preset:WKAudioRecorderPresetNarrowBandSpeech options:options completion:^(BOOL didSave, NSError * _Nullable error) {
        // NOP
    }];
}

- (IBAction)actionPlay {
    NSURL *container = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.cm_audio"];
    NSURL *fileURL = [container URLByAppendingPathComponent:@"audio.mp4"];
    
    [self presentMediaPlayerControllerWithURL:fileURL options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
        // NOP
    }];
}

@end
