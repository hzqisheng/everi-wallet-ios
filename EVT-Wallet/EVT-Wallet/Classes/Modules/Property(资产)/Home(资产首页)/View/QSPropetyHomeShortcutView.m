//
//  QSPropetyHomeShortcutView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPropetyHomeShortcutView.h"
#import "QSTopImageBottomLabelButton.h"

@interface QSPropetyHomeShortcutView ()

@end

@implementation QSPropetyHomeShortcutView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 8;
        self.backgroundColor = [UIColor qs_colorBlack313745];
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    NSArray *imageNamesArray = @[@"icon_home_sweep",@"icon_home_pay",@"icon_home_receive",@"icon_home_send"];
    NSArray *titleArray = @[QSLocalizedString(@"qs_btn_home_scan"),QSLocalizedString(@"qs_btn_home_pay"),QSLocalizedString(@"qs_btn_home_collect"),QSLocalizedString(@"qs_btn_home_issue")];
    NSArray *itemTagsArray = @[@(QSShortcutTypeScan),@(QSShortcutTypeEveriPay),@(QSShortcutTypeCollect),@(QSShortcutTypeIssue)];

    CGFloat itemW = kHomeShortcutViewW/4;
    CGFloat itemH = kHomeShortcutViewH;
    
    for (int i = 0; i < imageNamesArray.count; i++) {
        QSTopImageBottomLabelButton *button = [[QSTopImageBottomLabelButton alloc] initWithFrame:CGRectMake(i * itemW, 0, itemW, itemH)];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor qs_colorWhiteFFFFFF] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont qs_fontOfSize13];
        [button setImage:[UIImage imageNamed:imageNamesArray[i]] forState:UIControlStateNormal];
        NSNumber *tagNumber = itemTagsArray[i];
        button.tag = tagNumber.unsignedIntegerValue;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

#pragma mark - **************** Event Response
- (void)buttonClicked:(UIButton *)button {
    if (self.delegate
        && [self.delegate respondsToSelector:@selector(shortcutView:didClickedItemByType:)]) {
        [self.delegate shortcutView:self didClickedItemByType:button.tag];
    }
}

@end
