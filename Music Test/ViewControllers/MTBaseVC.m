//
//  MTBaseVC.m
//  Music Test
//
//  Created by Sergey on 1/20/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import "MTBaseVC.h"

@interface MTBaseVC ()

@end

@implementation MTBaseVC

-(void)viewDidLoad{
    [self stopActivity];
}

#pragma mark -
-(void)startActivity{
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
}

-(void)stopActivity{
    self.activityView.hidden = YES;
    [self.activityView stopAnimating];
}
@end
