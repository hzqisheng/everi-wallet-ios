//
//  NSDictionary+Merge.h
//  Category整理
//
//  Created by 孙俊 on 2018/5/9.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Merge)

+ (NSDictionary *)dictionaryMergeWith:(NSDictionary *)dict1 and:(NSDictionary *)dict2;

- (NSDictionary *)dictionaryMergeWith:(NSDictionary *)dictionary;

@end
