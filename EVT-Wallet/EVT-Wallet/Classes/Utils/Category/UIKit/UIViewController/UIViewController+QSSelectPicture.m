//
//  UIViewController+QSSelectPicture.m
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/8/20.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import "UIViewController+QSSelectPicture.h"
#import <TZImagePickerController.h>

@implementation UIViewController (QSSelectPicture)

- (void)showPictureSelectActionSheetWithMaxPicCount:(NSInteger)maxPicCount
                                   completeBlock:(void (^)(NSArray *, BOOL))block {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:QSLocalizedString(@"qs_create_ft_take_icon_title") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        [imagePicker.rac_imageSelectedSignal subscribeNext:^(id x) {
            UIImage *seletedImage = [x objectForKey:UIImagePickerControllerEditedImage];
            if (block
                &&seletedImage) {
                block(@[seletedImage], NO);
            }
            [imagePicker dismissViewControllerAnimated:YES completion:nil];
        } completed:^{
            block(@[], YES);
            [imagePicker dismissViewControllerAnimated:YES completion:nil];
        }];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *photeLibrary = [UIAlertAction actionWithTitle:QSLocalizedString(@"qs_create_ft_select_local_icon_title") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:maxPicCount delegate:nil];
        imagePicker.allowPickingVideo = NO;
        imagePicker.showSelectBtn = NO;
        imagePicker.allowCrop = YES;
        
        imagePicker.naviTitleColor = [UIColor qs_colorWhiteFFFFFF];
        imagePicker.naviTitleFont = [UIFont qs_fontOfSize18];
        imagePicker.barItemTextFont = [UIFont qs_fontOfSize15];
        imagePicker.barItemTextColor = [UIColor qs_colorWhiteFFFFFF];
        imagePicker.statusBarStyle = UIStatusBarStyleDefault;
        imagePicker.iconThemeColor = [UIColor qs_colorBlue3F7DEF];
//
//        imagePicker.photoSelImage = [UIImage imageNamed:@"photo_sel_photoPickerVc"];
//        imagePicker.photoOriginSelImage = [UIImage imageNamed:@"photo_original_sel"];
//        imagePicker.photoNumberIconImage = [UIImage imageNamed:@"photo_number_icon"];
        
        imagePicker.photoPickerPageUIConfigBlock = ^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
            //完成按钮颜色设置
            [doneButton setTitleColor:[UIColor qs_colorBlue3F7DEF] forState:UIControlStateNormal];
            [doneButton setTitleColor:[UIColor qs_colorGray777777] forState:UIControlStateDisabled];
        };
        imagePicker.photoPreviewPageUIConfigBlock = ^(UICollectionView *collectionView, UIView *naviBar, UIButton *backButton, UIButton *selectButton, UILabel *indexLabel, UIView *toolBar, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel) {
            //完成按钮颜色设置
            [doneButton setTitleColor:[UIColor qs_colorBlue3F7DEF] forState:UIControlStateNormal];
            [doneButton setTitleColor:[UIColor qs_colorGray777777] forState:UIControlStateDisabled];
        };
        
        [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            if (block) {
                block(photos,NO);
            }
        }];
        
        [imagePicker setImagePickerControllerDidCancelHandle:^{
            if (block) {
                block(@[],YES);
            }
        }];
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(@[], YES);
        }
    }];
    [ac addAction:camera];
    [ac addAction:photeLibrary];
    [ac addAction:cancel];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
