//
//  BSBScanListViewController.m
//  ebusbarManager
//
//  Created by 刘必红 on 2017/5/25.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "BSBScanListViewController.h"
#import "BSBScanQRViewController.h"

@interface BSBScanListViewController ()

@end

@implementation BSBScanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"巴斯巴管理";
    
    [self configUI];
}

- (void)configUI
{
    UILabel *label = [UILabel getNewLabelWithText:self.companyName textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] alignment:NSTextAlignmentCenter];
    label.backgroundColor = UIColorFromRGB(0x008742);
    [self.view addSubview:label];
    
    WS(weakSelf)
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *rentalBtn = [UIButton getNewButtonWithImage:nil target:self action:@selector(btnResponse:) backGroundColor:[UIColor grayColor] text:@"租车确认" font:[UIFont systemFontOfSize:20] textColor:nil];
    rentalBtn.tag = 100;
    [self.view addSubview:rentalBtn];
    
    [rentalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(30);
        make.right.equalTo(weakSelf.view).with.offset(-30);
        make.top.equalTo(label.mas_bottom).with.offset(20);
        make.height.mas_equalTo(80);
    }];
    
    
    UIButton *giveBtn = [UIButton getNewButtonWithImage:nil target:self action:@selector(btnResponse:) backGroundColor:[UIColor grayColor] text:@"还车确认" font:[UIFont systemFontOfSize:20] textColor:nil];
    giveBtn.tag = 101;
    [self.view addSubview:giveBtn];
    
    [giveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(30);
        make.right.equalTo(weakSelf.view).with.offset(-30);
        make.top.equalTo(rentalBtn.mas_bottom).with.offset(30);
        make.height.mas_equalTo(80);
    }];

}

- (void)btnResponse:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    
    BSBScanQRViewController *ctl = [[BSBScanQRViewController alloc] init];
    if (tag == 100) {
        ctl.type = 1;
    }else{
        ctl.type = 2;
    }
    ctl.place_id = self.place_id;
    [self.navigationController pushViewController:ctl animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
