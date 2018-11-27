//
//  UIView+BlankPage.h
//  投融社
//
//  Created by 孙俊 on 2017/12/15.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BlankPageView;

typedef NS_ENUM(NSUInteger, BlankPageViewType) {
    BlankPageViewTypeWebView,                 //暂无网页
    BlankPageViewTypeParkAnnouncement,        //暂无园区公告
    BlankPageViewTypeNewsFlash,               //暂无要闻快讯
    BlankPageViewTypeParkActivity,            //暂无园区活动
    BlankPageViewTypeEntrepreneurshipPolicy,  //暂无创业政策
    BlankPageViewTypeMessage,                 //暂无我的消息
    BlankPageViewTypeCollectionInfo,          //暂无收藏的资讯
    BlankPageViewTypeCollectionPolicy,        //暂无收藏的政策
    BlankPageViewTypeCollectionActivity,      //暂无收藏的活动
    BlankPageViewTypeApply,                   //暂无报名
    BlankPageViewTypeParkTicket,              //暂无园区券
    BlankPageViewTypeInteraction,             //暂无动态
    BlankPageViewTypeEnterprise,              //暂无企业展示
    BlankPageViewTypeService,                 //服务
    BlankPageViewTypeDefault                  //暂无数据
};

@interface UIView (BlankPage)

#pragma mark BlankPageView
@property (strong, nonatomic) BlankPageView *blankPageView;
- (void)configBlankPage:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
- (void)configBlankPage:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY reloadButtonBlock:(void(^)(id sender))block;
- (void)configBlankPage:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError checkMoreButtonBlock:(void(^)(id sender))checkBlock reloadButtonBlock:(void(^)(id sender))reloadBlock;
- (void)configBlankPage:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY checkMoreButtonBlock:(void(^)(id sender))checkBlock reloadButtonBlock:(void(^)(id sender))reloadBlock;

@end

@interface BlankPageView : UIView
/** 提示图片 */
@property (strong, nonatomic) UIImageView *tipsImageView;
/** 提示文字 */
@property (nonatomic,strong) UILabel *tipLabel;
/** 重新加载 */
@property (nonatomic,strong) UIButton *reloadButton;
/** 没有数据 查看其它 */
@property (nonatomic,strong) UIButton *checkButton;
/** 类型 */
@property (nonatomic,assign) BlankPageViewType type;
/** 点击重新加载的回调 */
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);
/** 点击没有数据查看其它的回调 */
@property (copy, nonatomic) void(^checkButtonBlock)(id sender);
/** 空白页类型 */
@property (assign, nonatomic) BlankPageViewType curType;

/**
 * @brief 创建空白页
 *
 * @param blankPageType 空白页的类型
 * @param hasData       是否有数据
 * @param hasError      是否发生错误
 * @param offsetY       Y距离
 * @param checkBlock    没有数据 查看其它的block
 * @param block         点击重新加载回调
 */
- (void)configWithType:(BlankPageViewType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError offsetY:(CGFloat)offsetY checkButtonBlock:(void (^)(id))checkBlock reloadButtonBlock:(void(^)(id sender))block;

@end
