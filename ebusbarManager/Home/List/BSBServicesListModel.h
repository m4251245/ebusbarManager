//
//  BSBServicesListModel.h
//  ebusbarManager
//
//  Created by 刘必红 on 2017/5/24.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "BSBBaseModel.h"

@interface BSBServicesListModel : BSBBaseModel

@property (nonatomic ,copy) NSString *address;

@property (nonatomic ,copy) NSString *created_at;

@property (nonatomic ,copy) NSString *extendone;

@property (nonatomic ,copy) NSString *extendtwo;

@property (nonatomic ,copy) NSString *lat;

@property (nonatomic ,copy) NSString *lng;

@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,copy) NSString *status;

@property (nonatomic ,copy) NSString *t_company_id;

@property (nonatomic ,copy) NSString *t_rent_place_id;//租车点id

@end
