//
//  NSTimer+Block.m
//  Category整理
//
//  Created by 孙俊 on 2018/5/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "NSTimer+Block.h"

@implementation NSTimer (Block)

+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))inBlock repeats:(BOOL)repeats
{
    void (^block)(NSTimer *timer) = [inBlock copy];
    id ret = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(tt_timeBlock:) userInfo:block repeats:repeats];
    return ret;
}

+ (id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))inBlock repeats:(BOOL)repeats
{
    void (^block)(NSTimer *timer) = [inBlock copy];
    id ret = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(tt_timeBlock:) userInfo:block repeats:repeats];
    return ret;
}

+ (void)tt_timeBlock:(NSTimer *)inTimer;
{
    if([inTimer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[inTimer userInfo];
        block((NSTimer *)self);
    }
}

@end
