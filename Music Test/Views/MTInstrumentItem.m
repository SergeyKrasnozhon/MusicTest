//
//  MTInstrumentItem.m
//  MusicTest
//
//  Created by Sergey on 1/19/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import "MTInstrumentItem.h"

static inline double radians (double degrees) {return degrees * M_PI/180;}

#pragma mark - MTInstrumentItem
@interface MTInstrumentItem (){
    BOOL _loaded;
}
@property (nonatomic) IBOutlet UIImageView *backImageView;
@property (nonatomic) IBOutlet UIImageView *shadowImageView;
@property (nonatomic) IBOutlet UIImageView *itemImageView;
@property (nonatomic) IBOutlet UIView *itemContentView;
@end

@implementation MTInstrumentItem
-(instancetype)init{
    if(self = [super init]){
        [self xibSetup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self xibSetup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self xibSetup];
    }
    return self;
}

-(void)xibSetup{
    UIView *view = [[[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    view.frame = self.bounds;
    [self addSubview:view];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapGesture:)];
    [self.itemContentView addGestureRecognizer:singleFingerTap];
}

#pragma mark - Draw
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    _loaded = YES;
    [self updateShadow];
}

#pragma mark - Gestures
-(void)tapGesture:(UITapGestureRecognizer *)recognizer{
    [self sendActionsForControlEvents:UIControlEventTouchDown];
}

#pragma mark - Service
-(void)updateShadow{
    if(!_loaded) return;
    UIGraphicsBeginImageContextWithOptions(self.itemContentView.bounds.size,
                                           NO, 0.0);
    [self.itemContentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.shadowImageView.image = [UIImage imageWithCGImage:img.CGImage
                                                     scale:img.scale
                                               orientation:UIImageOrientationDownMirrored];;
    self.shadowImageView.alpha = self.backImageView.alpha/2;
}

-(void)makeTransformations{
    self.itemImageView.transform = CGAffineTransformMakeRotation(radians(self.itemRotateAngle));
    if(self.itemScale > 0){
        self.itemImageView.transform = CGAffineTransformScale(self.itemImageView.transform,
                                                              self.itemScale,
                                                              self.itemScale);
    }
}

#pragma mark - Accessors
-(void)setInstrumentAlpha:(CGFloat)instrumentAlpha{
    self.backImageView.alpha = instrumentAlpha;
    [self updateShadow];
}

-(CGFloat)instrumentAlpha{
    return self.backImageView.alpha;
}

-(void)setBackgroundImage:(UIImage *)backgroundImage{
    self.backImageView.image = backgroundImage;
    [self updateShadow];
}

-(UIImage *)backgroundImage{
    return self.backImageView.image;
}

-(void)setItemImage:(UIImage *)itemImage{
    self.itemImageView.image = itemImage;
    [self updateShadow];
}

-(void)setItemRotateAngle:(CGFloat)itemRotateAngle{
    _itemRotateAngle = itemRotateAngle;
    [self makeTransformations];
    [self updateShadow];
}

-(void)setItemScale:(CGFloat)itemScale{
    _itemScale = itemScale;
    [self makeTransformations];
    [self updateShadow];
}

@end




