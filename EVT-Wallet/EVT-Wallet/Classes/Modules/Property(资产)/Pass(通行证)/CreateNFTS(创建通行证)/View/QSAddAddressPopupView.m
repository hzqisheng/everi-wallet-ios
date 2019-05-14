//
//  QSAddAddressPopupView.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSAddAddressPopupView.h"
#import "QSScanningViewController.h"

@interface QSAddAddressPopupView ()<UIGestureRecognizerDelegate>

@property (nonatomic, copy) AddAddressConfirmBlock addAddressConfirmBlock;
@property (nonatomic, copy) NSString *title;


@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *publicKeyView;
@property (nonatomic, strong) UITextField *publicKeyTextField;
@property (nonatomic, strong) UIButton *scanButton;
@property (nonatomic, strong) UIView *weightView;
@property (nonatomic, strong) UITextField *weightTextField;
@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation QSAddAddressPopupView

+ (void)showInView:(UIView *)view
             title:(NSString *)title
      confirmBlock:(AddAddressConfirmBlock)confirmBlock {
    QSAddAddressPopupView *popupView = [[QSAddAddressPopupView alloc] initWithFrame:view.bounds];
    popupView.title = title;
    popupView.addAddressConfirmBlock = confirmBlock;
    [view addSubview:popupView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    CGFloat containerW = kScreenWidth - kRealValue(50);
    CGFloat containerH = kRealValue(200);
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - containerW/2, kRealValue(60), containerW, containerH)];
    self.containerView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
    self.containerView.layer.cornerRadius = 5;
    [self addSubview:self.containerView];
    
    self.titleLabel = [UILabel labelWithName:@"Title" font:[UIFont qs_fontOfSize16] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    self.titleLabel.frame = CGRectMake(kRealValue(15), kRealValue(20), containerW - kRealValue(30), kRealValue(17));
    [self.containerView addSubview:self.titleLabel];
    
    self.publicKeyView = [[UIView alloc] initWithFrame:CGRectMake(self.titleLabel.x, self.titleLabel.maxY + kRealValue(10), containerW - 2 * self.titleLabel.x, kRealValue(45))];
    self.publicKeyView.layer.borderWidth = BORDER_WIDTH_1PX;
    self.publicKeyView.layer.borderColor = [UIColor qs_colorGrayBBBBBB].CGColor;
    self.publicKeyView.layer.cornerRadius = 3;
    [self.containerView addSubview:self.publicKeyView];
    
    self.scanButton = [UIButton buttonWithImage:@"icon_wodeyu_sweep" taget:self action:@selector(scanButtonClicked)];
    self.scanButton.frame = CGRectMake(self.publicKeyView.width - self.publicKeyView.height, 0, self.publicKeyView.height, self.publicKeyView.height);
    [self.publicKeyView addSubview:self.scanButton];
    
    self.publicKeyTextField = [[UITextField alloc] initWithFrame:CGRectMake(kRealValue(10), 0, self.publicKeyView.width - self.scanButton.width - kRealValue(20), self.publicKeyView.height)];
    self.publicKeyTextField.textColor = [UIColor qs_colorBlack313745];
    self.publicKeyTextField.font = [UIFont qs_fontOfSize14];
    [self.publicKeyTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
    [self.publicKeyTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
    self.publicKeyTextField.placeholder = QSLocalizedString(@"qs_pass_createNFTS_add_public_key_placeholer");
    self.publicKeyTextField.textAlignment = NSTextAlignmentLeft;
    self.publicKeyTextField.keyboardType = UIKeyboardTypeAlphabet;
    [self.publicKeyView addSubview:self.publicKeyTextField];

    self.weightView = [[UIView alloc] initWithFrame:CGRectMake(self.publicKeyView.x, self.publicKeyView.maxY + kRealValue(10), self.publicKeyView.width, self.publicKeyView.height)];
    self.weightView.layer.borderWidth = BORDER_WIDTH_1PX;
    self.weightView.layer.borderColor = [UIColor qs_colorGrayBBBBBB].CGColor;
    self.weightView.layer.cornerRadius = 3;
    [self.containerView addSubview:self.weightView];
    
    self.weightTextField = [[UITextField alloc] initWithFrame:CGRectMake(kRealValue(10), 0, self.publicKeyView.width - kRealValue(20), self.weightView.height)];
    self.weightTextField.textColor = [UIColor qs_colorBlack313745];
    self.weightTextField.font = [UIFont qs_fontOfSize14];
    [self.weightTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
    [self.weightTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
    self.weightTextField.placeholder = QSLocalizedString(@"qs_pass_createNFTS_add_weight_placeholer");
    self.weightTextField.textAlignment = NSTextAlignmentLeft;
    self.weightTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.weightView addSubview:self.weightTextField];
    
    self.confirmButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_pass_createNFTS_commit_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize15] taget:self action:@selector(submitButtonClicked)];
    self.confirmButton.backgroundColor = [UIColor qs_colorBlack313745];
    self.confirmButton.layer.cornerRadius = 2;
    self.confirmButton.frame = CGRectMake(self.weightView.x, self.weightView.maxY + kRealValue(10) , self.weightView.width, self.weightView.height);
    [self.containerView addSubview:self.confirmButton];
 
    self.containerView.height = self.confirmButton.maxY + kRealValue(15);
}

#pragma mark - ***************** Event Response
- (void)scanButtonClicked {
    QSScanningViewController *scan = [[QSScanningViewController alloc] init];
    @weakify(self);
    scan.parseEvtLinkAndPopBlock = ^(NSString * _Nonnull publicKey) {
        @strongify(self);
        self.publicKeyTextField.text = publicKey;
    };
    [[UIViewController currentViewController].navigationController pushViewController:scan animated:YES];
}

- (void)submitButtonClicked {
    [self endEditing:YES];
    
    if (!self.publicKeyTextField.text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:self.publicKeyTextField.placeholder];
        return;
    }
    
    if (!self.weightTextField.text.length) {
        [QSAppKeyWindow showAutoHideHudWithText:self.weightTextField.placeholder];
        return;
    }
    
    
    
    if (self.addAddressConfirmBlock) {
        self.addAddressConfirmBlock(self.publicKeyTextField.text, self.weightTextField.text);
    }
    
    [self removeFromSuperview];
}


#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view == self.containerView) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - ***************** Setter Getter
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

@end
