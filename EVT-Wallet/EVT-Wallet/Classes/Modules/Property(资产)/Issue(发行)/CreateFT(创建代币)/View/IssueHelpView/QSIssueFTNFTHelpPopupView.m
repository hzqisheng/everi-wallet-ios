//
//  QSCreateFTHelpPopupView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssueFTNFTHelpPopupView.h"
#import "QSIssueFTNFTHelpCell.h"

@interface QSIssueFTNFTHelpPopupView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

static NSString *QSIssueFTNFTHelpCellID = @"QSIssueFTNFTHelpCellID";

@implementation QSIssueFTNFTHelpPopupView

+ (instancetype)showInView:(UIView *)view dataArray:(NSArray<QSIssueFTNFTHelpModel *> *)dataArray {
    QSIssueFTNFTHelpPopupView *popupView = [[QSIssueFTNFTHelpPopupView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavgationBarHeight)];
    popupView.dataArray = dataArray;
    [view addSubview:popupView];
    [popupView show];
    return popupView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmiss)];
        [self addGestureRecognizer:tap];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -kScreenHeight, kScreenWidth, kScreenHeight - kNavgationBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorInset = UIEdgeInsetsMake(0, kRealValue(15), 0, kRealValue(15));
        _tableView.separatorColor = [UIColor qs_colorGrayCCCCCC];
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[QSIssueFTNFTHelpCell class] forCellReuseIdentifier:QSIssueFTNFTHelpCellID];
        [self addSubview:_tableView];
    }
    return self;
}

- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.y = 0;
    }];
}

- (void)dissmiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.y = -kScreenHeight;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - **************** UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QSIssueFTNFTHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:QSIssueFTNFTHelpCellID forIndexPath:indexPath];
    
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
