//
//  QSPropertyHomeSwipeCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPropertyHomeSwipeCell.h"

@implementation QSPropertyHomeSwipeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    [self.contentView addSubview:self.cardImageView];
    
    [self.cardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - ***************** Event Response
- (void)tap {
    if (self.swipeCellClickedBlock) {
        self.swipeCellClickedBlock(self);
    }
}

#pragma mark - ***************** Setter Getter
- (UIImageView *)cardImageView {
    if (!_cardImageView) {
        _cardImageView = [[UIImageView alloc] init];
        _cardImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        _cardImageView.image = [UIImage imageNamed:@"img_home_banner"];
        [_cardImageView addGestureRecognizer:tapGes];
    }
    return _cardImageView;
}

@end
