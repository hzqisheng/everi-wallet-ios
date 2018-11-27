//
//  CAGradientLayer+NIPExtension.h
//  投融社
//
//  Created by 孙俊 on 2017/11/21.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAGradientLayer (NIPExtension)

/**
 *  生成一个渐变色的layer
 *
 *  @param frame      layer的尺寸
 *  @param startPoint 渐变色的起始位置(范围：0-1)
 *  @param endPoint   渐变色的终止位置(范围：0-1）
 *  @param colors     颜色数组
 *  @param locations  颜色分割点 (范围：0-1)
 *
 *  @return 返回一个渐变色layer
 */
+ (instancetype)gradientLayerWithFrame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray<UIColor *>*)colors locations:(NSArray*)locations;

/** 生成灰色渐变色的layer */
+ (instancetype)getGrayGradientLayerWithFrame:(CGRect)frame;

@end
