//
//  NSBundle+AppIcon.m
//  Category整理
//
//  Created by 孙俊 on 2018/5/9.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "NSBundle+AppIcon.h"

@implementation NSBundle (AppIcon)

- (NSString*)appIconPath
{
    NSString *iconFilename = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"];
    NSString *iconBasename = [iconFilename stringByDeletingPathExtension];
    NSString *iconExtension = [iconFilename pathExtension];
    return [[NSBundle mainBundle] pathForResource:iconBasename ofType:iconExtension];
}

- (UIImage*)appIcon
{
    UIImage *appIcon = [[UIImage alloc] initWithContentsOfFile:[self appIconPath]];
    return appIcon;
}

@end
