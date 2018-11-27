//
//  UILabel+Utils.m
//  投融社
//
//  Created by 孙俊 on 2017/11/14.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)

+ (UILabel *)labelWithName:(NSString *)labelName font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment{
    UILabel * label = [[UILabel alloc] init];
    if (labelName) {
        label.text = labelName;
    }
    label.textAlignment = textAlignment;
    label.font = font;
    label.textColor = color;
    return label;
}

- (void)changeLineSpaceWithSpace:(CGFloat)space textAlignment:(NSTextAlignment)textAlignment {
    if (!self.text.length) {
        return;
    }
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    if (textAlignment) {
        [paragraphStyle setAlignment:textAlignment];
    }
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}

@end
