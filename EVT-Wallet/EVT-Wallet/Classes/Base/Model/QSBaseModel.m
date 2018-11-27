//
//  QSBaseModel.m
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/2/27.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import "QSBaseModel.h"

@implementation QSBaseModel

//解档
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        //获取类中所有成员变量名
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            //进行解档取值
            id value = [decoder decodeObjectForKey:strName];
            //利用KVC对属性赋值
            if (value) {
                [self setValue:value forKey:strName];
            }
        }
        free(ivar);
    }
    return self;
}
//归档
- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        //利用KVC取值
        id value = [self valueForKey:strName];
        if (value) {
            [encoder encodeObject:value forKey:strName];
        }
    }
    free(ivar);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ -- %@",[self mj_keyValues],[self class]];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@ -- %@(%p)",[self mj_keyValues],[self class],self];
}

@end
