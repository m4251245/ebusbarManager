//
//  UIImage+Category.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/5.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

//把图片根据屏幕宽度拉伸、缩放得到新的图片
- (UIImage *)fitScreenWidthWithImage;
//把图片根据屏幕宽高拉伸、缩放得到新的宽高
- (UIImage *)fitScreenWidthWithImage:(UIImage *)image height:(CGFloat)height;

- (CGSize)sizeFitWidthWithImage;

//- (CGSize)sizeFitHeightWithImage:(UIImage *)image height:(CGFloat)height;
/**
 * @param image 传进来的图片
 * @param width 传进来的宽度
 * result 根据宽度得到得到与图片成正比的高
 */
- (CGFloat)sizeFitHeightWithImage:(UIImage *)image width:(CGFloat)width;
//颜色生成一张图片
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
