//
//  UIImageView+Category.m
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/8.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "UIImageView+Category.h"

@implementation UIImageView (Category)

+ (UIImageView *)getNewImageViewWithImage:(NSString *)image
{
    return [self getNewImageViewWithImage:image cornerRadius:0];
}

+ (UIImageView *)getNewImageViewWithImage:(NSString *)image cornerRadius:(CGFloat)cornerRadius
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:image];
    if (cornerRadius > 0) {
      imageView.layer.cornerRadius = cornerRadius;
      imageView.layer.masksToBounds = YES;
    }
    
    return imageView;
}
@end
