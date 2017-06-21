//
//  BSBUserModel.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/8.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "BSBBaseModel.h"

@interface BSBUserModel : BSBBaseModel

@property (nonatomic , copy) NSString *created_at;//创建时间

@property (nonatomic , copy) NSString *extendone;

@property (nonatomic , copy) NSString *extendtwo;

@property (nonatomic , copy) NSString *psw;//密码

@property (nonatomic , copy) NSString *status;//状态

@property (nonatomic , copy) NSString *t_com_admin_id;//管理员id

@property (nonatomic , copy) NSString *t_company_id;//公司id

@property (nonatomic , copy) NSString *t_dept_id;//

@property (nonatomic , strong) NSArray *t_userpost;//

@property (nonatomic , copy) NSString *true_name;//

@property (nonatomic , copy) NSString *username;//

@end
