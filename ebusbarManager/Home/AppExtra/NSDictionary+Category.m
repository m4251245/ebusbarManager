//
//  NSDictionary+Category.m
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/9.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "NSDictionary+Category.h"

#define isNull(obj) (((NSNull *)obj == [NSNull null])?YES:NO)

@implementation NSDictionary (Category)

+ (NSDictionary *)handleNull:(NSDictionary *)dic
{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"data"] && isNull(obj)) {
            [mDic removeObjectForKey:key];
        }
        else if ([obj isKindOfClass:[NSDictionary class]] && [key isEqualToString:@"data"] && !isNull(obj)) {
            NSMutableDictionary *mDic1 = [[NSMutableDictionary alloc] initWithDictionary:obj];
            [obj enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key1, id  _Nonnull obj1, BOOL * _Nonnull stop1) {
                if ([key isEqualToString:@"lst"] && isNull(obj1)) {
                    [mDic1 removeObjectForKey:key];
                }
            }];
            [mDic setObject:mDic1 forKey:key];
        }
    }];
    return mDic;
}

@end
