//
//  MTResultsVC.h
//  Music Test
//
//  Created by Sergey on 1/20/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBaseVC.h"

@class MTApiPoll;

@interface MTResultsVC : MTBaseVC
@property (nonatomic) MTApiPoll *pollDetails;
@end
