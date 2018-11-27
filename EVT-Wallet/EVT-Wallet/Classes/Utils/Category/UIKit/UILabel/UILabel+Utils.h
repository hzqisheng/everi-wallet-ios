//
//  UILabel+Utils.h
//  投融社
//
//  Created by 孙俊 on 2017/11/14.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Utils)
/**
 *  设置label
 *
 *  @param labelName label.text
 *  @param font font
 *  @param color color
 *  @param textAlignment textAlignment
 */
+ (UILabel *)labelWithName:(NSString *)labelName font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment;

/**
 *  改变行间距
 */
- (void)changeLineSpaceWithSpace:(CGFloat)space textAlignment:(NSTextAlignment)textAlignment;

@end
