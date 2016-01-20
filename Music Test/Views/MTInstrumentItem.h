//
//  MTInstrumentItem.h
//  MusicTest
//
//  Created by Sergey on 1/19/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTInstrumentItem;

IB_DESIGNABLE
@interface MTInstrumentItem : UIControl
@property (nonatomic) IBInspectable CGFloat instrumentAlpha;
@property (nonatomic) IBInspectable UIImage *backgroundImage;
@property (nonatomic) IBInspectable UIImage *itemImage;
@property (nonatomic) IBInspectable CGFloat itemRotateAngle;
@property (nonatomic) IBInspectable CGFloat itemScale;
@end

