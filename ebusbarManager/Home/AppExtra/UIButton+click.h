//
//  UIButton+click.h
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/23.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (click)

/**
 *  为按钮添加点击间隔 eventTimeInterval秒
 */
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;

@end
