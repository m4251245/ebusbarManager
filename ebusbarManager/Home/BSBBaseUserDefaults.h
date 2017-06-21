//
//  BSBBaseUserDefaults.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/4.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSBUserModel;

@interface BSBBaseUserDefaults : NSUserDefaults

//存取要注意类型
//存
+ (void)setObj:(id)value forKey:(NSString *)defaultName;


//取
+ (id)getObjWithKey:(NSString *)defaultName;

//登录成功保存信息保存
+ (void)loginSuccessSaveInfo:(BSBUserModel *)model;
//退出登录用户信息清空
+ (void)logoutSuccessEmptyInfo:(BSBUserModel *)model;
@end

//本地存储登录信息
@interface BSBSaveUserInfo : BSBBaseUserDefaults

//用户id
+ (void)saveUserId:(NSString *)userId;
+ (NSString *)getUserId;
//手机号
+ (void)saveMobile:(NSString *)mobile;
+ (NSString *)getMobile;
//用户密码
+ (void)saveUserPassWord:(NSString *)password;
+ (NSString *)getUserPassWord;
//用户名
+ (void)saveUserName:(NSString *)userName;
+ (NSString *)getUserName;
//唯一标识
+ (void)saveSessionKey:(NSString *)sessionKey;
+ (NSString *)getSessionKey;
//用户性别
+ (void)saveUserSex:(NSNumber *)sex;
+ (NSNumber *)getSex;
//是否登录
+ (void)saveLogin:(BOOL)login;
+ (BOOL)getLogin;
//用户头像
+ (void)saveUserHeadImg:(NSString *)image;
+ (NSString *)getUserHeadImg;
@end
