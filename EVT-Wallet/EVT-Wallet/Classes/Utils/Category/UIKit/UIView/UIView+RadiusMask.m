//
//  UIView+RadiusMask.m
//  投融社
//
//  Created by 孙俊 on 2017/11/24.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UIView+RadiusMask.h"

@implementation UIView (RadiusMask)

- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

@end
