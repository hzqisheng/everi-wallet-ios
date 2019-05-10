//
//  QSCreateGroupViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateGroupViewController.h"
#import "QSManageNewNodeViewController.h"
#import "QSCreateGroupHeaderView.h"
#import "QSEveriApiWebViewController.h"

@interface QSCreateGroupViewController ()<MYTreeTableViewControllerParentClassDelegate>

@property (nonatomic, strong) QSCreateGroupHeaderView *headerView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) NSSet<MYTreeItem *> * defaultTreeItems;
@property (nonatomic, copy) NSString *defalutGroupName;
@property (nonatomic, copy) NSString *defalutThreshold;

@end

@implementation QSCreateGroupViewController

- (instancetype)initWithGroupName:(NSString *)groupName threshold:(NSString *)threshold treeItems:(NSSet<MYTreeItem *> *)treeItems {
    if (self = [super init]) {
        _defalutGroupName = groupName;
        _defalutThreshold = threshold;
        _defaultTreeItems = treeItems;
    }
    return self;
}

- (instancetype)init {
    return [self initWithGroupName:nil threshold:nil treeItems:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置header footer
    [self.headerView setupDefalutGroupName:_defalutGroupName
                                 threshold:_defalutThreshold];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    
    //设置数据源
    MYTreeTableManager *manager = [[MYTreeTableManager alloc] initWithItems:self.defaultTreeItems andExpandLevel:0];
    self.manager = manager;
    self.classDelegate = self;
    
    if (!self.defaultTreeItems.count) {
        return;
    }
    self.isShowExpandedAnimation = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self expandAllItem:YES];
        self.isShowExpandedAnimation = YES;
    });
}

#pragma mark - **************** Event Response

- (void)bottomButtonClicked {
    DLog(@"提交");
    NSString *name = self.headerView.groupName;
    NSString *rootThreshold = self.headerView.threshold;
    
    if (!name.length) {
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_add_address_item_name_placeholder")];
        return;
    }
    
    //删除没有叶子节点的node
    [self.manager deleteNoLeafItems];
    [self.tableView reloadData];
    
    //获取上传的数据
    NSArray *nodesList = [self.manager getPushGroupStructureNodes];
    
    NSDictionary *groupsStructure = @{
                                      @"name"  : name,
                                      @"group" : @{
                                              @"name" : name,
                                              @"key"  : QSPublicKey,
                                              @"root" : @{
                                                      QSNoLeafNodeThresholdKey : @(rootThreshold.integerValue),
                                                      QSNoLeafNodeWeightKey: @(0),
                                                      QSNodeKeyKey : nodesList
                                                      }
                                              }
                                      };

    [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_waiting_toast")];
    NSString *actionName = @"newgroup";
    if (self.defaultTreeItems) {
        actionName = @"updategroup";
    }
    [[QSEveriApiWebViewController sharedWebView] pushGroupByActionName:actionName groupsStructure:groupsStructure andCompeleteBlock:^(NSInteger statusCode) {
        if (statusCode == kResponseSuccessCode) {
            [QSAppKeyWindow hideHud];
            if (self.groupDidCreateSuccessBlock) {
                self.groupDidCreateSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)addNodeClicked {
    [self addChildTreeItemToTreeItemClicked:nil];
}

- (void)addChildTreeItemToTreeItemClicked:(MYTreeItem *)item {
    QSManageNewNodeViewController *newNodeVC = [[QSManageNewNodeViewController alloc] init];
    newNodeVC.selectLeafOnly = item.level == 4;
    
    //公用参数
    //节点的唯一ID
    NSString *itemID = [self getTreeItemIdByParentItem:item];
    DLog(@"%@",itemID);
    //父节点ID
    NSString *parentID = item.ID;
    //位置
    NSString *orderNo = [NSString stringWithFormat:@"%ld",(long)(item.childItems.count + 1)];
    
    newNodeVC.addNewNoLeafNodeBlock = ^(NSString * _Nonnull threshold, NSString * _Nonnull weight) {
        NSLog(@"threshold:%@, weight:%@",threshold,weight);
        //名称
        NSString *itemName = [NSString stringWithFormat:@"%@:%@ %@:%@",QSLocalizedString(@"qs_manage_createGroup_threshold"),threshold,QSLocalizedString(@"qs_manage_createGroup_weight"),weight];
        //是否是叶节点
        BOOL isLeaf = NO;
        //原始数据
        NSDictionary *data = @{
                               QSNoLeafNodeThresholdKey : @(threshold.integerValue),
                               QSNoLeafNodeWeightKey    : @(weight.integerValue)
                               };
        [self addNewTreeItemByItemName:itemName
                                itemID:itemID
                              parentID:parentID
                               orderNo:orderNo
                                isLeaf:isLeaf
                                  data:data];
    };
    
    newNodeVC.addNewLeafNodeBlock = ^(NSString * _Nonnull key, NSString * _Nonnull weight) {
        NSLog(@"key:%@, weight:%@",key,weight);
        //名称
        NSString *itemName = [NSString stringWithFormat:@"%@ %@:%@",key,QSLocalizedString(@"qs_manage_createGroup_weight"),weight];
        //是否是叶节点
        BOOL isLeaf = YES;
        //原始数据
        NSDictionary *data = @{
                               QSLeafNodeKeyKey    : key,
                               QSLeafNodeWeightKey : @(weight.integerValue)
                               };
        
        [self addNewTreeItemByItemName:itemName
                                itemID:itemID
                              parentID:parentID
                               orderNo:orderNo
                                isLeaf:isLeaf
                                  data:data];
    };
    
    [self.navigationController pushViewController:newNodeVC animated:YES];
}

- (void)addNewTreeItemByItemName:(NSString *)itemName
                          itemID:(NSString *)itemID
                        parentID:(NSString *)parentID
                         orderNo:(NSString *)orderNo
                         isLeaf:(BOOL)isLeaf
                            data:(NSDictionary *)data {
    //树模型
    MYTreeItem *newItem = [[MYTreeItem alloc] initWithName:itemName
                                                        ID:itemID
                                                  parentID:parentID
                                                   orderNo:orderNo
                                                      type:@"node"
                                                    isLeaf:isLeaf
                                                      data:data];
    
    [self.manager addItem:newItem byParentID:parentID];
    [self.tableView reloadData];
}


- (NSString *)getTreeItemIdByParentItem:(MYTreeItem *)item {
    //没有item的拼接规则 是所在的位置
    if (!item.parentID.length) {
        if (self.manager.topItems.count) {
            MYTreeItem *treeItem = self.manager.topItems.lastObject;
            return [NSString stringWithFormat:@"%lu",treeItem.ID.integerValue + 1];
        }
        return [NSString stringWithFormat:@"%lu",self.manager.topItems.count + 1];
    }
    
    //有item的拼接规则,ID+所在的位置
    NSString *postionString;
    if (item.childItems.count) {
        //所在位置为第一个item的id + 1
        MYTreeItem *treeItem = item.childItems.lastObject;
        postionString = [NSString stringWithFormat:@"%02lu",treeItem.ID.integerValue + 1];
    } else {
        postionString = [NSString stringWithFormat:@"%@01",item.ID];
    }
    
    return postionString;
}

#pragma mark - ***************** MYTreeTableViewControllerParentClassDelegate
- (void)tableViewController:(MYTreeTableViewController *)tableViewController addChildItemIn:(MYTreeItem *)item {
    //点击添加节点
    [self addChildTreeItemToTreeItemClicked:item];
}

#pragma mark - **************** Setter Getter
- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(90))];
        
        UIButton  *submitButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_select_ft_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
        submitButton.frame = CGRectMake(0, kRealValue(30), _footerView.width, kRealValue(40));
        submitButton.backgroundColor = [UIColor qs_colorBlack313745];
        submitButton.layer.cornerRadius = 2;
        [_footerView addSubview:submitButton];
    }
    return _footerView;
}

- (QSCreateGroupHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[QSCreateGroupHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(196))];
        @weakify(self);
        _headerView.addNodeClickBlock = ^{
            @strongify(self);
            [self addNodeClicked];
        };
    }
    return _headerView;
}

@end
