//
//  BSBBaseViewController.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/3.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

//viewController 基类

#import <UIKit/UIKit.h>
#import "BSBInterfaces.h"

/**
 *  网络请求方式
 */
typedef NS_ENUM(NSInteger, requestMethod){
    /**
     *  get
     */
    GET,
    /**
     *  post
     */
    POST,
    /**
     *  头像上传
     */
    UPLOAD
};

@interface BSBBaseViewController : UIViewController

/*活动指示器*/
@property (nonatomic,strong) UIActivityIndicatorView *IndicatorView;
/*定时器*/
@property (nonatomic,strong) NSTimer *timer;
/*请求任务数组*/
@property (nonatomic,strong) NSMutableArray *dataTaskArray;
/*数据源*/
@property (nonatomic,strong) NSMutableArray *dataSouce;

@property (nonatomic,strong) UIAlertView *alertView;

#pragma mark ---------------- 网络请求
/**
 *  请求
 *
 *  @param method    get/post
 *  @param interface 接口
 *  @param params1   url参数
 *  @param params2   body参数
 */
- (void)sendRequestWithMethod:(requestMethod)method interface:(PLInterface)interface urlParams:(NSDictionary *)params1 bodyParams:(NSDictionary *)params2;
/**
 * @param selector  回调方法，传空=updateUIWithResponse:
 */
- (void)sendRequestWithMethod:(requestMethod)method interface:(PLInterface)interface urlParams:(NSDictionary *)params1 bodyParams:(NSDictionary *)params2 callbackMethod:(SEL)selector;


/**
 *  网络请求错误处理
 **/
//- (void)handleNetworkError:(NSError *)error;

- (void)handleNetWorkResponseError:(NSDictionary *)jsonDic;
/**
 *  网络请求成功
 */
//- (void)updateUIWithResponse:(NSDictionary *)jsonDic;
- (void)handleNetWorkResponseSuccess:(NSDictionary *)jsonDic;

//取消所有请求任务
- (void)cancleAllRequestTask;

#pragma mark ---------------- 弹框
/*******************弹框***********************/
/**
 *  自动消失的弹窗
 *
 *  @param title    标题
 *  @param msg      信息
 *  @param seconds  seconds
 *
 */
+(void)showAutoDisappearAlertView:(NSString *)title msg:(NSString *)msg seconds:(float)seconds;

+(void)dimissAlertView:(UIAlertView *)alertView;

+(void)showAlertView:(NSString *)title msg:(NSString *)msg btnTitle:(NSString *)btnTitle;

+(void)showAlertView:(NSString *)title msg:(NSString *)msg btnTitle:(NSString *)btnTitle delegate:(id)delegate tag:(NSInteger)tag;

+(void)showAlertView:(NSString *)title msg:(NSString *)msg btnTitle:(NSString *)btnTitle otherBtnTitle:(NSString *)otherTitle;

+(void)showAlertView:(NSString *)title msg:(NSString *)msg btnTitle:(NSString *)btnTitle otherBtnTitle:(NSString *)otherTitle delegate:(id)delegate tag:(NSInteger)tag;

//子类重写该方法即可
-(void)alertViewChoosed:(UIAlertView *)alertView index:(NSInteger)index type:(NSInteger)type;
@end
