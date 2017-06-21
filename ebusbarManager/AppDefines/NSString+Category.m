//
//  NSString+Category.m
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/3.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Category)

#pragma mark -----  正则校验
//手机号码判断
- (BOOL)isMobileNumValid
{
    NSString * PHS = @"1[3|4|5|7|8|9][0-9]{9}";
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    BOOL result = [regextestct evaluateWithObject:self];
    return result;
}

//判断是否为正确的邮箱格式
- (BOOL)isValidateEmail
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:self];
    
}

#pragma mark ----- 加密
- (NSString *)md5
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
}

- (NSString *)encode
{
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)self,NULL,(CFStringRef)@" ",
                                                                                                     //The characters you want to replace go here
                                                                                                     kCFStringEncodingUTF8 ));
    
    return encodedString;
}


#pragma mark ----- 字符串处理
/**
 *  空字符串处理
 */
-(BOOL)isNull
{
    // 判断是否为空串
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    else if (self == nil){
        return YES;
    }
    else if ([self isEqualToString:@""]){
        return YES;
    }
    return NO;
}

- (NSString *)changeNullOrNilToNumber
{
    if ([self isEqual:[NSNull null]] || self == nil) {
        return @"0";
    }else{
        return self;
    }
}

- (NSString *)changeNullOrNilToString
{
    if ([self isEqual:[NSNull null]] || self == nil) {
        return @"";
    }
    return self;
}

#pragma mark ------- 日期转换
-(NSDate *)dateFormStringFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //一定要设置 否则非内地版本（如：港版）时间有问题
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_cn"]];
    [formatter setDateFormat:format];
    return [formatter dateFromString:self];
}

+ (NSString *)timeBucket
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_cn"]];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    formatter.AMSymbol=@"上午";
    formatter.PMSymbol = @"下午";
    [formatter setDateFormat:@"YYYY-MM-dd aaa"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *nowtimeStr = [formatter stringFromDate:datenow];
    return nowtimeStr;
}

+ (NSString *)dateStringWithFormat:(NSString *)format date:(NSTimeInterval)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_cn"]];
    [formatter setDateFormat:format];
    
    NSDate *reslut_date = [NSDate dateWithTimeIntervalSinceNow:date];
    
    return [formatter stringFromDate:reslut_date];
    
}

#pragma mark ---------- 文字区域
-(CGSize)sizeNewWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    //    CGSize rect = [self sizeWithFont:font constrainedToSize:size];
    return rect.size;
}

-(CGSize)sizeNewWithFont:(UIFont *)font{
    CGSize textSize = [self sizeWithAttributes:@{ NSFontAttributeName :font}];
    return textSize;
}



@end
