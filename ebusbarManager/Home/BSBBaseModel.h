//
//  BSBBaseModel.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/4.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//
//model 基类 

#import <Foundation/Foundation.h>

@interface BSBBaseModel : NSObject

@property (nonatomic,assign) NSInteger code;

@property (nonatomic,strong) NSNumber *current_page_index;

@property (nonatomic,strong) NSNumber *total_page;

@property (nonatomic,strong) NSString *message;

@property (nonatomic,strong) NSString *sessionKey;

@end
