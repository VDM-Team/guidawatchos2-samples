//
//  ViewController.m
//  CM_HandOff
//
//  Created by WhiteTiger "sgama la rete" on 28/02/16.
//  Copyright © 2016 WhiteTiger "sgama la rete". All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)restoreUserActivityState:(NSUserActivity *)activity {
    if ([activity userInfo]) {
        NSString *option = [[activity userInfo] objectForKey:@"option"];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Popup" message:[NSString stringWithFormat:@"Scelta: %@", option] preferredStyle:(UIAlertControllerStyleAlert)];
        [alert addAction:[UIAlertAction actionWithTitle:@"Close" style:(UIAlertActionStyleDestructive) handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    [super restoreUserActivityState:activity];
}

@end
