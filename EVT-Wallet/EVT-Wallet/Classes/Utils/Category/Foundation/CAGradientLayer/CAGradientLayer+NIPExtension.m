//
//  CAGradientLayer+NIPExtension.m
//  投融社
//
//  Created by 孙俊 on 2017/11/21.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "CAGradientLayer+NIPExtension.h"

@implementation CAGradientLayer (NIPExtension)

+ (instancetype)gradientLayerWithFrame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray<UIColor *> *)colors locations:(NSArray *)locations
{
    // 生成一个渐变色的layer
    CAGradientLayer * layer = [CAGradientLayer layer];
    
    // 设置尺寸
    layer.frame = frame;
    
    // 渐变色区域的开始位置（位置范围 0 - 1）
    layer.startPoint = startPoint;
    
    // 渐变色区域的结束位置
    layer.endPoint = endPoint;
    
    // 设置颜色数组
    NSMutableArray * colorRefs = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorRefs addObject:(__bridge id)color.CGColor];
    }
    layer.colors = colorRefs;
    
    // 设置颜色的分割点（范围：0-1）
    layer.locations = locations;
    return layer;
}

+ (instancetype)getGrayGradientLayerWithFrame:(CGRect)frame {
    return [CAGradientLayer gradientLayerWithFrame:frame startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1) colors:@[RGBColor(@"#F6F6F6"),RGBColor(@"#FFFFFF")] locations:@[@0.2,@1]];
}

@end
