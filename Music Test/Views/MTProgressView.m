//
//  MTProgressView.m
//  Music Test
//
//  Created by Sergey on 1/20/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import "MTProgressView.h"

@interface MTProgressView ()
@property (weak, nonatomic) IBOutlet UIImageView *progressImageView;
@property (weak, nonatomic) IBOutlet UILabel *progressLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightOffset;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@end

@implementation MTProgressView
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
    view.backgroundColor = self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Draw
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

#pragma mark -
-(void)setProgress:(NSUInteger)progress{
    if(progress > 100) progress = 100;
    _progress = progress;
    CGFloat workArea = self.bounds.size.width-self.rightOffset.constant;
    CGFloat width = (CGFloat)(_progress*workArea)/100;
    
    self.leftConstraint.constant = workArea-width;
    
    self.progressLbl.text = [NSString stringWithFormat:@"%zd%%", _progress];
}

-(void)setProgressAlpha:(CGFloat)progressAlpha{
    self.progressImageView.alpha = progressAlpha;
}
-(CGFloat)progressAlpha{
    return self.progressImageView.alpha;
}

-(void)setTitle:(NSString *)title{
    self.titleLbl.text = title;
}

-(NSString *)title{
    return self.titleLbl.text;
}

-(void)setProgressImage:(UIImage *)progressImage{
    self.progressImageView.image = progressImage;
}

-(UIImage *)progressImage{
    return self.progressImageView.image;
}
@end







