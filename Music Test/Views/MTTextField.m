//
//  MTTextField.m
//  Music Test
//
//  Created by Sergey on 1/20/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import "MTTextField.h"

@implementation MTTextField

-(void)drawRect:(CGRect)rect{
    NSString *placeholder = [self placeholder];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:placeholder attributes:@{ NSForegroundColorAttributeName : [[self commonColor] colorWithAlphaComponent:0.5]}];
    self.attributedPlaceholder = str;
    [self drawBottomLine];
}

#pragma mark - Service
-(UIColor*)commonColor{
    return self.placeholderColor? :[UIColor redColor];
}

- (void)drawBottomLine // should be called in drawRect method
{
    const CGFloat bottomLineWidth = 1.f;
    CGRect frame = self.bounds;
    frame.size.height -= bottomLineWidth / 2;
    UIBezierPath *bezierBottomLine = [UIBezierPath bezierPath];
    [bezierBottomLine moveToPoint:    CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame))];
    [bezierBottomLine addLineToPoint: CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame))];
    
    if (self.isFirstResponder) {
        [[self textColor] setStroke];
    }
    else {
        [[self commonColor] setStroke];
    }
    bezierBottomLine.lineWidth = bottomLineWidth;
    [bezierBottomLine stroke];
}
@end
