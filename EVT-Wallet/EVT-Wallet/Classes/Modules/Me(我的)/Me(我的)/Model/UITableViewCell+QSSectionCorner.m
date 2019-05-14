//
//  UITableViewCell+QSSectionCorner.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/27.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "UITableViewCell+QSSectionCorner.h"
#import <objc/runtime.h>

@implementation UITableViewCell (QSSectionCorner)

- (void)addSectionCornerWithTableView:(UITableView *)tableView
                            indexPath:(NSIndexPath *)indexPath
                      cornerViewframe:(CGRect)frame cornerRadius:(CGFloat)cornerRadius {
    
    BOOL isCornerViewFrameChange = NO;
    
    if (self.cornerV == nil) {
        UIView *backV = [[UIView alloc] initWithFrame:frame];
        backV.backgroundColor = [UIColor whiteColor];
        backV.tag = 20170802;
        [self.contentView insertSubview:backV atIndex:0];
        self.cornerV = backV;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    } else {
        if (self.cornerV.frame.size.width != frame.size.width
            || self.cornerV.frame.size.height != frame.size.height) {
            isCornerViewFrameChange = YES;
            self.cornerV.frame = frame;
        }
        [self.contentView insertSubview:self.cornerV atIndex:0];
    }

    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1
        && indexPath.row == 0) {
        if (self.cornerLay == nil) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cornerV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path = maskPath.CGPath;
            maskLayer.frame = self.cornerV.bounds;
            self.cornerLay = maskLayer;
        }
        
        if (isCornerViewFrameChange) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cornerV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            self.cornerLay.path = maskPath.CGPath;
            self.cornerLay.frame = self.cornerV.bounds;
        }
        
        self.cornerV.layer.mask = self.cornerLay;
    } else if (indexPath.row == 0) {
        if (self.topLay == nil) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cornerV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cornerV.bounds;
            maskLayer.path = maskPath.CGPath;
            self.topLay = maskLayer;
        }
        
        if (isCornerViewFrameChange) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cornerV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            self.topLay.path = maskPath.CGPath;
            self.topLay.frame = self.cornerV.bounds;
        }
        
        self.cornerV.layer.mask = self.topLay;
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
        if (self.bottomLay == nil) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cornerV.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cornerV.bounds;
            maskLayer.path = maskPath.CGPath;
            self.bottomLay = maskLayer;
        }
        
        if (isCornerViewFrameChange) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cornerV.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            self.bottomLay.path = maskPath.CGPath;
            self.bottomLay.frame = self.cornerV.bounds;
        }
        
        self.cornerV.layer.mask = self.bottomLay;
    } else {
        self.cornerV.layer.mask = nil;
    }
}

- (void)setCornerV:(UIView *)cornerV {
    objc_setAssociatedObject(self, @selector(cornerV), cornerV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)cornerV {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCornerLay:(CAShapeLayer *)cornerLay {
    objc_setAssociatedObject(self, @selector(cornerLay), cornerLay, OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)cornerLay {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTopLay:(CAShapeLayer *)topLay {
    objc_setAssociatedObject(self, @selector(topLay), topLay, OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)topLay {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBottomLay:(CAShapeLayer *)bottomLay {
    objc_setAssociatedObject(self, @selector(bottomLay), bottomLay, OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)bottomLay {
    return objc_getAssociatedObject(self, _cmd);
}

@end
