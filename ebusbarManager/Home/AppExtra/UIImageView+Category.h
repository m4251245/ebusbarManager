//
//  UIImageView+Category.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/8.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Category)

+ (UIImageView *)getNewImageViewWithImage:(NSString *)image;

+ (UIImageView *)getNewImageViewWithImage:(NSString *)image cornerRadius:(CGFloat)cornerRadius;
@end
