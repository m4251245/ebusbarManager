//
//  BSBBaseViewController.m
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/3.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "BSBBaseViewController.h"

@interface BSBBaseViewController ()<UIGestureRecognizerDelegate,UIAlertViewDelegate>

@end

@implementation BSBBaseViewController

#pragma mark ---------- LifeCycle
- (void)dealloc
{
    NSLog(@"释放 - %@ %s",self,__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"进入页面 - %@",self);
    
    self.view.backgroundColor = [UIColor whiteColor];
    _dataTaskArray = [NSMutableArray arrayWithCapacity:1];
    _dataSouce = [NSMutableArray arrayWithCapacity:1];
    [self showsBackButton];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setExclusiveTouchForButtons:self.view];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    /*
     *在基类中将当前页面的网络请求、定时器等释放
     */
    
    [_timer invalidate];
    _timer = nil;
    
    [_IndicatorView stopAnimating];
    
    if (!self.navigationController || (!self.tabBarController && self.navigationController.viewControllers.count == 1) || (self.navigationController && ![self.navigationController.viewControllers containsObject:self])) {
        
    }
}


- (void)showsBackButton
{
    self.navigationItem.hidesBackButton = YES;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 5, 9, 15);
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popToPreviousVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)popToPreviousVC
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setExclusiveTouchForButtons:(UIView *)myView
{
    for (UIView * v in [myView subviews]) {
        if([v isKindOfClass:[UIButton class]])
            [((UIButton *)v) setExclusiveTouch:YES];
        else if ([v isKindOfClass:[UIView class]]){
            [self setExclusiveTouchForButtons:v];
        }
        
    }
    
}


#pragma mark ---------- NetWork Request
- (void)sendRequestWithMethod:(requestMethod)method interface:(PLInterface)interface urlParams:(NSDictionary *)params1 bodyParams:(NSDictionary *)params2
{
    [self sendRequestWithMethod:method interface:interface urlParams:params1 bodyParams:params2 callbackMethod:nil];
}

- (void)sendRequestWithMethod:(requestMethod)method interface:(PLInterface)interface urlParams:(NSDictionary *)params1 bodyParams:(NSDictionary *)params2 callbackMethod:(SEL)selector
{
    WS(weakSelf)
    NSString *interfaceName = fullInterfaceName(interface);
    //将url参数拼接到url中
    if (params1 && params1.count > 0) {
        interfaceName = [interfaceName stringByAppendingString:@"?"];
        for (NSString *key in params1.allKeys) {
            
            interfaceName = [NSString stringWithFormat:@"%@%@=%@&",interfaceName,key,[params1 objectForKey:key]];
            
        }
        //将最后一个&去掉
        interfaceName = [interfaceName substringToIndex:(interfaceName.length-1)];
        
//        if (params2 && params2.count > 0) {
//            interfaceName = [interfaceName encode];
//        }
    }
    
    NSLog(@"url --------- %@ \n",interfaceName);
    switch (method) {
        case GET:
        {
            [_dataTaskArray addObject:[BSBHttpTool get:interfaceName params:params2 result:^(NSDictionary *dic, NSError *error, NSURLSessionDataTask *task) {
                NSLog(@"Response ---- %@ \n  Error ---- %@ \n",dic,error);
                
                if (error) {
                    
                    NSDictionary *responseDic = @{@"error":error,
                                                  @"interface":@(interface),
                                                  @"task":task};
                    [weakSelf handleNetWorkResponseError:responseDic];
                }
                if (dic)
                {
//                    NSDictionary *dict = [NSDictionary handleNull:dic];
                    NSDictionary *responseDic = @{@"response":dic,
                                                  @"interface":@(interface),
                                                  @"task":task};
                    
                    [weakSelf handleNetWorkResponseSuccess:responseDic];
                    
                }
                
                [weakSelf removeTaskFromArray:task];
                
            }]];
        }
            break;
        case POST:
        {
            [_dataTaskArray addObject:[BSBHttpTool post:interfaceName params:params2 result:^(NSDictionary *dic, NSError *error, NSURLSessionDataTask *task) {
                NSLog(@"Response ---- %@ \n  Error ---- %@ \n",dic,error);
                if (error) {
                    NSDictionary *responseDic = @{@"error":error,
                                                  @"interface":@(interface),
                                                  @"task":task};
                    [weakSelf handleNetWorkResponseError:responseDic];
                    
                }
                if (dic)
                {
//                    NSDictionary *dict = [NSDictionary handleNull:dic];
                    NSDictionary *responseDic = @{@"response":dic,
                                                  @"interface":@(interface),
                                                  @"task":task};
                    
                    [weakSelf handleNetWorkResponseSuccess:responseDic];
                }
                
                [weakSelf removeTaskFromArray:task];
                
            }]];
        }
            break;
        case UPLOAD:
        {
            //图片以data的形式放在参数字典中，key是imageData
            NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:params2];
            NSData *data = mDic[@"imageData"];
            [mDic removeObjectForKey:@"imageData"];
            
            [_dataTaskArray addObject:[BSBHttpTool post:interfaceName params:mDic imageData:data result:^(NSDictionary *dic, NSError *error, NSURLSessionDataTask *task) {
                NSLog(@"Response ---- %@ \n  Error ---- %@ \n",dic,error);
                if (error) {
                    
                    NSDictionary *responseDic = @{@"error":error,
                                                  @"interface":@(interface),
                                                  @"task":task};
                    [weakSelf handleNetWorkResponseError:responseDic];
                }
                
                if (dic)
                {
//                    NSDictionary *dict = [NSDictionary handleNull:dic];
                    NSDictionary *responseDic = @{@"response":dic,
                                                  @"interface":@(interface),
                                                  @"task":task};
                    
                    [weakSelf handleNetWorkResponseSuccess:responseDic];
                }
                [weakSelf removeTaskFromArray:task];
                
            }]];
            
        }
            break;
        default:
            break;
    }
}


#pragma mark ---------- NetWork Response
- (void)handleNetWorkResponseSuccess:(NSDictionary *)jsonDic
{
    
    BSBBaseModel *model = [BSBBaseModel yy_modelWithDictionary:jsonDic[@"response"]];
    switch (model.code) {
        case 1001://用户退出登录、sessionkey过期
        case 1002:
        {
            //            [SVProgressHUD showInfoWithStatus:model.message];
            [MBProgressHUD showError:@"用户信息已过期"];
            [BSBSaveUserInfo saveLogin:NO];
            [BSBSaveUserInfo saveUserId:@""];
            //            [BSBSaveUserInfo saveMobile:@""];
            [BSBSaveUserInfo saveSessionKey:@""];
            [BSBSaveUserInfo saveUserName:@""];
            [BSBSaveUserInfo saveUserHeadImg:@""];
            //            [BSBSaveUserInfo saveUserPassWord:@""];
            //
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kloginOperation" object:nil];
            
            BSBBaseViewController *ctl = [[NSClassFromString(@"BSBLoginViewController") alloc] init];
            [self.navigationController pushViewController:ctl animated:YES];
        }
            break;
            
        case 1006://登陆手机号码不存在（手机号未注册）
        {
            [MBProgressHUD showError:model.message];
            //            [SVProgressHUD showInfoWithStatus:model.message];
        }
            break;
        case 1007://登录密码错误
        {
            [MBProgressHUD showError:model.message];
            //            [SVProgressHUD showInfoWithStatus:model.message];
        }
            break;
        default:
            break;
    }
}

- (void)handleNetWorkResponseError:(NSDictionary *)jsonDic
{
    
}

//请求完成之后将任务从数组中移除
- (void)removeTaskFromArray:(NSURLSessionDataTask *)task
{
    [_dataTaskArray removeObject:task];
}

- (void)cancleAllRequestTask
{
    for (NSURLSessionDownloadTask *task in _dataTaskArray) {
        if (task && task.state != NSURLSessionTaskStateCompleted) {
            [task cancel];
        }
    }
}

#pragma mark ---------- 弹框
//让提示框自动消失
+(void)showAutoDisappearAlertView:(NSString *)title msg:(NSString *)msg seconds:(float)seconds
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil
                                          cancelButtonTitle:nil otherButtonTitles:nil];
    
    [alert show];
    [self performSelector:@selector(dimissAlertView:) withObject:alert afterDelay:seconds];
}

//提示框消失
+(void)dimissAlertView:(UIAlertView *)alertView
{
    if(alertView)
    {
        [alertView dismissWithClickedButtonIndex:[alertView cancelButtonIndex] animated:YES];
    }
}

//show alert view(just one btn)
+(void)showAlertView:(NSString *)title msg:(NSString *)msg btnTitle:(NSString *)btnTitle
{
    [self showAlertView:title msg:msg btnTitle:btnTitle delegate:nil tag:0];
}

//show alert view(just one btn)
+(void) showAlertView:(NSString *)title msg:(NSString *)msg btnTitle:(NSString *)btnTitle delegate:(id)delegate tag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg    delegate:delegate
                                          cancelButtonTitle:btnTitle
                                          otherButtonTitles:nil];
    
    //避免冲突
    alert.tag = tag;
    [alert show];
}

+(void)showAlertView:(NSString *)title msg:(NSString *)msg btnTitle:(NSString *)btnTitle otherBtnTitle:(NSString *)otherTitle
{
    [self showAlertView:title msg:msg btnTitle:btnTitle otherBtnTitle:title delegate:nil tag:0];
    
}

+(void)showAlertView:(NSString *)title msg:(NSString *)msg btnTitle:(NSString *)btnTitle otherBtnTitle:(NSString *)otherTitle delegate:(id)delegate tag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:btnTitle otherButtonTitles:otherTitle, nil];
    alert.tag = tag;
    [alert show];
}

#pragma mark alertView delegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self alertViewChoosed:alertView index:buttonIndex type:alertView.tag];
}

-(void)alertViewChoosed:(UIAlertView *)alertView index:(NSInteger)index type:(NSInteger)type
{
    
}

/*
-(void)showAlertController:(NSString *)title msg:(NSString *)msg btnTitle:(NSString *)btnTitle otherBtnTitle:(NSString *)otherTitle
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    WS(weakSelf)
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf cancleAlertController:alertController];
    }];

    [alertController addAction:cancle];
    
    
    if (otherTitle && otherTitle.length > 0) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf chooseAlertController:alertController];
        }];
        
        [alertController addAction:action];
    }
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)chooseAlertController:(UIAlertController *)alertController
{

}

- (void)cancleAlertController:(UIAlertController *)alertController
{
    
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
