//
//  QSGroupDetailMetaDataView.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/10.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSGroupDetailMetaDataView.h"

@interface QSGroupDetailMetaDataView ()

@end

@implementation QSGroupDetailMetaDataView

- (void)setupSubViewsByMetaDatas:(NSArray *)metaDatas {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //内容视图
    UIView *contentView = [[UIView alloc] init];
    contentView.layer.cornerRadius = 8;
    contentView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kRealValue(15));
        make.left.and.right.equalTo(self);
    }];
    
    //元数据标题
    UILabel *metaDataTitleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_manage_group_detail_metadata_title") font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    [contentView addSubview:metaDataTitleLabel];
    [metaDataTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
        make.left.equalTo(contentView).offset(kRealValue(15));
        make.right.equalTo(contentView).offset(-kRealValue(15));
    }];
    
    //下划线
    UIView *metaDataTitleLabelBottomSepLine = [[UIView alloc] init];
    metaDataTitleLabelBottomSepLine.backgroundColor = [UIColor qs_colorGrayDDDDDD];
    [contentView addSubview:metaDataTitleLabelBottomSepLine];
    [metaDataTitleLabelBottomSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(metaDataTitleLabel.mas_bottom).offset(kRealValue(20));
        make.left.and.right.equalTo(contentView);
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    //元数据
    /*
     {
     creator = "[A] EVT5qn48E8eZKJb5yM24bgC1m8MdRFg5eBU76cQfDXBGXr3UYjLvY";
     key = wet;
     value = value;
     }
     */
    
    UIView *lastView = metaDataTitleLabelBottomSepLine;
    for (int i = 0; i < metaDatas.count; i++) {
        QSGroupDetailPerMetaDataView *perDataView = [[QSGroupDetailPerMetaDataView alloc] init];
        NSDictionary *metaData = metaDatas[i];
        [perDataView refreshViewByCreator:metaData[@"creator"] key:metaData[@"key"] value:metaData[@"value"]];
        [contentView addSubview:perDataView];
        [perDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView.mas_bottom);
            make.left.and.right.equalTo(contentView);
        }];
        lastView = perDataView;
    }
    
    //添加按钮
    CGFloat addButtonW = kRealValue(315);
    CGFloat addButtonH = kRealValue(56);
    UIButton *addMetaButton = [UIButton buttonWithImage:@"icon_group_detail_add_meta_background" taget:self action:@selector(addMetaDataButtonClicked)];
    [contentView addSubview:addMetaButton];
    [addMetaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).offset(kRealValue(10));
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(addButtonW, addButtonH));
        make.bottom.equalTo(contentView).offset(-kRealValue(10));
    }];

    //强制布局
    [self layoutIfNeeded];
    
    //更新高度
    self.height = contentView.maxY + kRealValue(15);
}

- (void)setMetas:(NSArray *)metas {
    _metas = metas;
    
    [self setupSubViewsByMetaDatas:metas];
}

#pragma mark - ***************** Event Response
- (void)addMetaDataButtonClicked {
    if (self.addMetaDataBlock) {
        self.addMetaDataBlock();
    }
}

@end

@interface QSGroupDetailPerMetaDataView ()

@property (nonatomic, strong) UILabel *keyTitleLabel;
@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UILabel *valueTitleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UILabel *creatorTitleLabel;
@property (nonatomic, strong) UILabel *creatorLabel;
@property (nonatomic, strong) UIView *bottomSepLine;

@end

@implementation QSGroupDetailPerMetaDataView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    [self addSubview:self.keyTitleLabel];
    [self addSubview:self.keyLabel];
    [self addSubview:self.valueTitleLabel];
    [self addSubview:self.valueLabel];
    [self addSubview:self.creatorTitleLabel];
    [self addSubview:self.creatorLabel];
    [self addSubview:self.bottomSepLine];

    [self.keyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kRealValue(10));
        make.left.equalTo(self);
        make.width.equalTo(@kRealValue(60));
    }];
    
    [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.keyTitleLabel);
        make.right.equalTo(self).offset(-kRealValue(15));
        make.left.equalTo(self.keyTitleLabel.mas_right).offset(kRealValue(5));
    }];
    
    [self.valueTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.keyLabel.mas_bottom).offset(kRealValue(5));
        make.left.and.width.equalTo(self.keyTitleLabel);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.valueTitleLabel);
        make.right.and.left.equalTo(self.keyLabel);
    }];
    
    [self.creatorTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.valueLabel.mas_bottom).offset(kRealValue(5));
        make.left.and.width.equalTo(self.keyTitleLabel);
    }];
    
    [self.creatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.creatorTitleLabel);
        make.right.and.left.equalTo(self.keyLabel);
    }];
    
    [self.bottomSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.height.equalTo(@BORDER_WIDTH_1PX);
        make.top.equalTo(self.creatorLabel.mas_bottom).offset(kRealValue(5));
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)refreshViewByCreator:(NSString *)creator key:(NSString *)key value:(NSString *)value {
    self.creatorLabel.text = creator;
    self.keyLabel.text = key;
    self.valueLabel.text = value;
}

#pragma mark - ***************** Setter Getter
- (UILabel *)keyTitleLabel {
    if (!_keyTitleLabel) {
        _keyTitleLabel = [UILabel labelWithName:@"Key:" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentRight];
    }
    return _keyTitleLabel;
}

- (UILabel *)keyLabel {
    if (!_keyLabel) {
        _keyLabel = [UILabel labelWithName:@"" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
        _keyLabel.numberOfLines = 0;
    }
    return _keyLabel;
}

- (UILabel *)valueTitleLabel {
    if (!_valueTitleLabel) {
        _valueTitleLabel = [UILabel labelWithName:[NSString stringWithFormat:@"%@:",QSLocalizedString(@"qs_add_group_metadata_value_title")] font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentRight];
    }
    return _valueTitleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [UILabel labelWithName:@"" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
        _valueLabel.numberOfLines = 0;
    }
    return _valueLabel;
}

- (UILabel *)creatorTitleLabel {
    if (!_creatorTitleLabel) {
        _creatorTitleLabel = [UILabel labelWithName:@"Creator:" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentRight];
    }
    return _creatorTitleLabel;
}

- (UILabel *)creatorLabel {
    if (!_creatorLabel) {
        _creatorLabel = [UILabel labelWithName:@"" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
        _creatorLabel.numberOfLines = 0;
    }
    return _creatorLabel;
}

- (UIView *)bottomSepLine {
    if (!_bottomSepLine) {
        _bottomSepLine = [[UIView alloc] init];
        _bottomSepLine.backgroundColor = [UIColor qs_colorGrayDDDDDD];
    }
    return _bottomSepLine;
}

@end
