//
//  UIView+BlankPage.m
//  投融社
//
//  Created by 孙俊 on 2017/12/15.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UIView+BlankPage.h"
#import <objc/runtime.h>

static char BlankPageViewKey;

@implementation UIView (BlankPage)

- (void)setBlankPageView:(BlankPageView *)blankPageView{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}

- (BlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)configBlankPage:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block {
    [self configBlankPage:blankPageType
                  hasData:hasData
                 hasError:hasError
                  offsetY:0
        reloadButtonBlock:block];
}

- (void)configBlankPage:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY reloadButtonBlock:(void (^)(id))block {
    [self configBlankPage:blankPageType
                  hasData:hasData
                 hasError:hasError
                  offsetY:offsetY
     checkMoreButtonBlock:nil
        reloadButtonBlock:block];
}

- (void)configBlankPage:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError checkMoreButtonBlock:(void (^)(id))checkBlock reloadButtonBlock:(void (^)(id))reloadBlock {
    [self configBlankPage:blankPageType
                  hasData:hasData
                 hasError:hasError
                  offsetY:0
     checkMoreButtonBlock:checkBlock
        reloadButtonBlock:reloadBlock];
}

- (void)configBlankPage:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY checkMoreButtonBlock:(void (^)(id))checkBlock reloadButtonBlock:(void (^)(id))reloadBlock {
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
            self.blankPageView = nil;
        }
    } else {
        if (!self.blankPageView) {
            CGRect bounds = self.bounds;
            if (bounds.origin.y < 0) {
                bounds.size.height = bounds.size.height - bounds.origin.y;
                bounds.origin.y = 0;
            } else if (bounds.origin.y > 0) {
                bounds.origin.y = 0;
            }
            self.blankPageView = [[BlankPageView alloc] initWithFrame:bounds];
            [self.blankPageContainer addSubview:self.blankPageView];
            [self.blankPageView configWithType:blankPageType hasData:hasData hasError:hasError offsetY:offsetY checkButtonBlock:checkBlock reloadButtonBlock:reloadBlock];
        } else {
            [self.blankPageView configWithType:blankPageType hasData:hasData hasError:hasError offsetY:0 checkButtonBlock:checkBlock reloadButtonBlock:reloadBlock];
        }
    }
}

- (UIView *)blankPageContainer {
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            //去除加载tableview上
//            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}

@end

@implementation BlankPageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)configWithType:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY checkButtonBlock:(void (^)(id))checkBlock reloadButtonBlock:(void (^)(id))block {
    _reloadButtonBlock = block;
    _checkButtonBlock = checkBlock;
    _curType = blankPageType;
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    
    //显示设置
    NSString *tipString = [self getTipsStringWithType:blankPageType];
    NSString *imageName = [self getImageNameWithType:blankPageType];
    
    //这里根据空白页图片 设置大小
    CGSize tipsImageViewSize = [self getImageViewSizeWithType:blankPageType];
    CGFloat tipsImageViewWidth = tipsImageViewSize.width;
    CGFloat tipsImageViewHeight = tipsImageViewSize.height;
    
    if (hasError) {
        tipString = @"请检查一下您的网络~";
        imageName = @"img_nonetwork_default";
        tipsImageViewWidth = kRealValue(126);
        tipsImageViewHeight = kRealValue(106);
        self.tipLabel.font = [UIFont systemFontOfSize:16];
        self.tipLabel.textColor = [UIColor purpleColor];
    } else {
        self.tipLabel.font = [UIFont systemFontOfSize:13];
        self.tipLabel.textColor = [UIColor grayColor];
    }
    self.tipLabel.text = tipString;
    self.tipsImageView.image = [UIImage imageNamed:imageName];
    
    NSString *reloadString = @"重新加载";
    [self.reloadButton setTitle:reloadString forState:UIControlStateNormal];
    
    NSString *checkMoreString = [self getCheckButtonTitleByBlankPageType:blankPageType];
    [self.checkButton setTitle:checkMoreString forState:UIControlStateNormal];

    //设置自身大小
    if (ABS(offsetY) > 0) {
        self.frame = CGRectMake(0, offsetY, self.width, self.height - offsetY);
    }
    
    //布局 加载失败
    if (hasError) {
        [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(-kRealValue(80));
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(tipsImageViewWidth, tipsImageViewHeight));
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipsImageView.mas_bottom).offset(kRealValue(20));
            make.left.equalTo(self).offset(kRealValue(30));
            make.right.equalTo(self).offset(-kRealValue(30));
        }];
        
        [self.reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.tipLabel.mas_bottom).offset(kRealValue(30));
            make.width.equalTo(@kRealValue(177));
            make.height.equalTo(@kRealValue(44));
        }];
        return;
    }
    
    [self.reloadButton removeFromSuperview];
    self.reloadButton = nil;
    
    //加载正常
    [self.tipsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(-kRealValue(50));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(tipsImageViewWidth, tipsImageViewHeight));
    }];
    
    [self.tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsImageView.mas_bottom).offset(kRealValue(20));
        make.left.equalTo(self).offset(kRealValue(30));
        make.right.equalTo(self).offset(-kRealValue(30));
    }];
    
    //有空白页查看更多 上移一些
    if (checkBlock) {
        [self.tipsImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(-kRealValue(70));
        }];
        
        [self.checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipLabel.mas_bottom).offset(kRealValue(30));
            make.centerX.equalTo(self);
            make.width.equalTo(@kRealValue(177));
            make.height.equalTo(@kRealValue(44));
        }];
    }
}

- (NSString *)getCheckButtonTitleByBlankPageType:(BlankPageViewType)blankPageType {
    NSString *checkMoreString = @"去看看";
    if (blankPageType == BlankPageViewTypeInteraction) {
        checkMoreString = @"去发动态";
    }
    return checkMoreString;
}

- (NSString *)getTipsStringWithType:(BlankPageViewType)blankPageType {
    NSString *tipString = nil;
    if (blankPageType == BlankPageViewTypeWebView
        || blankPageType == BlankPageViewTypeDefault) {
        tipString = @"暂无数据";
    } else if (blankPageType == BlankPageViewTypeParkAnnouncement) {
        tipString = @"暂时还没有园区公告哦~";
    } else if (blankPageType == BlankPageViewTypeNewsFlash) {
        tipString = @"暂时还没有相关的新闻哦~";
    } else if (blankPageType == BlankPageViewTypeParkActivity) {
        tipString = @"暂时还没有园区活动哦~";
    } else if (blankPageType == BlankPageViewTypeEntrepreneurshipPolicy) {
        tipString = @"暂时还没有创业政策哦~";
    } else if (blankPageType == BlankPageViewTypeMessage) {
        tipString = @"暂时还没有消息哦~";
    } else if (blankPageType == BlankPageViewTypeApply) {
        tipString = @"暂时还没有报过名的活动哦~";
    } else if (blankPageType == BlankPageViewTypeParkTicket) {
        tipString = @"好像还没有园区券哦~";
    } else if (blankPageType == BlankPageViewTypeInteraction) {
        tipString = @"暂时还没有圈子动态哦~";
    } else if (blankPageType == BlankPageViewTypeEnterprise) {
        tipString = @"暂无企业展示信息";
    } else if (blankPageType == BlankPageViewTypeService) {
        tipString = @"暂无服务";
    } else if (blankPageType == BlankPageViewTypeDefault) {
        tipString = @"暂无数据";
    } else if (blankPageType == BlankPageViewTypeCollectionInfo) {
        tipString = @"暂时还没有收藏的资讯";
    } else if (blankPageType == BlankPageViewTypeCollectionPolicy) {
        tipString = @"暂时还没有收藏的政策";
    } else if (blankPageType == BlankPageViewTypeCollectionActivity){
        tipString = @"暂时还没有收藏的活动";
    }
    return tipString;
}

- (NSString *)getImageNameWithType:(BlankPageViewType)blankPageType {
    NSString *imageName = nil;
    if (blankPageType == BlankPageViewTypeWebView
        || blankPageType == BlankPageViewTypeDefault) {
        imageName = @"img_wodeshoucang_noimage_normal";
    } else if (blankPageType == BlankPageViewTypeParkAnnouncement) {
        imageName = @"img_yuanqugonggao_noimage_normal";
    } else if (blankPageType == BlankPageViewTypeNewsFlash) {
        imageName = @"img_yaowenkuaixun_noimage_normal";
    } else if (blankPageType == BlankPageViewTypeParkActivity) {
        imageName = @"img_wodebaoming_noimage_normal";
    } else if (blankPageType == BlankPageViewTypeEntrepreneurshipPolicy) {
        imageName = @"img_yaowenkuaixun_noimage_normal";
    } else if (blankPageType == BlankPageViewTypeMessage) {
        imageName = @"img_wodexiaoxi_noimage_normal";
    } else if (blankPageType == BlankPageViewTypeCollectionInfo || blankPageType == BlankPageViewTypeCollectionPolicy || blankPageType == BlankPageViewTypeCollectionActivity) {
        imageName = @"img_yaowenkuaixun_noimage_normal";
    } else if (blankPageType == BlankPageViewTypeApply) {
        imageName = @"img_wodebaoming_noimage_normal";
    } else if (blankPageType == BlankPageViewTypeParkTicket) {
        imageName = @"bg_wodeyuanququan_noimage_normal";
    } else if (blankPageType == BlankPageViewTypeInteraction) {
        imageName = @"img_wodebaoming_noimage_normal";
    } else if (blankPageType == BlankPageViewTypeEnterprise) {
        imageName = @"img_yaowenkuaixun_noimage_normal";
    } else {
        imageName = @"img_wodeshoucang_noimage_normal";
    }
    return imageName;
}

- (CGSize)getImageViewSizeWithType:(BlankPageViewType)blankPageType {
    CGSize imageViewSize = CGSizeZero;
    if (blankPageType == BlankPageViewTypeWebView
        || blankPageType == BlankPageViewTypeDefault) {
        imageViewSize = CGSizeMake(kRealValue(179), kRealValue(117));
    } else if (blankPageType == BlankPageViewTypeParkAnnouncement) {
        imageViewSize = CGSizeMake(kRealValue(177), kRealValue(114));
    } else if (blankPageType == BlankPageViewTypeNewsFlash) {
        imageViewSize = CGSizeMake(kRealValue(179), kRealValue(117));
    } else if (blankPageType == BlankPageViewTypeParkActivity) {
        imageViewSize = CGSizeMake(kRealValue(177), kRealValue(116));
    } else if (blankPageType == BlankPageViewTypeEntrepreneurshipPolicy) {
        imageViewSize = CGSizeMake(kRealValue(179), kRealValue(117));
    } else if (blankPageType == BlankPageViewTypeMessage) {
        imageViewSize = CGSizeMake(kRealValue(177), kRealValue(105));
    } else if (blankPageType == BlankPageViewTypeCollectionInfo || blankPageType == BlankPageViewTypeCollectionPolicy || blankPageType == BlankPageViewTypeCollectionActivity) {
        imageViewSize = CGSizeMake(kRealValue(179), kRealValue(117));
    } else if (blankPageType == BlankPageViewTypeApply) {
        imageViewSize = CGSizeMake(kRealValue(177), kRealValue(116));
    } else if (blankPageType == BlankPageViewTypeParkTicket) {
        imageViewSize = CGSizeMake(kRealValue(179), kRealValue(115));
    } else if (blankPageType == BlankPageViewTypeInteraction) {
        imageViewSize = CGSizeMake(kRealValue(177), kRealValue(116));
    } else if (blankPageType == BlankPageViewTypeEnterprise) {
        imageViewSize = CGSizeMake(kRealValue(179), kRealValue(117));
    } else {
        imageViewSize = CGSizeMake(kRealValue(179), kRealValue(117));
    }
    return imageViewSize;
}

#pragma mark - ***************** Event Response
- (void)reloadButtonClick:(UIButton *)button {
    if (_reloadButtonBlock) {
        _reloadButtonBlock(button);
    }
}

- (void)checkButtonClick:(UIButton *)button {
    if (_checkButtonBlock) {
        _checkButtonBlock(button);
    }
}

#pragma mark - ***************** Setter Getter
- (UIImageView *)tipsImageView {
    if (!_tipsImageView) {
        _tipsImageView = [[UIImageView alloc] init];
        _tipsImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_tipsImageView];
    }
    return _tipsImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:13];
        _tipLabel.textColor = [UIColor grayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    return _tipLabel;
}

- (UIButton *)reloadButton {
    if (!_reloadButton) {
        _reloadButton = [[UIButton alloc] init];
        _reloadButton.backgroundColor = [UIColor blueColor];
        _reloadButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _reloadButton.layer.cornerRadius = 21;
        [_reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        [_reloadButton addTarget:self action:@selector(reloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reloadButton];
    }
    return _reloadButton;
}

- (UIButton *)checkButton {
    if (!_checkButton) {
        _checkButton = [[UIButton alloc] init];
        _checkButton.backgroundColor = [UIColor blueColor];
        _checkButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_checkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _checkButton.layer.cornerRadius = 21;
        [_checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_checkButton];
    }
    return _checkButton;
}

@end
