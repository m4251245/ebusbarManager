//
//  NSString+Category.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/3.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

/**************************正则校验*************************/

/*手机号校验*/
- (BOOL)isMobileNumValid;

/***************************加密***************************/

/*MD5加密*/
- (NSString *)md5;
- (NSString *)encode;

/*************************字符串处理************************/

-(BOOL)isNull;

- (NSString *)changeNullOrNilToNumber;

- (NSString *)changeNullOrNilToString;

/************************转换成日期*************************/
-(NSDate *)dateFormStringFormat:(NSString *)format;
//返回带上午、下午格式的时间
+ (NSString *)timeBucket;
/**
  * 按格式返回时间
  * @param format 时间格式
  * @param date   距离当前时间的时间间隔（单位毫秒）
  */
+ (NSString *)dateStringWithFormat:(NSString *)format date:(NSTimeInterval)date;
/**********************计算文字区域*************************/
-(CGSize)sizeNewWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
-(CGSize)sizeNewWithFont:(UIFont *)font;
@end
