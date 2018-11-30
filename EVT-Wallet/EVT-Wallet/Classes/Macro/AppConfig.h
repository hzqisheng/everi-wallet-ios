//
//  AppConfig.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/26.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h

//================ socail address============//
#define kShareUrlString  @"http://myevt.io/"
#define kFacebookAddress @"https://www.facebook.com/everiToken"
#define kTwitterAddress  @"https://twitter.com/everiToken"
#define kTelegramAddress @"https://t.me/everiToken"
#define kWechatAddress   @"@everiToken"

//================ localizedString ===========//
#define QSLocalizedString(key)   (NSLocalizedStringFromTable(key, @"CustomLocalizable", nil).length ? NSLocalizedStringFromTable(key, @"CustomLocalizable", nil) : @"")

//================ home ui ===================//
#define kHomeSwipeViewW           kScreenWidth
#define kHomeSwipeViewH           (kRealValue(240) + kiPhoneXTabBarExtraHeight)

#define kHomeSegmentViewTopMargin kRealValue(20)
#define kHomeSegmentViewW         kScreenWidth
#define kHomeSegmentViewH         kRealValue(50)

#define kHomeShortcutViewW        kRealValue(345)
#define kHomeShortcutViewH        kRealValue(95)

#define kHomeHeaderViewHeight     (kHomeSwipeViewH + kHomeShortcutViewH/2 + kHomeSegmentViewTopMargin + kHomeSegmentViewH)

//================= bottom button ==============//
#define kBottomButtonWidth   kRealValue(345)
#define kBottomButtonHeight  kRealValue(40)

#endif /* AppConfig_h */
