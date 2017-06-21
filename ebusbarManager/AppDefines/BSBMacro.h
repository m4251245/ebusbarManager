//
//  BSBMacro.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/3.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#ifndef BSBMacro_h
#define BSBMacro_h

#define Success @"success"
//-------------------宽高------------------
#define ScreenWidth               [UIScreen mainScreen].bounds.size.width
#define ScreenHeight              [UIScreen mainScreen].bounds.size.height
#define NavBarHeight                    64
#define ToolBarHeight                   49

#define Font(value)  [UIFont systemFontOfSize:value] 

//创建self对象的弱引用
#define WS(weakSelf) __weak __typeof(self)weakSelf = self;
//创建weakSelf对象的强引用
#define SS(strongSelf) __strong __typeof(weakSelf)strongSelf = weakSelf;


//--------------------输出----------------
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else
#define NSLog(FORMAT, ...) nil
#endif

//--------------------系统-----------------
#define IOS [[[UIDevice currentDevice]systemVersion] floatValue]

//--------------------设备-----------------
//模拟器or真机
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//不考虑放大模式
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6_plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//--------------------颜色-----------------
//rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//--------------------GCD-----------------
#define GCD_Global(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define GCD_Main(block) dispatch_async(dispatch_get_main_queue(),block)

//--------------------文件-----------------
#define FilePathInBundle(a) [[NSBundle mainBundle] pathForResource:[a stringByDeletingPathExtension] ofType:[a pathExtension]]

#define FilePathInDocDir(a) [[NSHomeDirectory() stringByAppendingString:@"/Documents"] stringByAppendingString:a]

#endif /* BSBMacro_h */
