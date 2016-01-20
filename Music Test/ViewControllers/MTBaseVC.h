//
//  MTBaseVC.h
//  Music Test
//
//  Created by Sergey on 1/20/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTBaseVC : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
-(void)startActivity;
-(void)stopActivity;

@end
