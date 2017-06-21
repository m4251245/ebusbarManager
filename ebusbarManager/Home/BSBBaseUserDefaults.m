//
//  BSBBaseUserDefaults.m
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/4.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "BSBBaseUserDefaults.h"

@implementation BSBBaseUserDefaults

//存
+ (void)setObj:(id)value forKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//取
+ (id)getObjWithKey:(NSString *)defaultName
{
   return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

@end

@implementation BSBSaveUserInfo

+ (void)saveUserId:(NSString *)userId
{
    [BSBSaveUserInfo setObj:userId forKey:@"userId"];
}
+ (NSString *)getUserId
{
    return [BSBSaveUserInfo getObjWithKey:@"userId"];
}

+ (void)saveMobile:(NSString *)mobile
{
    [BSBSaveUserInfo setObj:mobile forKey:@"userMobile"];
}
+ (NSString *)getMobile
{
    return [BSBSaveUserInfo getObjWithKey:@"userMobile"];
}

+ (void)saveUserPassWord:(NSString *)password
{
    [BSBSaveUserInfo setObj:password forKey:@"userPassWord"];
}
+ (NSString *)getUserPassWord
{
    return [BSBSaveUserInfo getObjWithKey:@"userPassWord"];
}

+ (void)saveUserName:(NSString *)userName
{
    [BSBSaveUserInfo setObj:userName forKey:@"userName"];
}
+ (NSString *)getUserName
{
    return [BSBSaveUserInfo getObjWithKey:@"userName"];
}

+ (void)saveSessionKey:(NSString *)sessionKey
{
    [BSBSaveUserInfo setObj:sessionKey forKey:@"sessionKey"];
}
+ (NSString *)getSessionKey
{
    return [BSBSaveUserInfo getObjWithKey:@"sessionKey"];
}

+ (void)saveUserSex:(NSNumber *)sex
{
    [BSBSaveUserInfo setObj:sex forKey:@"userSex"];
}
+ (NSNumber *)getSex
{
    return [BSBSaveUserInfo getObjWithKey:@"userSex"];
}


+ (void)saveLogin:(BOOL)login
{
    [[NSUserDefaults standardUserDefaults] setBool:login forKey:@"login"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"login"];
}

+ (void)saveUserHeadImg:(NSString *)image
{
    [BSBSaveUserInfo setObj:image forKey:@"userHeadImg"];
}

+ (NSString *)getUserHeadImg
{
    return [BSBSaveUserInfo getObjWithKey:@"userHeadImg"];
}
@end
