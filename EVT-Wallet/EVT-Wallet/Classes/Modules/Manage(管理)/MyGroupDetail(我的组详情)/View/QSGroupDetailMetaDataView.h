//
//  QSGroupDetailMetaDataView.h
//  EVT-Wallet
//
//  Created by SJ on 2019/5/10.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddMetaDataClickedBlock)(void);

@interface QSGroupDetailMetaDataView : UIView

@property (nonatomic, strong) NSArray *metas;

@property (nonatomic, copy) AddMetaDataClickedBlock addMetaDataBlock;

@end

@interface QSGroupDetailPerMetaDataView : UIView

- (void)refreshViewByCreator:(NSString *)creator key:(NSString *)key value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
