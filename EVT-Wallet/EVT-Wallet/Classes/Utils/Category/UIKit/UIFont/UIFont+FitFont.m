//
//  UIFont+FitFont.m
//  投融社
//
//  Created by 孙俊 on 2017/11/20.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UIFont+FitFont.h"
#import <objc/message.h>

@implementation UIFont (FitFont)

+ (void)load {
    //获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    //获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    //然后交换类方法
    method_exchangeImplementations(newMethod, method);
}

+ (UIFont *)adjustFont:(CGFloat)fontSize {
    UIFont *newFont = nil;
    newFont = [UIFont adjustFont:kRealValue(fontSize)];
    return newFont;
}


@end
