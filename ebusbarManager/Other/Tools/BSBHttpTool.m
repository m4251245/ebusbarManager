//
//  BSBHttpTool.m
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/3.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "BSBHttpTool.h"
#import "AFNetworking.h"

@implementation BSBHttpTool

+ (NSURLSessionDataTask *)get:(NSString *)url params:(NSDictionary *)params result:(void (^)(NSDictionary *dic,NSError *error,NSURLSessionDataTask *task))result
{
    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    NSLog(@"url-%@ params-%@",url,params);
    // 2.发送请求
    return [mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            result(responseObject,nil,task);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        result(nil,error,task);
    }];
    
}

+ (NSURLSessionDataTask *)post:(NSString *)url params:(NSDictionary *)params result:(void (^)(NSDictionary *dic,NSError *error,NSURLSessionDataTask *task))result
{
    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    // 2.发送请求
    return [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            result(responseObject,nil,task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil,error,task);
    }];
    
}
//上传单张图片
+ (NSURLSessionDataTask *)post:(NSString *)url params:(NSDictionary *)params imageData:(NSData *)data result:(void (^)(NSDictionary *dic,NSError *error,NSURLSessionDataTask *task))result
{
    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    return [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"file.png" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            result(responseObject,nil,task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        result(nil,error,task);
    }];
    
}

//上传多张图片 并按上传顺序返回 多线程操作
+ (void)upload:(NSString *)url params:(NSDictionary *)params images:(NSArray *)images result:(void (^)(NSDictionary *dic,NSError *error))result
{
    //准备保存结果的数组，元素个数与上传的图片个数相同，先用 NSNull 占位
    NSMutableArray *reslutArr = [NSMutableArray array];
    for (UIImage *image in images) {
        NSLog(@"-- %@",image);
        [reslutArr addObject:[NSNull null]];
    }
    
    dispatch_group_t group = dispatch_group_create();
    
    for (NSInteger i = 0; i < images.count; i++) {
        
        dispatch_group_enter(group);
        
        NSData* imageData = UIImageJPEGRepresentation(images[1], 1.0);
        
        NSURLSessionUploadTask *uploadTask = [self uploadTaskWithImage:imageData completion:^(NSURLResponse *response, id responseObject, NSError *error) {
            
            if (error) {
                NSLog(@"第 %d 张图片上传失败: %@", (int)i + 1, error);
                dispatch_group_leave(group);
            } else {
                NSLog(@"第 %d 张图片上传成功: %@", (int)i + 1, responseObject);
                @synchronized (reslutArr) { // NSMutableArray 是线程不安全的，所以加个同步锁
                    reslutArr[i] = responseObject;
                }
                dispatch_group_leave(group);
            }

        }];
        
        [uploadTask resume];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"上传完成!");
        for (id response in reslutArr) {
            NSLog(@"%@", response);
        }
    });

}

+ (NSURLSessionUploadTask *)uploadTaskWithImage:(NSData *)image completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock {
    // 构造 NSURLRequest
    NSError* error = NULL;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:image name:@"file" fileName:@"someFileName" mimeType:@"multipart/form-data"];
    } error:&error];
    
    // 可在此处配置验证信息
    
    // 将 NSURLRequest 与 completionBlock 包装为 NSURLSessionUploadTask
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
    } completionHandler:completionBlock];
    
    return uploadTask;
}

@end
