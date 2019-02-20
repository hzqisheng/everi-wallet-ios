//
//  QSIssueFTNFTHelpAlertView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/2/20.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssueFTNFTHelpAlertView.h"
#import "QSIssueFTNFTHelpCell.h"

NSString * const QSIssueFTNFTHelpAlertRemindKey = @"QSIssueFTNFTHelpAlertRemindKey";

@interface QSIssueFTNFTHelpAlertView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *checkBoxButton;
@property (nonatomic, strong) NSArray *dataArray;

@end

static NSString *QSIssueFTNFTHelpCellID = @"QSIssueFTNFTHelpCellID";

@implementation QSIssueFTNFTHelpAlertView

+ (instancetype)showWithDataArray:(NSArray<QSIssueFTNFTHelpModel *> *)dataArray {
    QSIssueFTNFTHelpAlertView *popupView = [[QSIssueFTNFTHelpAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    popupView.dataArray = dataArray;
    [QSAppKeyWindow addSubview:popupView];
    [popupView show];
    return popupView;
}

+ (BOOL)isNeedRemind {
    return ![QSUserDefaults boolForKey:QSIssueFTNFTHelpAlertRemindKey];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmiss)];
//        [self addGestureRecognizer:tap];
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(319), kRealValue(630))];
        containerView.center = self.center;
        containerView.backgroundColor = [UIColor whiteColor];
        containerView.layer.cornerRadius = 13;
        [self addSubview:containerView];
        _containerView = containerView;
        
        //代币创建规则
        UILabel *titleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_issue_ft_rule_alert_title") font:[UIFont qs_boldFontOfSize16] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentCenter];
        titleLabel.frame = CGRectMake(kRealValue(15), kRealValue(27), containerView.width - kRealValue(30), kRealValue(17));
        [containerView addSubview:titleLabel];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleLabel.maxY + kRealValue(20), containerView.width, kRealValue(450)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, kRealValue(15), 0, kRealValue(15));
        _tableView.separatorColor = [UIColor qs_colorGrayCCCCCC];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[QSIssueFTNFTHelpCell class] forCellReuseIdentifier:QSIssueFTNFTHelpCellID];
        [containerView addSubview:_tableView];
        
        /*
         "qs_issue_ft_rule_alert_title"         = "FT Creation Rules";
         "qs_issue_ft_rule_alert_confrm_btn"    = "Confirm";
         "qs_issue_ft_rule_alert_remind_btn"    = "No longer reminder next time";
         */
        //确定
        UIButton *confirmButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_issue_ft_rule_alert_confrm_btn") titleColor:[UIColor qs_colorWhiteFFFFFF] font:[UIFont qs_fontOfSize15] taget:self action:@selector(confirmButtonClick)];
        confirmButton.frame = CGRectMake(containerView.width/2 - kRealValue(246)/2, _tableView.maxY + kRealValue(20), kRealValue(246), kRealValue(40));
        confirmButton.layer.cornerRadius = 2;
        confirmButton.backgroundColor = [UIColor qs_colorBlue3478F6];
        [containerView addSubview:confirmButton];
        
        //下次不再提醒
        UIButton *checkBoxButton = [UIButton buttonWithImage:@"icon_chuangjiandaibi_unselected" taget:self action:@selector(checkBoxButtonClicked:)];
        [checkBoxButton setImage:[UIImage imageNamed:@"icon_chuangjiandaibi_selected"] forState:UIControlStateSelected];
        checkBoxButton.frame = CGRectMake(kRealValue(34), confirmButton.maxY + kRealValue(10), kRealValue(30), kRealValue(30));
        [containerView addSubview:checkBoxButton];
        _checkBoxButton = checkBoxButton;
        
        UILabel *remindLabel = [UILabel labelWithName:QSLocalizedString(@"qs_issue_ft_rule_alert_remind_btn") font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
        remindLabel.frame = CGRectMake(checkBoxButton.maxX + kRealValue(5), checkBoxButton.y, kRealValue(200), checkBoxButton.height);
        [containerView addSubview:remindLabel];
    }
    return self;
}

- (void)confirmButtonClick {
    if (_checkBoxButton.selected) {
        [QSUserDefaults setBool:YES forKey:QSIssueFTNFTHelpAlertRemindKey];
    }
    
    [self dissmiss];
}

- (void)checkBoxButtonClicked:(UIButton *)button {
    button.selected = !button.selected;
}

- (void)show {
    self.containerView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.transform = CGAffineTransformIdentity;
    }];
}

- (void)dissmiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSIssueFTNFTHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:QSIssueFTNFTHelpCellID forIndexPath:indexPath];
    
    cell.titleLabel.font = [UIFont qs_fontOfSize15];
    cell.contentLabel.font = [UIFont qs_fontOfSize13];
    cell.contentLabel.textColor = [UIColor qs_colorGray686868];
    cell.issueFTNFTHelpModel = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark - **************** Setter Getter
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (void)dealloc {
    DLog(@"%@ dealloc",[self class]);
}


@end
