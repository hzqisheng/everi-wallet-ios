//
//  QSSelectCurrencyView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSelectCurrencyView.h"
#import "QSSelectCurrencyCell.h"

#define kContainerViewHeight kRealValue(414)

@interface QSSelectCurrencyView ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *kSelectCurrencyCellID = @"RRProductParametersCellID";

@implementation QSSelectCurrencyView

+ (void)showSelectCurrencyView {
    QSSelectCurrencyView *view = [[QSSelectCurrencyView alloc] initWithFrame:kScreenBounds];
    [view show];
}

+ (void)showSelectCurrencyViewWithFTList:(NSArray *)FTList andSelectFTBlock:(void (^)(QSFT * _Nonnull))block {
    QSSelectCurrencyView *view = [[QSSelectCurrencyView alloc] initWithFrame:kScreenBounds];
    view.selectCurrencyViewSelectFTBlock = block;
    view.dataList = FTList;
    [view show];
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    self.maskView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self addSubview:self.maskView];
    
    self.containerView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kContainerViewHeight);
    [self addSubview:self.containerView];
    
    self.titleLabel.frame = CGRectMake(0, kRealValue(14), kScreenWidth, kRealValue(16));
    [self.containerView addSubview:self.titleLabel];
    
    self.confirmButton.frame = CGRectMake(0, 0, kRealValue(44), kRealValue(44));
    [self.containerView addSubview:self.confirmButton];
    
    self.tableView.frame = CGRectMake(0, kRealValue(44), kScreenWidth, kContainerViewHeight - kRealValue(44));
    [self.containerView addSubview:self.tableView];
}

#pragma mark - **************** Private Methods
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.3f animations:^{
        self.maskView.alpha = 0.5;
        self.containerView.y = kScreenHeight - kContainerViewHeight;
    }];
}

- (void)dissmiss {
    [UIView animateWithDuration:.3f animations:^{
        self.maskView.alpha = 0;
        self.containerView.y = kScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - **************** Event Response
- (void)confirmButtonClicked {
    [self dissmiss];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSSelectCurrencyCell *cell = [tableView dequeueReusableCellWithIdentifier:kSelectCurrencyCellID forIndexPath:indexPath];
    cell.FTModel = self.dataList[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

#pragma mark - **************** UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(55);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectCurrencyViewSelectFTBlock) {
        self.selectCurrencyViewSelectFTBlock(self.dataList[indexPath.row]);
    }
    [self dissmiss];
}

#pragma mark - **************** Setter Getter
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmiss)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor qs_colorGrayDADDE3];
    }
    return _containerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        [_tableView registerClass:[QSSelectCurrencyCell class] forCellReuseIdentifier:kSelectCurrencyCellID];
    }
    return _tableView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_everipay_select_address_popupview_title") font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithImage:@"icon_fukuan_close" taget:self action:@selector(confirmButtonClicked)];
    }
    return _confirmButton;
}


@end
