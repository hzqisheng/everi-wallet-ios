//
//  QSManageNewNodeViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/14.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSManageNewNodeViewController.h"
#import "QSScanningViewController.h"
#import "QSEveriApiWebViewController.h"

typedef NS_ENUM(NSUInteger, QSManageNewNodeType) {
    QSManageNewNodeTypeLeaf,
    QSManageNewNodeTypeNoLeaf,
};

@interface QSManageNewNodeViewController ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) UIView *nodeNameView;
@property (nonatomic, strong) UILabel *nodeNameTitleLabel;
@property (nonatomic, strong) UILabel *nodeNameLabel;
@property (nonatomic, strong) UIButton *rightArrowButton;

@property (nonatomic, strong) UIView *nodeKeyView;
@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UITextField *nodeKeyTextField;
@property (nonatomic, strong) UIButton *sweepButton;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *thresholdView;
@property (nonatomic, strong) UILabel *thresholdLabel;
@property (nonatomic, strong) UIButton *thresholdSubtractButton;
@property (nonatomic, strong) UIButton *thresholdAddButton;
@property (nonatomic, strong) UILabel *thresholdCountLabel;
@property (nonatomic, strong) UIView *thresholdBottomLineView;

@property (nonatomic, strong) UIView *weightsView;
@property (nonatomic, strong) UILabel *weightLabel;
@property (nonatomic, strong) UIButton *weightSubtractButton;
@property (nonatomic, strong) UIButton *weightAddButton;
@property (nonatomic, strong) UILabel *weightCountLabel;

/** 默认是叶节点 */
@property (nonatomic, assign) QSManageNewNodeType newNodeType;

@end

@implementation QSManageNewNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_manage_createGroup_NewNode")];
    
    [self p_setupSubViews];
    [self chooseLeafType:QSManageNewNodeTypeLeaf];
}

- (void)p_setupSubViews {
    //2 section 1button
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.submitButton];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(45));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.top.equalTo(self.topView.mas_bottom).offset(kRealValue(10));
        make.height.equalTo(@kRealValue(91));
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - kRealValue(30), kRealValue(40)));
    }];
    
    [self p_setupNodeNameView];
    [self p_setupNodeKeyView];
    [self p_setupThresholdView];
    [self p_setupWeightsView];
}

- (void)p_setupNodeNameView {
    //nodeNameView
    [self.topView addSubview:self.nodeNameView];
    [self.nodeNameView addSubview:self.nodeNameTitleLabel];
    [self.nodeNameView addSubview:self.nodeNameLabel];
    [self.nodeNameView addSubview:self.rightArrowButton];
    
    [self.nodeNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.topView);
        make.height.equalTo(@kRealValue(45));
    }];
    
    [self.nodeNameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nodeNameView).offset(kRealValue(21));
        make.centerY.equalTo(self.nodeNameView);
        make.height.equalTo(@kRealValue(18));
    }];
    
    [self.nodeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightArrowButton.mas_left).offset(-kRealValue(14));
        make.centerY.equalTo(self.nodeNameView);
        make.height.equalTo(@kRealValue(14));
    }];
    
    [self.rightArrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.nodeNameView).offset(-kRealValue(25));
        make.centerY.equalTo(self.nodeNameView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
    }];
}

- (void)p_setupNodeKeyView {
    //nodeKeyView
    [self.bottomView addSubview:self.nodeKeyView];
    [self.nodeKeyView addSubview:self.keyLabel];
    [self.nodeKeyView addSubview:self.nodeKeyTextField];
    [self.nodeKeyView addSubview:self.sweepButton];
    [self.nodeKeyView addSubview:self.lineView];
    
    [self.nodeKeyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.bottomView);
        make.height.equalTo(@kRealValue(45));
    }];
    
    [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nodeKeyView).offset(kRealValue(21));
        make.centerY.equalTo(self.nodeKeyView);
        make.height.equalTo(@kRealValue(18));
        make.width.equalTo(@kRealValue(30));
    }];
    
    [self.nodeKeyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.keyLabel.mas_right).offset(kRealValue(10));
        make.right.equalTo(self.sweepButton.mas_left).offset(-kRealValue(14));
        make.centerY.equalTo(self.keyLabel);
        make.height.equalTo(@kRealValue(45));
    }];
    
    [self.sweepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.keyLabel);
        make.right.equalTo(self.nodeKeyView).offset(-kRealValue(25));
        make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.nodeKeyView);
        make.bottom.equalTo(self.nodeKeyView);
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
}

- (void)p_setupThresholdView {
    //thresholdView
    [self.bottomView addSubview:self.thresholdView];
    [self.thresholdView addSubview:self.thresholdLabel];
    [self.thresholdView addSubview:self.thresholdSubtractButton];
    [self.thresholdView addSubview:self.thresholdAddButton];
    [self.thresholdView addSubview:self.thresholdCountLabel];
    [self.thresholdView addSubview:self.thresholdBottomLineView];

    [self.thresholdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView);
        make.left.and.right.equalTo(self.bottomView);
        make.height.equalTo(@kRealValue(45));
    }];
    
    [self.thresholdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thresholdView).offset(kRealValue(21));
        make.centerY.equalTo(self.thresholdView);
        make.height.equalTo(@kRealValue(18));
    }];
    
    [self.thresholdSubtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.thresholdCountLabel.mas_left);
        make.centerY.equalTo(self.thresholdLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.thresholdAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.thresholdView).offset(-kRealValue(25));
        make.centerY.equalTo(self.thresholdLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.thresholdCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.thresholdAddButton.mas_left);
        make.centerY.equalTo(self.thresholdLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(30), kRealValue(24)));
    }];
    
    [self.thresholdBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.thresholdView);
        make.bottom.equalTo(self.thresholdView);
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
}

- (void)p_setupWeightsView {
    //weightsView
    [self.bottomView addSubview:self.weightsView];
    [self.weightsView addSubview:self.weightLabel];
    [self.weightsView addSubview:self.weightSubtractButton];
    [self.weightsView addSubview:self.weightAddButton];
    [self.weightsView addSubview:self.weightCountLabel];
    
    [self.weightsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nodeKeyView.mas_bottom);
        make.left.and.right.equalTo(self.bottomView);
        make.height.equalTo(@kRealValue(45));
    }];
    
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.weightsView).offset(kRealValue(21));
        make.centerY.equalTo(self.weightsView);
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.weightSubtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.weightCountLabel.mas_left);
        make.centerY.equalTo(self.weightLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.weightAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.weightsView).offset(-kRealValue(25));
        make.centerY.equalTo(self.weightLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.weightCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.weightAddButton.mas_left);
        make.centerY.equalTo(self.weightLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(30), kRealValue(24)));
    }];
}

#pragma mark - **************** Event Response
/** 选择节点类型 */
- (void)chooseNodeNameClicked {
    if (self.selectLeafOnly) {
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *noLeaf = [UIAlertAction actionWithTitle:QSLocalizedString(@"qs_manage_createGroup_Nonleaf_node") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseLeafType:QSManageNewNodeTypeNoLeaf];
    }];
    UIAlertAction *leaf = [UIAlertAction actionWithTitle:QSLocalizedString(@"qs_manage_createGroup_leaf_node") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseLeafType:QSManageNewNodeTypeLeaf];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:QSLocalizedString(@"qs_manage_createGroup_alert_cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController addAction:leaf];
    [alertController addAction:noLeaf];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)chooseLeafType:(QSManageNewNodeType)leafType {
    _newNodeType = leafType;
    self.thresholdView.hidden = leafType == QSManageNewNodeTypeLeaf;
    self.nodeKeyView.hidden = leafType != QSManageNewNodeTypeLeaf;
    self.nodeNameLabel.text = leafType == QSManageNewNodeTypeLeaf ? QSLocalizedString(@"qs_manage_createGroup_leaf_node") : QSLocalizedString(@"qs_manage_createGroup_Nonleaf_node");
}

/** 减少权重 */
- (void)weightSubtractAction {
    if ([self.weightCountLabel.text integerValue] > 1) {
        self.weightCountLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.weightCountLabel.text integerValue] - 1];
    }
}

/** 增加权重 */
- (void)weightAddAction {
    if ([self.weightCountLabel.text integerValue] < 10) {
        self.weightCountLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.weightCountLabel.text integerValue] + 1];
    }
}

/** 减少阈值 */
- (void)thresholdSubtractAction {
    if ([self.thresholdCountLabel.text integerValue] > 1) {
        self.thresholdCountLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.thresholdCountLabel.text integerValue] - 1];
    }
}

/** 增加阈值 */
- (void)thresholdAddAction {
    self.thresholdCountLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.thresholdCountLabel.text integerValue] + 1];
}

/** 扫码 */
- (void)sweepButtonClicked {
    QSScanningViewController *scan = [[QSScanningViewController alloc] init];
    @weakify(self);
    scan.parseEvtLinkAndPopBlock = ^(NSString * _Nonnull publicKey) {
        @strongify(self);
        self.nodeKeyTextField.text = publicKey;
    };
    [self.navigationController pushViewController:scan animated:YES];
}

/** 提交 */
- (void)bottomButtonClicked {
    
    [self.view endEditing:YES];

    if (self.newNodeType == QSManageNewNodeTypeLeaf) {
        //叶节点
        if (!self.nodeKeyTextField.text.length) {
            [QSAppWindow showAutoHideHudWithText:self.nodeKeyTextField.placeholder];
            return;
        }
        
        if (!self.weightCountLabel.text.length) {
            [QSAppWindow showAutoHideHudWithText:self.weightLabel.text];
            return;
        }
        
        //检查key
        [[QSEveriApiWebViewController sharedWebView] checkValidPublicKey:self.nodeKeyTextField.text andCompeleteBlock:^(NSInteger statusCode, BOOL isValid) {
            if (isValid) {
                if (self.addNewLeafNodeBlock) {
                    self.addNewLeafNodeBlock(self.nodeKeyTextField.text, self.weightCountLabel.text);
                }
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_manage_createGroup_error_key")];
            }
        }];
        
    } else if (self.newNodeType == QSManageNewNodeTypeNoLeaf) {
        //非叶节点
        if (!self.thresholdCountLabel.text.length) {
            [QSAppWindow showAutoHideHudWithText:self.thresholdLabel.text];
            return;
        }
        
        if (!self.weightCountLabel.text.length) {
            [QSAppWindow showAutoHideHudWithText:self.weightLabel.text];
            return;
        }
        
        if (self.addNewNoLeafNodeBlock) {
            self.addNewNoLeafNodeBlock(self.thresholdCountLabel.text, self.weightCountLabel.text);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - **************** Setter Getter
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _topView.layer.cornerRadius = kRealValue(8);
        _topView.layer.masksToBounds = YES;
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _bottomView.layer.cornerRadius = kRealValue(8);
        _bottomView.layer.masksToBounds = YES;
    }
    return _bottomView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_select_ft_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
        _submitButton.backgroundColor = [UIColor qs_colorBlack313745];
        _submitButton.layer.cornerRadius = 2;
    }
    return _submitButton;
}

- (UIView *)nodeNameView {
    if (!_nodeNameView) {
        _nodeNameView = [[UIView alloc] init];
        _nodeNameView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseNodeNameClicked)];
        [_nodeNameView addGestureRecognizer:tap];
    }
    return _nodeNameView;
}

- (UILabel *)nodeNameTitleLabel {
    if (!_nodeNameTitleLabel) {
        _nodeNameTitleLabel = [[UILabel alloc] init];
        _nodeNameTitleLabel.text = QSLocalizedString(@"qs_add_address_item_name_title");
        _nodeNameTitleLabel.textColor = [UIColor qs_colorBlack333333];
        _nodeNameTitleLabel.font = [UIFont qs_fontOfSize16];
    }
    return _nodeNameTitleLabel;
}

- (UILabel *)nodeNameLabel {
    if (!_nodeNameLabel) {
        _nodeNameLabel = [[UILabel alloc] init];
        _nodeNameLabel.text = QSLocalizedString(@"qs_manage_createGroup_leaf_node");
        _nodeNameLabel.textColor = [UIColor qs_colorGray686868];
        _nodeNameLabel.font = [UIFont qs_fontOfSize14];
    }
    return _nodeNameLabel;
}

- (UIButton *)rightArrowButton {
    if (!_rightArrowButton) {
        _rightArrowButton = [[UIButton alloc] init];
        _rightArrowButton.userInteractionEnabled = NO;
        [_rightArrowButton setImage:[UIImage imageNamed:@"icon_erweima_enter"] forState:UIControlStateNormal];
    }
    return _rightArrowButton;
}

- (UIView *)nodeKeyView {
    if (!_nodeKeyView) {
        _nodeKeyView = [[UIView alloc] init];
        _nodeKeyView.backgroundColor = [UIColor whiteColor];
    }
    return _nodeKeyView;
}

- (UILabel *)keyLabel {
    if (!_keyLabel) {
        _keyLabel = [[UILabel alloc] init];
        _keyLabel.text = @"Key";
        _keyLabel.textColor = [UIColor qs_colorBlack333333];
        _keyLabel.font = [UIFont qs_fontOfSize16];
    }
    return _keyLabel;
}

- (UITextField *)nodeKeyTextField {
    if (!_nodeKeyTextField) {
        _nodeKeyTextField = [[UITextField alloc] init];
        _nodeKeyTextField.placeholder = QSLocalizedString(@"qs_manage_createGroup_key_placeholder");
        _nodeKeyTextField.textColor = [UIColor qs_colorBlack333333];
        _nodeKeyTextField.font = [UIFont qs_fontOfSize14];
        [_nodeKeyTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_nodeKeyTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _nodeKeyTextField.textAlignment = NSTextAlignmentRight;
        _nodeKeyTextField.keyboardType = UIKeyboardTypeAlphabet;
    }
    return _nodeKeyTextField;
}

- (UIButton *)sweepButton {
    if (!_sweepButton) {
        _sweepButton = [[UIButton alloc] init];
        [_sweepButton setImage:[UIImage imageNamed:@"icon_xinjianjiedian_sweep"] forState:UIControlStateNormal];
        [_sweepButton addTarget:self action:@selector(sweepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sweepButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor qs_colorGrayDDDDDD];
    }
    return _lineView;
}

- (UIView *)weightsView {
    if (!_weightsView) {
        _weightsView = [[UIView alloc] init];
        _weightsView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
    }
    return _weightsView;
}

- (UILabel *)weightLabel {
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc] init];
        _weightLabel.text = QSLocalizedString(@"qs_manage_createGroup_weight");
        _weightLabel.textColor = [UIColor qs_colorBlack333333];
        _weightLabel.font = [UIFont qs_fontOfSize16];
    }
    return _weightLabel;
}

- (UIButton *)weightSubtractButton {
    if (!_weightSubtractButton) {
        _weightSubtractButton = [[UIButton alloc] init];
        [_weightSubtractButton setImage:[UIImage imageNamed:@"icon_wodeyu_minus"] forState:UIControlStateNormal];
        [_weightSubtractButton addTarget:self action:@selector(weightSubtractAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weightSubtractButton;
}

- (UIButton *)weightAddButton {
    if (!_weightAddButton) {
        _weightAddButton = [[UIButton alloc] init];
        [_weightAddButton setImage:[UIImage imageNamed:@"icon_wodeyu_plus"] forState:UIControlStateNormal];
        [_weightAddButton addTarget:self action:@selector(weightAddAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weightAddButton;
}

- (UILabel *)weightCountLabel {
    if (!_weightCountLabel) {
        _weightCountLabel = [[UILabel alloc] init];
        _weightCountLabel.text = @"1";
        _weightCountLabel.textAlignment = NSTextAlignmentCenter;
        _weightCountLabel.textColor = [UIColor qs_colorGray686868];
        _weightCountLabel.font = [UIFont qs_fontOfSize14];
    }
    return _weightCountLabel;
}

- (UIView *)thresholdView {
    if (!_thresholdView) {
        _thresholdView = [[UIView alloc] init];
        _thresholdView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
    }
    return _thresholdView;
}

- (UILabel *)thresholdLabel {
    if (!_thresholdLabel) {
        _thresholdLabel = [[UILabel alloc] init];
        _thresholdLabel.text = QSLocalizedString(@"qs_manage_createGroup_threshold");
        _thresholdLabel.textColor = [UIColor qs_colorBlack333333];
        _thresholdLabel.font = [UIFont qs_fontOfSize16];
    }
    return _thresholdLabel;
}

- (UIButton *)thresholdSubtractButton {
    if (!_thresholdSubtractButton) {
        _thresholdSubtractButton = [[UIButton alloc] init];
        [_thresholdSubtractButton setImage:[UIImage imageNamed:@"icon_wodeyu_minus"] forState:UIControlStateNormal];
        [_thresholdSubtractButton addTarget:self action:@selector(thresholdSubtractAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thresholdSubtractButton;
}

- (UIButton *)thresholdAddButton {
    if (!_thresholdAddButton) {
        _thresholdAddButton = [[UIButton alloc] init];
        [_thresholdAddButton setImage:[UIImage imageNamed:@"icon_wodeyu_plus"] forState:UIControlStateNormal];
        [_thresholdAddButton addTarget:self action:@selector(thresholdAddAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thresholdAddButton;
}

- (UILabel *)thresholdCountLabel {
    if (!_thresholdCountLabel) {
        _thresholdCountLabel = [[UILabel alloc] init];
        _thresholdCountLabel.text = @"1";
        _thresholdCountLabel.textAlignment = NSTextAlignmentCenter;
        _thresholdCountLabel.textColor = [UIColor qs_colorGray686868];
        _thresholdCountLabel.font = [UIFont qs_fontOfSize14];
    }
    return _thresholdCountLabel;
}

- (UIView *)thresholdBottomLineView {
    if (!_thresholdBottomLineView) {
        _thresholdBottomLineView = [[UIView alloc] init];
        _thresholdBottomLineView.backgroundColor = [UIColor qs_colorGrayDDDDDD];
    }
    return _thresholdBottomLineView;
}

@end
