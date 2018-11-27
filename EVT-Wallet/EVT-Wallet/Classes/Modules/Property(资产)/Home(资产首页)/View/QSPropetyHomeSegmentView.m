//
//  QSPropetyHomeSegmentView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPropetyHomeSegmentView.h"

@interface QSPropetyHomeSegmentView ()

@property (nonatomic, strong) UIView *underLine;
@property (nonatomic, strong) UIButton *selectedButton;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation QSPropetyHomeSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _currentIndex = 0;
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    NSArray *titleArray = @[QSLocalizedString(@"qs_btn_home_myfts"),QSLocalizedString(@"qs_btn_home_mynfts")];
    NSArray *selectedImageNameArray = @[@"icon_bome_daibi",@"icon_home_tongzheng"];
    NSArray *nomalImageNameArray = @[@"icon_home_daibi_unpress",@"icon_home_tongzheng_unpress"];

    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 * i, 0, kScreenWidth/2, kHomeSegmentViewH)];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor qs_colorGray686868] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor qs_colorBlack313745] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:nomalImageNameArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selectedImageNameArray[i]] forState:UIControlStateSelected];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
        button.titleLabel.font = [UIFont qs_fontOfSize14];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
    self.selectedButton = self.buttonArray.firstObject;
    [self buttonClicked:self.selectedButton];
    
    CGFloat underLineW = kRealValue(45);
    CGFloat underLineH = kRealValue(2);
    self.underLine.frame = CGRectMake(self.selectedButton.width/2 - underLineW/2, self.selectedButton.maxY - underLineH, underLineW, underLineH);
    [self addSubview:self.underLine];
}

#pragma mark - **************** Event Response
- (void)buttonClicked:(UIButton *)sender {    
    for (UIButton *button in self.buttonArray) {
        button.selected = NO;
        button.titleLabel.font = [UIFont qs_fontOfSize14];
    }
    sender.selected = YES;
    sender.titleLabel.font = [UIFont qs_boldFontOfSize16];
    self.selectedButton = sender;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.underLine.centerX = sender.centerX;
    }];
    
    if (self.delegate
        && [self.delegate respondsToSelector:@selector(segmentView:didClickedAtIndex:)]) {
        [self.delegate segmentView:self didClickedAtIndex:sender.tag];
    }
}

#pragma mark - **************** Setter Getter
- (UIView *)underLine {
    if (!_underLine) {
        _underLine = [[UIView alloc] init];
        _underLine.backgroundColor = [UIColor qs_colorBlack313745];
    }
    return _underLine;
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    if (currentIndex < self.buttonArray.count) {
        UIButton *button = self.buttonArray[currentIndex];
        [self buttonClicked:button];
    }
}

@end
