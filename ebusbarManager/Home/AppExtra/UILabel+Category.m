//
//  UILabel+Category.m
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/5.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

//+ (nullable UILabel *)getLabelWithFont:(UIFont *_Nullable)font title:(NSString *_Nullable)title textColor:(UIColor *_Nullable)textColor frame:(CGRect)frame
//{
//    return [self getLabelWithFont:font title:title textColor:textColor frame:frame lines:1 alignment:NSTextAlignmentLeft];
//}
//
//+ (nullable UILabel *)getLabelWithFont:(UIFont *_Nullable)font title:(NSString *_Nullable)title textColor:(UIColor *_Nullable)textColor frame:(CGRect)frame lines:(NSInteger)lines alignment:(NSTextAlignment)alignment
//{
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = frame;
//    if (font) {
//        label.font = font;
//    }
//    if (title && ![title isEqualToString:@""]) {
//        label.text = title;
//    }
//    if (textColor) {
//        label.textColor = textColor;
//    }
//    if (lines) {
//        label.numberOfLines = lines;
//    }
//    if (alignment) {
//        label.textAlignment = alignment;
//    }
//    return label;
//}

+ (UILabel *)getNewLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font
{
    return [self getNewLabelWithText:text textColor:textColor font:font alignment:NSTextAlignmentLeft];
}

+ (UILabel *)getNewLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font alignment:(NSTextAlignment)alignment
{
    return [self getNewLabelWithText:text textColor:textColor font:font alignment:alignment lines:1];
}

+ (UILabel *)getNewLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font alignment:(NSTextAlignment)alignment lines:(NSInteger)lines
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    if (alignment != 0) {
        label.textAlignment = alignment;
    }
    if (lines != 1) {
        label.numberOfLines = lines;
    }
    return label;
}
@end
