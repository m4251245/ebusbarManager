//
//  BSBScanQRViewController.h
//  ebusbarManager
//
//  Created by 刘必红 on 2017/5/25.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "BSBBaseViewController.h"

@interface BSBScanQRViewController : BSBBaseViewController

@property (nonatomic, assign) NSInteger type;//类型  1 租车  2 还车

@property (nonatomic,copy)NSString *place_id;
@end
