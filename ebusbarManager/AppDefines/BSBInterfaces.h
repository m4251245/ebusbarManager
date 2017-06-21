//
//  BSBInterfaces.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/3.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#ifndef BSBInterfaces_h
#define BSBInterfaces_h


//#define testUrl 1
//#define BaseUrl  testUrl ? @"http://www.gzygy.net/api/" : @"http://test.gzygy.net/api/"
//拼接一个url
//#define API(name) [BaseUrl stringByAppendingString:(name)]
//本地版本号 可以跟服务器版本号对比 用作更新提示
#define version @"1.0.080"

static NSInteger count = 59;
//全局时间戳(用于换车按钮)
static int timeDate;
//是否显示换车按钮
static BOOL isHaveReplace;
//接口列表
typedef NS_ENUM(NSInteger, PLInterface)
{
    /********用户类接口********/
    PLInterface_Login,        //登陆
    PLInterface_GetAdminPlace, //获取租车点
    PLInterface_ConfirmOrder,   //扫码确认租车订单
    PLInterface_ReturnConfirmOrder,  //扫码确认还车订单
    PLInterface_Logout,   //退出登录
    PLInterface_getLastVersion,   //最新版本
    
    
    
};

static inline NSString *API(NSString *interfaceName)
{
    NSString * baseUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"serverAddress"] ;
    if (!baseUrl || baseUrl.length <= 0) {
        baseUrl = @"http://test.gzygy.net/api/";
    }
    return [baseUrl stringByAppendingString:interfaceName];
}

static inline NSString *fullInterfaceName(PLInterface interface)
{
    switch (interface) {
        case PLInterface_Login:
            return API(@"AppUser/adminLogin");
            break;
        case PLInterface_GetAdminPlace:
            return API(@"RentPalce/getAdminPlace");
            break;
        case PLInterface_ConfirmOrder:
            return API(@"RentCar/confirmRequestForAdmin");
            break;
        case PLInterface_ReturnConfirmOrder:
            return API(@"RentCar/returnConfirmForAdmin");
            break;
         case PLInterface_Logout:
            return API(@"AppUser/logout");
            break;
        case PLInterface_getLastVersion:
            return API(@"AppVersion/getLastVersion");
            break;
        default:
            break;
    }
}

#endif /* BSBInterfaces_h */
