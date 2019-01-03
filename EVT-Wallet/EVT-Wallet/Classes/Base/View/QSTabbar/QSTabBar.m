//
//  QSTabBar.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSTabBar.h"

@implementation QSTabBar

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (void)initView{
    _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //设定button大小为适应图片
    UIImage *normalImage = [UIImage imageNamed:QSLocalizedString(@"qs_switch_Switch_purse")];
    _centerButton.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    [_centerButton setImage:normalImage forState:UIControlStateNormal];
    //去除选择时高亮
    _centerButton.adjustsImageWhenHighlighted = NO;
    //根据图片调整button的位置(图片中心在tabbar的中间最上部，这个时候由于按钮是有一部分超出tabbar的，所以点击无效，要进行处理)
    _centerButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - normalImage.size.width)/2.0, - normalImage.size.height/2.0, normalImage.size.width, normalImage.size.height);
    [_centerButton addTarget:self action:@selector(centerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_centerButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //tabbarItem的尺寸
    CGFloat buttonW = self.frame.size.width/5.0;
    CGFloat buttonH = self.frame.size.height;
    if (kDevice_Is_iPhoneX) {
        //49 -> 83
        buttonH = buttonH - 34;
    }
    
    //中间按钮 位置
    self.centerButton.center = CGPointMake(self.frame.size.width * 0.5, buttonH/2.0 - 8);
    
    //按钮索引
    NSInteger tabbarIndex = 0;
    for (UIView * subview in self.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            subview.frame = CGRectMake(tabbarIndex * buttonW, 0, buttonW, buttonH);
            tabbarIndex ++;
            //把中间的按钮位置预留出来
            if (tabbarIndex == 2) {
                tabbarIndex ++;
            }
        }
    }
}

//event
- (void)centerButtonClicked {
    if (self.qsDelegate
        && [self.qsDelegate respondsToSelector:@selector(qsTabbarDidClickedCenterButton:)]) {
        [self.qsDelegate qsTabbarDidClickedCenterButton:self];
    }
}

//处理超出区域点击无效的问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.hidden){
        //如果tabbar隐藏了，那么直接执行系统方法
        return [super hitTest:point withEvent:event];
    } else {
        //转换坐标
        CGPoint tempPoint = [self.centerButton convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(self.centerButton.bounds, tempPoint)){
            //返回按钮
            return _centerButton;
        } else {
            return [super hitTest:point withEvent:event];
        }
    }
}

@end
