//
//  BSBLoginViewController.m
//  Ebusbar
//
//  Created by 刘必红 on 2017/5/8.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "BSBLoginViewController.h"
#import "BSBUserModel.h"


@interface BSBLoginViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (nonatomic , strong) UITextField *fieldName;
@property (nonatomic , strong) UITextField *fieldPwd;

@property (nonatomic , assign) BOOL isRemember;

@end

@implementation BSBLoginViewController
#pragma mark ---------- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configUI];
    
    self.isRemember = YES;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)configUI
{
    UIImageView *logoImg = [UIImageView getNewImageViewWithImage:@"logo"];
    [self.view addSubview:logoImg];
    
    WS(weakSelf)
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        if (ScreenHeight == 480 || iPad) {
            make.top.equalTo(weakSelf.view).with.offset(60);
        }else{
            make.top.equalTo(weakSelf.view).with.offset(90);
        }
        make.width.mas_equalTo(123);
        make.height.mas_equalTo(123);
    }];
    
    UILabel *label = [UILabel getNewLabelWithText:@"巴 巴 服 务 管 理" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12.0] alignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.equalTo(logoImg.mas_bottom).with.offset(30);
    }];
    
    //线1
    UIImageView *phoneLine=[[UIImageView alloc] init];
    phoneLine.backgroundColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    [self.view addSubview:phoneLine];
    
    //线1居中
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        if (ScreenHeight == 480 || iPad) {
            make.top.equalTo(label.mas_bottom).with.offset(50);
        }else{
            make.top.equalTo(label.mas_bottom).with.offset(85);
        }

        make.width.equalTo(@230);
        make.height.equalTo(@1);
    }];
    
    //线2
    UIImageView *passwordLine=[[UIImageView alloc]init];
    passwordLine.backgroundColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    [self.view addSubview:passwordLine];
    
    //线2居中
    [passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        if (ScreenHeight == 480 || iPad) {
            make.top.equalTo(phoneLine.mas_bottom).with.offset(45);
        }else{
            make.top.equalTo(phoneLine.mas_bottom).with.offset(55);
        }
        make.width.equalTo(@230);
        make.height.equalTo(@1);
    }];
    
    //用户名图片
    UIImageView *useImg = [UIImageView getNewImageViewWithImage:@"USER"];
    [self.view addSubview:useImg];
    
    [useImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLine.mas_left).with.offset(16);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.bottom.equalTo(phoneLine.mas_top).with.offset(-10);
    }];
                               
    
    self.fieldName=[[UITextField alloc]init];
    self.fieldName.contentVerticalAlignment=0;
    NSString *holderText=@"请输入手机号";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:12.0]
                        range:NSMakeRange(0, holderText.length)];
    self.fieldName.attributedPlaceholder = placeholder;
    self.fieldName.clearsOnBeginEditing = YES;
    self.fieldName.backgroundColor=[UIColor clearColor];
    self.fieldName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.fieldName.contentVerticalAlignment=0;
    self.fieldName.delegate=self;
    //通过offset的设置可以设置某个输入框特殊偏移量。
    self.fieldName.kbMoving.offset = 80;
    
    //你也可以通过设置一个具体的移动的视图而不是默认的父视图
    self.fieldName.kbMoving.kbMovingView = self.view;
    [self.view addSubview:self.fieldName];
    
    [self.fieldName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(useImg.mas_right).with.offset(7);
        make.width.equalTo(@160);
        make.height.equalTo(@30);
        make.bottom.equalTo(phoneLine.mas_top).with.offset(-5);
    }];
    
    //密码图片
    UIImageView *pwdImg=[UIImageView getNewImageViewWithImage:@"LOCK"];
    [self.view addSubview:pwdImg];
    
    [pwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordLine.mas_left).with.offset(16);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.bottom.equalTo(passwordLine.mas_top).with.offset(-10);
    }];
    
    self.fieldPwd=[[UITextField alloc]init];
    self.fieldPwd.contentVerticalAlignment=0;
    NSString *holderText1=@"请输入密码";
    NSMutableAttributedString *placeholder1 = [[NSMutableAttributedString alloc]initWithString:holderText1];
    [placeholder1 addAttribute:NSFontAttributeName
                         value:[UIFont boldSystemFontOfSize:12.0]
                         range:NSMakeRange(0, holderText1.length)];
    self.fieldPwd.attributedPlaceholder = placeholder1;
    self.fieldPwd.borderStyle=UITextBorderStyleNone;
    self.fieldPwd.clearsOnBeginEditing = YES;
    self.fieldPwd.backgroundColor=[UIColor clearColor];
    self.fieldPwd.secureTextEntry=YES;
    self.fieldPwd.delegate=self;
    self.fieldPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    //通过offset的设置可以设置某个输入框特殊偏移量。
    self.fieldPwd.kbMoving.offset = 80;
    
    //你也可以通过设置一个具体的移动的视图而不是默认的父视图
    self.fieldPwd.kbMoving.kbMovingView = self.view;
    [self.view addSubview:self.fieldPwd];

    [self.fieldPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdImg.mas_right).with.offset(7);
        make.width.equalTo(@160);
        make.height.equalTo(@30);
        make.bottom.equalTo(passwordLine.mas_top).with.offset(-5);
    }];
    
    
    UIButton *rememberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rememberBtn.selected = YES;
    [rememberBtn setImage:[UIImage imageNamed:@"icon_unselected"] forState:UIControlStateNormal];
    [rememberBtn setImage:[UIImage imageNamed:@"icon_selected"] forState:UIControlStateSelected];
    [rememberBtn addTarget:self action:@selector(btnResponse:) forControlEvents:UIControlEventTouchUpInside];
    rememberBtn.tag = 102;
    [self.view addSubview:rememberBtn];
    
    [rememberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordLine);
        make.top.equalTo(passwordLine.mas_bottom).with.offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *rememberLab = [UILabel getNewLabelWithText:@"忘记密码 ？" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12]];
    [self.view addSubview:rememberLab];
    
    [rememberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rememberBtn.mas_right).with.offset(5);
        make.top.equalTo(rememberBtn);
        make.height.mas_equalTo(rememberBtn);
        make.width.equalTo(weakSelf.view).with.offset(10);
    }];

    
    //登陆按钮
    UIButton *loginBtn = [UIButton getNewButtonWithImage:nil target:self action:@selector(btnResponse:) backGroundColor:[UIColor colorWithRed:1/255.0 green:140/255.0 blue:65/255.0 alpha:1] text:@"登  录" font:[UIFont systemFontOfSize:12.0] textColor:[UIColor whiteColor]];
    loginBtn.tag = 100;
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    
    //登陆按钮
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(rememberLab.mas_bottom).with.offset(30);
        make.width.equalTo(@230);
        make.height.equalTo(@36);
    }];
    
    UIButton *backBtn = [UIButton getNewButtonWithImage:nil target:self action:@selector(btnResponse:) backGroundColor:nil text:@"测试环境" font:[UIFont systemFontOfSize:14] textColor:RGBA(1, 140, 65, 1)];
    backBtn.tag = 103;
    [self.view addSubview:backBtn];
    
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).with.offset(15);
        make.left.equalTo(loginBtn.mas_left).with.offset(0);
        make.width.mas_equalTo(@70);
        make.height.mas_equalTo(@25);
    }];
    
    //注册按钮
    UIButton *registerBtn=[[UIButton alloc]init];
    registerBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [registerBtn setTitle:@"测试环境" forState:UIControlStateNormal];
    registerBtn.tag = 1001;
    [registerBtn addTarget:self action:@selector(btnResponse:) forControlEvents:UIControlEventTouchUpInside];
//    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"还没注册用户？点击注册"];
//    registerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
//    //设置下划线...
//    /*
//     NSUnderlineStyleNone                                    = 0x00, 无下划线
//     NSUnderlineStyleSingle                                  = 0x01, 单行下划线
//     NSUnderlineStyleThick NS_ENUM_AVAILABLE(10_0, 7_0)      = 0x02, 粗的下划线
//     NSUnderlineStyleDouble NS_ENUM_AVAILABLE(10_0, 7_0)     = 0x09, 双下划线
//     */
//    [tncString addAttribute:NSUnderlineStyleAttributeName
//                      value:@(NSUnderlineStyleSingle)
//                      range:(NSRange){0,[tncString length]}];
//    //此时如果设置字体颜色要这样
//    [tncString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1/255.0 green:140/255.0 blue:65/255.0 alpha:1]  range:NSMakeRange(0,[tncString length])];
//    //设置下划线颜色...
//    [tncString addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithRed:1/255.0 green:140/255.0 blue:65/255.0 alpha:1] range:(NSRange){0,[tncString length]}];
//    [registerBtn setAttributedTitle:tncString forState:UIControlStateNormal];
//    //点击注册按钮
//    [registerBtn addTarget:self action:@selector(btnResponse:) forControlEvents:UIControlEventTouchUpInside];
//    registerBtn.tag = 101;
    [self.view addSubview:registerBtn];
    

    //注册按钮
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).with.offset(15);
        make.right.equalTo(loginBtn.mas_right).with.offset(0);
        make.width.mas_equalTo(@140);
        make.height.mas_equalTo(@20);
    }];
    
    //添加手势单击事件 隐藏键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureResponse:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    
    if ([BSBSaveUserInfo getMobile] && [BSBSaveUserInfo getMobile].length > 0) {
        self.fieldName.text = [BSBSaveUserInfo getMobile];
    }
    if ([BSBSaveUserInfo getUserPassWord] && [BSBSaveUserInfo getUserPassWord].length > 0) {
        self.fieldPwd.text = [BSBSaveUserInfo getUserPassWord];
    }
}


- (void)gestureResponse:(UITapGestureRecognizer *)gesture
{
    [self.fieldName resignFirstResponder];
    [self.fieldPwd resignFirstResponder];
}


#pragma mark  ---------- NetWork
- (void)btnResponse:(UIButton *)btn
{
    switch (btn.tag) {
        case 100:
        {
//            [MBProgressHUD showMessage:@"登录中..."];
            NSDictionary *bodyParams = @{@"phone":self.fieldName.text,
                                       @"hashedPassword":self.fieldPwd.text,
//                                       @"deviceToken":@"22",
                                       @"deviceType":@"1",
                                         @"sessionKey":@""
                                         };

            [self sendRequestWithMethod:GET interface:PLInterface_Login urlParams:bodyParams bodyParams:nil];
            
        }
            break;
        case 101:
        {
            BSBBaseViewController *registerCtl = [[NSClassFromString(@"BSBRegisterViewController") alloc] init];
            [self.navigationController pushViewController:registerCtl animated:YES];
        }
            break;
        case 102:
        {
            btn.selected = !btn.selected;
            self.isRemember = btn.selected;
        }
            break;
        case 103:
        {

            btn.selected = !btn.selected;
            if (!btn.selected) {
                [[NSUserDefaults standardUserDefaults] setObject:@"http://test.gzygy.net/api/" forKey:@"serverAddress"];
                [btn setTitle:@"测试环境" forState:UIControlStateNormal];
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:@"http://www.gzygy.net/api/" forKey:@"serverAddress"];
                [btn setTitle:@"正式环境" forState:UIControlStateNormal];
            }
//             [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
        case 1001:
        {
            
        }
        default:
            break;
    }
}

- (void)handleNetWorkResponseSuccess:(NSDictionary *)jsonDic
{
    [super handleNetWorkResponseSuccess:jsonDic];
    [MBProgressHUD hideHUD];
    
    NSInteger interface = [jsonDic[@"interface"] integerValue];
    NSDictionary *responseDic = jsonDic[@"response"];
    BSBBaseModel *baseModel = [BSBBaseModel yy_modelWithDictionary:responseDic];
    
    switch (interface) {
        case PLInterface_Login:
        {   
            BSBUserModel *userModel = [BSBUserModel yy_modelWithDictionary:responseDic[@"logonAdmin"]];
            
            if (baseModel.code == 1) {
                
                [MBProgressHUD showSuccess:@"登录成功"];
                //保存用户信息
                [BSBSaveUserInfo saveUserId:userModel.t_com_admin_id];
                [BSBSaveUserInfo saveMobile:userModel.extendone];
                [BSBSaveUserInfo saveSessionKey:baseModel.sessionKey];
                
                if (self.isRemember) {
                    [BSBSaveUserInfo saveUserPassWord:self.fieldPwd.text];
                }else{
                    [BSBSaveUserInfo saveUserPassWord:@""];//避免其他地方调整
                }
                
                [BSBSaveUserInfo saveLogin:YES];
                //通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kloginOperation" object:nil];
                
                BSBBaseViewController *ctl = [[NSClassFromString(@"BSBServiceListViewController") alloc] init];
                [self.navigationController pushViewController:ctl animated:YES];

            }

        }
            break;
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
