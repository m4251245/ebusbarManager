//
//  UIImage+Category.m
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/5.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

/**
 *
 *  @return 返回根据屏幕宽度的比例计算出来的图片
 */
- (UIImage*)fitScreenWidthWithImage{
    CGSize size = self.size;
    CGFloat scale = 1.0;
    //TODO:KScreenWidth屏幕宽
    scale = ScreenWidth/size.width;
    
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    CGSize secSize =CGSizeMake(scaledWidth, scaledHeight);
    //TODO:设置新图片的宽高
    UIGraphicsBeginImageContext(secSize); // this will crop
    [self drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage* newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *
 *  @param image 传过来的图片
 *
 *  @param height 传过来的高度
 *
 *  @return 返回根据高度的比例计算出来的图片
 */
- (UIImage *)fitScreenWidthWithImage:(UIImage *)image height:(CGFloat)height
{
    CGSize size = image.size;
    CGFloat scale = 1.0;
    scale = height/size.height;
    //    CGFloat width = size.width;
    //    CGFloat height = size.height;
    CGFloat scaledWidth = size.width * scale;
    CGFloat scaledHeight = size.height * scale;
    CGSize secSize = CGSizeMake(scaledWidth, scaledHeight);
    //TODO:设置新图片的宽高
    UIGraphicsBeginImageContext(secSize);
    [image drawInRect:CGRectMake(0, 0, scaledWidth, scaledHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *
 *  @return 返回适应屏幕宽度的size
 */
- (CGSize)sizeFitWidthWithImage{
    
    CGSize size = self.size;
    CGFloat scale = 1.0;
    //TODO:KScreenWidth屏幕宽
    scale = ScreenWidth/size.width;
    
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    CGSize secSize =CGSizeMake(scaledWidth, scaledHeight);
    return secSize;
}

/**
 *  @param image 传过来的图片
 *
 *  @return 返回适应高度的size
 */
//- (CGSize)sizeFitHeightWithImage:(UIImage *)image height:(CGFloat)height
//{
//    CGSize size = image.size;
//    CGFloat scale = 1.0;
//
//    scale = height/size.width;
//
////    CGFloat width = size.width;
////    CGFloat height = size.height;
//    CGFloat scaledWidth = size.width * scale;
//    CGFloat scaledHeight = size.height * scale;
//    CGSize secSize =CGSizeMake(scaledWidth, scaledHeight);
//    return secSize;
//}

- (CGFloat)sizeFitHeightWithImage:(UIImage *)image width:(CGFloat)width
{
    CGSize size = image.size;
    CGFloat scale = 1.0;
    //TODO:KScreenWidth屏幕宽
    scale = width/size.width;
    
    //    CGFloat width = size.width;
    //    CGFloat height = size.height;
    //    CGFloat scaledWidth = size.width * scale;
    CGFloat scaledHeight = size.height * scale;
    return scaledHeight;
}


+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
