//
//  MYTreeTableViewController.m
//  MYTreeTableView
//
//  Created by mayan on 2018/4/3.
//  Copyright © 2018年 mayan. All rights reserved.
//  https://github.com/mayan29/TreeTableView


#import "MYTreeTableViewController.h"
#import "MYTreeTableManager.h"
#import "MYTreeTableViewCell.h"
#import "MYTreeTableViewSearchBar.h"

@interface MYTreeTableViewController () <MYTreeTableViewSearchBarDelegate>

@property (nonatomic, strong) MYTreeTableViewSearchBar *searchBar;

@end

@implementation MYTreeTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar = [[MYTreeTableViewSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    self.searchBar.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.frame = CGRectMake(kRealValue(15), 0, kScreenWidth - kRealValue(30), kScreenHeight - kNavgationBarHeight);
    
    
}

- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    if (pageIndex == 1) {
        if ([self.classDelegate respondsToSelector:@selector(refreshTableViewController:)]) {
            [self.classDelegate refreshTableViewController:self];
        }
    }
}


#pragma mark - Set

- (void)setManager:(MYTreeTableManager *)manager {
    _manager = manager;
    
    // 遍历外部传来的所选择的 itemId
    for (NSString *itemId in self.checkItemIds) {
        MYTreeItem *item = [self.manager getItemById:itemId];
        if (item) {
            
            // 1. 勾选所选择的节点
            [self.manager checkItem:item isCheck:YES isChildItemCheck:!self.isSingleCheck];
            
            // 2. 展开所选择的节点
            if (self.isExpandCheckedNode) {
                
                NSMutableArray *expandParentItems = [NSMutableArray array];
                
                MYTreeItem *parentItem = item.parentItem;
                while (parentItem) {
                    [expandParentItems addObject:parentItem];
                    parentItem = parentItem.parentItem;
                }
                
                for (NSUInteger i = (expandParentItems.count - 1); i < expandParentItems.count; i--) {
                    [self.manager expandItem:expandParentItems[i] isExpand:YES];
                }
            }
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.manager.showItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYTreeItem *item = self.manager.showItems[indexPath.row];
    
    MYTreeTableViewCell *cell = [MYTreeTableViewCell cellWithTableView:tableView andTreeItem:item];
    cell.isShowArrow      = self.isShowArrow;
    cell.isShowCheck      = self.isShowCheck;
    cell.isShowLevelColor = self.isShowLevelColor;
    
    /*
    if ((item.level < self.levelColorArray.count) && self.isShowLevelColor) {
        cell.backgroundColor = self.levelColorArray[item.level];
    } else {
        cell.backgroundColor = self.normalBackgroundColor;
    }
     */
    
    [cell addSectionCornerWithTableView:tableView
                              indexPath:indexPath
                        cornerViewframe:CGRectMake(0, 0, kScreenWidth - kRealValue(30), kRealValue(55))
                           cornerRadius:8];

    __weak typeof(self)wself = self;
    cell.checkButtonClickBlock = ^(MYTreeItem *item) {
        
        // 单选
        if (wself.isSingleCheck) {
            // 如果再次点击已经选中的 item 则取消选择
            if (wself.isCancelSingleCheck && (item.checkState == MYTreeItemChecked)) {
                
                [wself.manager checkItem:item isCheck:NO isChildItemCheck:NO];
                
                if ([wself.classDelegate respondsToSelector:@selector(tableViewController:checkItems:)]) {
                    [wself.classDelegate tableViewController:wself checkItems:@[]];
                }
            } else {
                
                [wself.manager checkItem:item isCheck:YES isChildItemCheck:NO];
                
                if ([wself.classDelegate respondsToSelector:@selector(tableViewController:checkItems:)]) {
                    [wself.classDelegate tableViewController:wself checkItems:@[item]];
                }
            }
        }
        // 多选
        else {
            [wself.manager checkItem:item isChildItemCheck:YES];
        }
        
        if ([wself.classDelegate respondsToSelector:@selector(tableViewController:didSelectCheckBoxRowAtIndexPath:)]) {
            [wself.classDelegate tableViewController:wself didSelectCheckBoxRowAtIndexPath:indexPath];
        }
        
        [wself.tableView reloadData];
    };
    
    cell.addButtonClickBlock = ^(MYTreeItem *item) {
        if ([wself.classDelegate respondsToSelector:@selector(tableViewController:addChildItemIn:)]) {
            [wself.classDelegate tableViewController:wself addChildItemIn:item];
        }
    };
    
    cell.deleteButtonClickBlock = ^(MYTreeItem *item) {
        [wself.manager deleteItem:item];
        
        [wself.tableView reloadData];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRealValue(55);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.isShowSearchBar ? self.searchBar : [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.isShowSearchBar ? self.searchBar.bounds.size.height : 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYTreeItem *item = self.manager.showItems[indexPath.row];
    
    [self tableView:tableView didSelectItems:@[item] isExpand:!item.isExpand];
    
    if ([self.classDelegate respondsToSelector:@selector(tableViewController:didSelectRowAtIndexPath:)]) {
        [self.classDelegate tableViewController:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [(MYTreeTableViewSearchBar *)self.tableView.tableHeaderView resignFirstResponder];
}


#pragma mark - MYSearchTextFieldDelegate

// 点击搜索框 - 用于埋点
- (void)treeTableViewSearchBarDidBeginEditing:(MYTreeTableViewSearchBar *)searchBar {
    if ([self.classDelegate respondsToSelector:@selector(searchBarDidBeginEditingInTableViewController:)]) {
        [self.classDelegate searchBarDidBeginEditingInTableViewController:self];
    }
}

// 实时查询搜索框中的文字
- (void)treeTableViewSearchBarDidEditing:(MYTreeTableViewSearchBar *)searchBar {
    [self.manager filterField:searchBar.text isChildItemCheck:!self.isSingleCheck];
    [self.tableView reloadData];
}

// 点击搜索键
- (void)treeTableViewSearchBarShouldReturn:(MYTreeTableViewSearchBar *)searchBar {
    [self.manager filterField:searchBar.text isChildItemCheck:!self.isSingleCheck];
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}


#pragma mark - Private Method

- (NSArray <NSIndexPath *>*)getUpdateIndexPathsWithCurrentIndexPath:(NSIndexPath *)indexPath andUpdateNum:(NSInteger)updateNum {
    
    NSMutableArray *tmpIndexPaths = [NSMutableArray arrayWithCapacity:updateNum];
    for (int i = 0; i < updateNum; i++) {
        NSIndexPath *tmp = [NSIndexPath indexPathForRow:(indexPath.row + 1 + i) inSection:indexPath.section];
        [tmpIndexPaths addObject:tmp];
    }
    return tmpIndexPaths;
}

- (UIColor *)getColorWithRed:(NSInteger)redNum green:(NSInteger)greenNum blue:(NSInteger)blueNum {
    return [UIColor colorWithRed:redNum/255.0 green:greenNum/255.0 blue:blueNum/255.0 alpha:1.0];
}

- (void)tableView:(UITableView *)tableView didSelectItems:(NSArray <MYTreeItem *>*)items isExpand:(BOOL)isExpand {
    
    NSMutableArray *updateIndexPaths = [NSMutableArray array];
    NSMutableArray *editIndexPaths   = [NSMutableArray array];
    
    for (MYTreeItem *item in items) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.manager.showItems indexOfObject:item] inSection:0];
        [updateIndexPaths addObject:indexPath];
        
        NSInteger updateNum = [self.manager expandItem:item];
        NSArray *tmp = [self getUpdateIndexPathsWithCurrentIndexPath:indexPath andUpdateNum:updateNum];
        [editIndexPaths addObjectsFromArray:tmp];
    }
    
    if (self.isShowExpandedAnimation) {
        if (isExpand) {
            [tableView insertRowsAtIndexPaths:editIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [tableView deleteRowsAtIndexPaths:editIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } else {
        [tableView reloadData];
    }
    
    for (NSIndexPath *indexPath in updateIndexPaths) {
        MYTreeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell updateItem];
    }
}

- (void)initialization {
    
    self.isShowExpandedAnimation  = YES;
    self.isShowArrowIfNoChildNode = NO;
    self.isShowArrow              = YES;
    self.isShowCheck              = YES;
    self.isSingleCheck            = NO;
    self.isCancelSingleCheck      = NO;
    self.isExpandCheckedNode      = YES;
    self.isShowLevelColor         = YES;
    self.isShowSearchBar          = NO;
    self.isSearchRealTime         = YES;
    
    self.normalBackgroundColor = [UIColor whiteColor];
    self.levelColorArray = @[[self getColorWithRed:255 green:255 blue:255],
                             [self getColorWithRed:255 green:255 blue:255]];
}


#pragma mark - Public Method

// 全部勾选/全部取消勾选
- (void)checkAllItem:(BOOL)isCheck {
    [self.manager checkAllItem:isCheck];
    [self.tableView reloadData];
}

// 全部展开/全部折叠 
- (void)expandAllItem:(BOOL)isExpand {
    [self expandItemWithLevel:(isExpand ? NSIntegerMax : 0)];
}

// 展开/折叠到多少层级
- (void)expandItemWithLevel:(NSInteger)expandLevel {
    
    __weak typeof(self)wself = self;
    
    [self.manager expandItemWithLevel:expandLevel completed:^(NSArray *noExpandArray) {
        
        [wself tableView:wself.tableView didSelectItems:noExpandArray isExpand:NO];

    } andCompleted:^(NSArray *expandArray) {
        
        [wself tableView:wself.tableView didSelectItems:expandArray isExpand:YES];
        
    }];
}

- (void)prepareCommit {
    if ([self.classDelegate respondsToSelector:@selector(tableViewController:checkItems:)]) {
        [self.classDelegate tableViewController:self checkItems:self.manager.allCheckItem];
    }
}

- (NSArray *)getShowItems {
    return self.manager.showItems;
}

- (NSArray *)getAllItems {
    return self.manager.allItems;
}

- (NSArray *)getCheckItems {
    return self.manager.allCheckItem;
}

- (NSSet<MYTreeItem *> *)handleRequestOriginalData:(NSDictionary *)data
                                             isAllowEditing:(BOOL)isAllowEditing {
    
    /*
     接口返回原始格式：
    
    {
        "name": "testgroup",
        "key": "EVT5RsxormWcjvVBvEdQFonu5RNG4js8Zvz9pTjABLZaYxo6NNbSJ",
        "root": {
            "threshold": 6,
            "weight": 0,
            "nodes": [{
                "threshold": 1,
                "weight": 3,
                "nodes": [{
                    "key": "EVT6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV",
                    "weight": 1
                }, {
                    "key": "EVT8MGU4aKiVzqMtWi9zLpu8KuTHZWjQQrX475ycSxEkLd6aBpraX",
                    "weight": 1
                }
                          ]
            }, {
                "key": "EVT8MGU4aKiVzqMtWi9zLpu8KuTHZWjQQrX475ycSxEkLd6aBpraX",
                "weight": 3
            }, {
                "threshold": 1,
                "weight": 3,
                "nodes": [{
                    "key": "EVT6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV",
                    "weight": 1
                }, {
                    "key": "EVT8MGU4aKiVzqMtWi9zLpu8KuTHZWjQQrX475ycSxEkLd6aBpraX",
                    "weight": 1
                }
                          ]
            }
                      ]
        }
    }
          */
    
    if (![data isKindOfClass:NSDictionary.class]) {
        return nil;
    }
    
    if (![data.allKeys containsObject:@"root"]) {
        return nil;
    }
    
    NSDictionary *rootNode = data[@"root"];
    if (![rootNode.allKeys containsObject:@"nodes"]) {
        return nil;
    }
    
    NSArray *nodeList = rootNode[@"nodes"];
    NSMutableArray *reslutList = [NSMutableArray array];
    [self tranfromDataInNodeList:nodeList
            toResultTreeItemList:reslutList
                        parentID:nil
                  isAllowEditing:isAllowEditing];
    
    NSSet *set = [[NSSet alloc] initWithArray:reslutList.copy];
    return set;
}


- (void)tranfromDataInNodeList:(NSArray *)nodeList
          toResultTreeItemList:(NSMutableArray<MYTreeItem *> *)resultList
                      parentID:(NSString *)parentID
                isAllowEditing:(BOOL)isAllowEditing {
    
    [nodeList enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BOOL isLeaf = ![obj.allKeys containsObject:QSNodeKeyKey];
        NSString *itemName;
        if (isLeaf) {
            itemName = [NSString stringWithFormat:@"%@ %@:%@",obj[QSLeafNodeKeyKey],QSLocalizedString(@"qs_manage_createGroup_weight"),obj[QSLeafNodeWeightKey]];
        } else {
            itemName = [NSString stringWithFormat:@"%@:%@ %@:%@",QSLocalizedString(@"qs_manage_createGroup_threshold"),obj[QSNoLeafNodeThresholdKey],QSLocalizedString(@"qs_manage_createGroup_weight"),obj[QSNoLeafNodeWeightKey]];
        }
        //格式 子节点：parentID+位置， 根节点：位置
        NSString *itemID = parentID ? [NSString stringWithFormat:@"%@%02lu",parentID,idx+1] : [NSString stringWithFormat:@"%lu",idx+1];
        NSString *orderNO = itemID;
        
        MYTreeItem *treeItem = [[MYTreeItem alloc] initWithName:itemName
                                                             ID:itemID
                                                       parentID:parentID
                                                        orderNo:orderNO
                                                           type:@"Node"
                                                         isLeaf:isLeaf
                                                           data:obj
                                                   allowEditing:isAllowEditing];
        [resultList addObject:treeItem];
        
        if (!isLeaf) {
            [self tranfromDataInNodeList:obj[QSNodeKeyKey]
                    toResultTreeItemList:resultList
                                parentID:itemID
                          isAllowEditing:isAllowEditing];
        }
    }];
}


@end
