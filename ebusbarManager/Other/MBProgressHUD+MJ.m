//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

@implementation MBProgressHUD (MJ)

#pragma mark 显示信息

+ (void)show:(NSString *)text
{
    [self show:text icon:nil view:nil];
}
+ (void)showMessage:(NSString *)text afterTime:(float)time
{
    [self show:text icon:nil view:nil aferTime:time];
}

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 视图上控件的活动事件不会被阻塞
    hud.userInteractionEnabled = NO;
    
    // 2秒之后再消失
    [hud hide:YES afterDelay:2.0];
}

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view aferTime:(float)time
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 视图上控件的活动事件不会被阻塞
    hud.userInteractionEnabled = NO;
    
    [hud hide:YES afterDelay:time];
}
#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    // 视图上控件的活动事件不会被阻塞
    hud.userInteractionEnabled = NO;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:[UIApplication sharedApplication].keyWindow];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:[UIApplication sharedApplication].keyWindow];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end