//
//  Copyright © 2016 WhiteTiger "sgama la rete". All rights reserved.
//

#import "InterfaceController.h"

@interface InterfaceController()

@property (nonatomic, weak) IBOutlet WKInterfaceButton *btnMela;

@property (nonatomic, assign) CGSize maxSize;
@property (nonatomic, assign) CGSize minSize;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.maxSize = (CGSize){ 100.0, 100.0 };
    self.minSize = (CGSize){ 50.0, 50.0 };
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}

#pragma mark - IBAction Methods

- (IBAction)actionZoom {
    [self animateWithDuration:0.5
                   animations:^{
                       [self.btnMela setWidth:self.maxSize.width];
                       [self.btnMela setHeight:self.maxSize.height];
                   }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animateWithDuration:0.5
                       animations:^{
                           [self.btnMela setWidth:self.minSize.width];
                           [self.btnMela setHeight:self.minSize.height];
                       }];
    });
}

@end
