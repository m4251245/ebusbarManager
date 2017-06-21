//
//  UILabel+Category.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/5.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

//+ (nullable UILabel *)getLabelWithFont:(UIFont *_Nullable)font title:(NSString *_Nullable)title textColor:(UIColor *_Nullable)textColor frame:(CGRect)frame;
//
//+ (nullable UILabel *)getLabelWithFont:(UIFont *_Nullable)font title:(NSString *_Nullable)title textColor:(UIColor *_Nullable)textColor frame:(CGRect)frame lines:(NSInteger)lines alignment:(NSTextAlignment)alignment;

+ (UILabel *)getNewLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;

+ (UILabel *)getNewLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font alignment:(NSTextAlignment)alignment;

+ (UILabel *)getNewLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font alignment:(NSTextAlignment)alignment lines:(NSInteger)lines;

@end
