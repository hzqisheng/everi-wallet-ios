//
//  NSFileManager+Paths.h
//  Category整理
//
//  Created by 孙俊 on 2018/5/9.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Paths)

+ (NSURL *)documentsURL;
+ (NSString *)documentsPath;


+ (NSURL *)libraryURL;
+ (NSString *)libraryPath;


+ (NSURL *)cachesURL;
+ (NSString *)cachesPath;


+ (BOOL)addSkipBackupAttributeToFile:(NSString *)path;

+ (double)availableDiskSpace;

@end
