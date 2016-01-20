//
//  MTProgressView.h
//  Music Test
//
//  Created by Sergey on 1/20/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface MTProgressView : UIView
@property (nonatomic) IBInspectable CGFloat progressAlpha;
@property (nonatomic) IBInspectable NSUInteger progress;
@property (nonatomic) IBInspectable NSString *title;
@property (nonatomic) IBInspectable UIImage *progressImage;
@end
