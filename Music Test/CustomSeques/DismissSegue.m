//
//  DismissSegue.m
//  MoneySpace
//
//  Created by Sergey on 12/13/15.
//  Copyright © 2015 MKGroup. All rights reserved.
//

#import "DismissSegue.h"

@implementation DismissSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    [sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
