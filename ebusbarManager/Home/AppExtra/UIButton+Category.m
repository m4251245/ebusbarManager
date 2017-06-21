//
//  UIButton+Category.m
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/5.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

//+ (UIButton *)creatBtnWithImage:(UIImage *)image tile:(NSString *)title titleColor:(UIColor *)color
//{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(200, 300, 100, 100);
//    btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [btn setImage:image forState:UIControlStateNormal];
//    image = [UIImage imageNamed:@"01"];
//    [btn setImage:image forState:UIControlStateNormal];
//    title = @"深圳前海巴斯巴网";
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 40, 10)];
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(60, 5, -5, 5)];
//    
//    return btn;
//}


+(UIButton *)getNewButtonWithImage:(NSString *)image Target:(id)target Action:(SEL)action
{
    return [self getNewButtonWithImage:image target:target action:action backGroundColor:nil];
}

+(UIButton *)getNewButtonWithImage:(NSString *)image target:(id)target action:(SEL)action backGroundColor:(UIColor *)color
{
    return [self getNewButtonWithImage:image target:target action:action backGroundColor:color text:nil font:nil textColor:nil];
}

+(UIButton *)getNewButtonWithImage:(NSString *)image target:(id)target action:(SEL)action backGroundColor:(UIColor *)color text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (color) {
        btn.backgroundColor = color;
    }
    if (text) {
        [btn setTitle:text forState:UIControlStateNormal];
    }
    if (font) {
        btn.titleLabel.font = font;
    }
    if (textColor) {
        [btn setTitleColor:textColor forState:UIControlStateNormal];
    }
    
    return btn;
}

@end
