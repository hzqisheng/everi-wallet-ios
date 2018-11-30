//
//  UIBarButtonItem+Actions.m
//  Category整理
//
//  Created by 孙俊 on 2018/5/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "UIBarButtonItem+Actions.h"
#import <objc/runtime.h>

char * const UIBarButtonItemActionBlock = "UIBarButtonItemActionBlock";

@implementation UIBarButtonItem (Actions)

+ (instancetype)fixItemSpace:(CGFloat)space
{
    UIBarButtonItem *fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fix.width = space;
    return fix;
}

- (instancetype)initWithImage:(NSString *)imageName actionBlock:(SJBarButtonActionBlock)actionBlock {
    UIButton *view = [[UIButton alloc] init];
    [view setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (self = [self initWithCustomView:view]) {
        view.frame =  CGRectMake(0, 0, 30, 44);
        [self setActionBlock:actionBlock];
        [view addTarget:self action:@selector(performActionBlock) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)color actionBlock:(SJBarButtonActionBlock)actionBlock {
    UIButton *view = [[UIButton alloc] init];
    view.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [view setTitle:title forState:UIControlStateNormal];
    [view setTitleColor:color forState:UIControlStateNormal];
    if (self = [self initWithCustomView:view]) {
        view.frame =  CGRectMake(0, 0, 44, 44);
        [self setActionBlock:actionBlock];
        [view addTarget:self action:@selector(performActionBlock) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *view = [[UIButton alloc] init];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [view setImage:image forState:UIControlStateNormal];
    view.frame =  CGRectMake(0, 0, 35, 44);
    return [self initWithCustomView:view];
}

- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action
{
    UIButton *view = [[UIButton alloc] init];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [view setTitle:title forState:UIControlStateNormal];
    [view setTitleColor:titleColor forState:UIControlStateNormal];
    view.titleLabel.font = font;
    view.frame =  CGRectMake(0, 0, 44, 44);
    return [self initWithCustomView:view];
}

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action
{
    UIButton *view = [[UIButton alloc] init];
    [view setImage:image forState:UIControlStateNormal];
    [view setTitle:title forState:UIControlStateNormal];
    [view setTitleColor:titleColor forState:UIControlStateNormal];
    view.titleLabel.font = font;
    if (target) {
        [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    view.frame =  CGRectMake(0, 0, 70, 44);
    view.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    view.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7);
    view.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return [self initWithCustomView:view];
}

- (void)performActionBlock {
    dispatch_block_t block = self.actionBlock;
    
    if (block)
        block();
}

- (SJBarButtonActionBlock)actionBlock {
    return objc_getAssociatedObject(self, UIBarButtonItemActionBlock);
}

- (void)setActionBlock:(SJBarButtonActionBlock)actionBlock {
    if (actionBlock != self.actionBlock) {
        [self willChangeValueForKey:@"actionBlock"];
        
        objc_setAssociatedObject(self, UIBarButtonItemActionBlock, actionBlock, OBJC_ASSOCIATION_COPY);
        
        [self didChangeValueForKey:@"actionBlock"];
    }
}

@end
