//
//  UIView+Category.m
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/8.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

+ (UIView *)getNewViewWithBackColor:(UIColor *)color
{
    UIView *view = [[UIView alloc] init];
    if (color) {
        view.backgroundColor = color;
    }
    return view;
}


@end
