//
//  UIButton+Category.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/5.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

+(UIButton *)getNewButtonWithImage:(NSString *)image Target:(id)target Action:(SEL)action;

+(UIButton *)getNewButtonWithImage:(NSString *)image target:(id)target action:(SEL)action backGroundColor:(UIColor *)color;

+(UIButton *)getNewButtonWithImage:(NSString *)image target:(id)target action:(SEL)action backGroundColor:(UIColor *)color text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;
@end
