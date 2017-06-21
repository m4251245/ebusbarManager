//
//  BSBHttpTool.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/3.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSBHttpTool : NSObject

/**
 *  http get方法封装
 *
 *  @param url     要请求的url
 *  @param params  参数
 *  @param result 请求的block
 */
+ (NSURLSessionDataTask *)get:(NSString *)url params:(NSDictionary *)params result:(void (^)(NSDictionary *dic,NSError *error,NSURLSessionDataTask *task))result;
/**
 *  http post方法封装
 *
 *  @param url     要请求的url
 *  @param params  参数
 *  @param result 请求的block

 */
+ (NSURLSessionDataTask *)post:(NSString *)url params:(NSDictionary *)params result:(void (^)(NSDictionary *dic,NSError *error,NSURLSessionDataTask *task))result;
/**
 *  http post方法封装  上传单张图片
 *
 *  @param url     要请求的url
 *  @param params  参数
 *  @param data    图片数据
 *  @param result  请求的block
 */
+ (NSURLSessionDataTask *)post:(NSString *)url params:(NSDictionary *)params imageData:(NSData *)data result:(void (^)(NSDictionary *dic,NSError *error,NSURLSessionDataTask *task))result;

/**
 *  http post方法封装  上传多张图片并按上传顺序返回 使用时直接调用（没有放在控制器基类中）
 *
 *  @param url     要请求的url
 *  @param params  参数
 *  @param images  图片数组
 *  @param result 请求的block
 */
+ (void)upload:(NSString *)url params:(NSDictionary *)params images:(NSArray *)images result:(void (^)(NSDictionary *dic,NSError *error))result;

@end
