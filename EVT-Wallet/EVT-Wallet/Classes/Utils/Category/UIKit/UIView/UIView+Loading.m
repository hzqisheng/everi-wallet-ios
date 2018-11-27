//
//  UIView+Loading.m
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/3/26.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import "UIView+Loading.h"

static char LoadingViewKey;

@implementation UIView (Loading)

- (void)setLoadingView:(QSCategoryLoadingView *)loadingView {
    [self willChangeValueForKey:@"LoadingViewKey"];
    objc_setAssociatedObject(self, &LoadingViewKey,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
}

- (QSCategoryLoadingView *)loadingView {
    return objc_getAssociatedObject(self, &LoadingViewKey);
}

- (void)showLoadingView:(BOOL)isLoading {
    if (!isLoading) {
        if (self.loadingView) {
            [self.loadingView dismiss];
            self.loadingView = nil;
        }
    } else {
        if (!self.loadingView) {
            self.loadingView = [[QSCategoryLoadingView alloc] initWithFrame:self.bounds];
            [self.loadingView showInView:self];
            [self addSubview:self.loadingView];
        }
    }
}

@end

@interface QSCategoryLoadingView ()

@property (nonatomic,strong) UIImageView * loadingImageView;

@property (nonatomic,strong) UILabel *loadingLabel;

@property (nonatomic,strong) UIImageView * loadingSearchImageView;

@end

@implementation QSCategoryLoadingView

- (void)showInView:(UIView *)view {
    self.backgroundColor = [UIColor whiteColor];
    //230 × 242
    CGFloat imageWidth = kRealValue(115);
    CGFloat imageHeight= kRealValue(121);
    self.loadingImageView.frame = CGRectMake(CGRectGetWidth(view.frame)/2 - imageWidth/2, CGRectGetHeight(view.frame)/2 - imageHeight + 30, imageWidth, imageHeight);
    self.loadingImageView.image = [UIImage imageNamed:@"icon_jiazaiye_document_default"];
    self.loadingLabel.frame = CGRectMake(0, CGRectGetMaxY(self.loadingImageView.frame) + kRealValue(20), CGRectGetWidth(view.frame), [UIFont systemFontOfSize:15.0f].lineHeight);
    
    self.loadingSearchImageView.image = [UIImage imageNamed:@"icon_jiazaiye_search_default"];
    self.loadingSearchImageView.frame = CGRectMake(CGRectGetHeight(self.loadingImageView.frame) - kRealValue(30), CGRectGetWidth(self.loadingImageView.frame) - kRealValue(30), kRealValue(30), kRealValue(30));
    [self showAnimation];
}

- (void)showAnimation {
    UIBezierPath *round = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.loadingImageView.width - kRealValue(35), self.loadingImageView.height - kRealValue(50), kRealValue(20), kRealValue(20)) cornerRadius:kRealValue(10)];
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = round.CGPath;
    animation.duration = 1;
    animation.repeatCount = 500;
    animation.autoreverses = NO;
    animation.calculationMode = kCAAnimationPaced;
    animation.fillMode = kCAFillModeForwards;
    [self.loadingSearchImageView.layer addAnimation:animation forKey:nil];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
//        [self.loadingImageView stopAnimating];
        self.loadingImageView = nil;
        [self removeFromSuperview];
    }];
}

#pragma mark - **************** setter getter
- (UIImageView *)loadingImageView {
    if (!_loadingImageView) {
        _loadingImageView = [[UIImageView alloc] init];
        [self addSubview:_loadingImageView];
    }
    return _loadingImageView;
}

- (UIImageView *)loadingSearchImageView {
    if (!_loadingSearchImageView) {
        _loadingSearchImageView = [[UIImageView alloc] init];
        [self.loadingImageView addSubview:_loadingSearchImageView];
    }
    return _loadingSearchImageView;
}

- (UILabel *)loadingLabel {
    if (!_loadingLabel) {
        _loadingLabel = [[UILabel alloc] init];
        _loadingLabel.font = [UIFont systemFontOfSize:16.0f];
        _loadingLabel.textColor = [UIColor colorWithHexString:@"#D4E3FF"];
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.text = @"正在加载";
        [self addSubview:_loadingLabel];
    }
    return _loadingLabel;
}

-(void)dealloc{
    DLog(@"%@ dealloc",[self class]);
}

@end
