//
//  UIViewController+QSSelectPicture.h
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/8/20.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (QSSelectPicture)

/**
 * @brief 弹出选图拍照的actionSheet
 *
 * @param maxPicCount 最大选择张数
 * @param block 选择的图片 isCancel是否是取消
 */
- (void)showPictureSelectActionSheetWithMaxPicCount:(NSInteger)maxPicCount
                                   completeBlock:(void (^)(NSArray *selectImageArray, BOOL isCancel))block;

@end
