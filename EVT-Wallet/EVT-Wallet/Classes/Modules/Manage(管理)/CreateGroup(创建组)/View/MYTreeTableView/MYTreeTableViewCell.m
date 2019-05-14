//
//  MYTreeTableViewCell.m
//  MYTreeTableView
//
//  Created by mayan on 2018/4/4.
//  Copyright © 2018年 mayan. All rights reserved.
//  https://github.com/mayan29/TreeTableView


#import "MYTreeTableViewCell.h"
#import "MYTreeItem.h"

@interface MYTreeTableViewCell ()

@property (nonatomic, strong) MYTreeItem *treeItem;

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation MYTreeTableViewCell


#pragma mark - Init

+ (instancetype)cellWithTableView:(UITableView *)tableView andTreeItem:(MYTreeItem *)item {
    
    static NSString *ID = @"MYTreeTableViewCell";
    MYTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MYTreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.treeItem = item;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font              = [UIFont qs_fontOfSize16];
        self.textLabel.textColor         = [UIColor qs_colorBlack333333];
        self.textLabel.lineBreakMode     = NSLineBreakByTruncatingMiddle;
        self.indentationWidth            = kRealValue(15);
        self.selectionStyle              = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor             = [UIColor clearColor];

        [self.contentView addSubview:self.addButton];
        [self.contentView addSubview:self.deleteButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat minX = kRealValue(15) + self.indentationLevel * self.indentationWidth;
    
    if (!self.treeItem.isLeaf) {
        CGRect imageViewFrame = self.imageView.frame;
        imageViewFrame.origin.x = minX;
        self.imageView.frame = imageViewFrame;
    }
    
    CGFloat contentWidth = self.contentView.size.width;
    CGFloat contentHeight = self.contentView.size.height;
    CGRect textLabelFrame = self.textLabel.frame;
    textLabelFrame.origin.x = minX + (self.treeItem.isLeaf ? 0 : (self.imageView.bounds.size.width + 2));
    self.textLabel.frame = textLabelFrame;

    CGFloat buttonWH = kRealValue(30);
    CGFloat deleteButtonRightMargin = kRealValue(20);
    CGFloat buttonSpace = kRealValue(10);
    self.deleteButton.frame = CGRectMake(contentWidth - buttonWH - deleteButtonRightMargin, contentHeight/2 - buttonWH/2, buttonWH, buttonWH);
    
    self.addButton.frame = CGRectMake(self.deleteButton.x - buttonWH - buttonSpace, contentHeight/2 - buttonWH/2, buttonWH, buttonWH);
    
    if (self.treeItem.allowEditing) {
        //叶子 只有删除按钮
        self.textLabel.width = self.treeItem.isLeaf ? self.deleteButton.x - self.textLabel.x - buttonSpace : self.addButton.x - self.textLabel.x - buttonSpace;
    } else {
        self.textLabel.width = contentWidth - self.textLabel.x - deleteButtonRightMargin;
    }
}

#pragma mark - Setter

- (void)setTreeItem:(MYTreeItem *)treeItem {
    _treeItem = treeItem;
    
    self.indentationLevel = treeItem.level;
    self.textLabel.text   = treeItem.name;
    //MYTreeTableView.bundle/arrow
    self.imageView.image  = treeItem.isLeaf ? nil : [UIImage imageNamed:@"icon_group_tree_expand_arrow"];
    if (self.treeItem.allowEditing) {
        self.addButton.hidden = self.treeItem.isLeaf;
        self.deleteButton.hidden = NO;
    } else {
        self.addButton.hidden = YES;
        self.deleteButton.hidden = YES;
    }
        
    [self refreshArrow];
}

- (void)setIsShowArrow:(BOOL)isShowArrow {
    _isShowArrow = isShowArrow;
    
    if (!isShowArrow && self.imageView.image) {
        self.imageView.image = nil;
    }
}

- (void)setIsShowCheck:(BOOL)isShowCheck {
    _isShowCheck = isShowCheck;
    
    if (!isShowCheck && self.accessoryView) {
        self.accessoryView = nil;
    }
}


#pragma mark - Public Method

- (void)updateItem {
    // 刷新 title 前面的箭头方向
    [UIView animateWithDuration:0.25 animations:^{
        [self refreshArrow];
    }];
}

- (void)addButtonClicked {
    if (self.addButtonClickBlock) {
        self.addButtonClickBlock(self.treeItem);
    }
}

- (void)deleteButtonClicked {
    if (self.deleteButtonClickBlock) {
        self.deleteButtonClickBlock(self.treeItem);
    }
}

#pragma mark - Lazy Load

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] init];
        [_addButton setImage:[UIImage imageNamed:@"icon_wodeyu_plus1"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setImage:[UIImage imageNamed:@"icon_wodeyu_cancel"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

#pragma mark - Private Method

- (void)refreshArrow {
    
    if (self.treeItem.isExpand) {
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

@end
