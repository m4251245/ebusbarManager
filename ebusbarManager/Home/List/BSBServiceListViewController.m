//
//  BSBServiceListViewController.m
//  ebusbarManager
//
//  Created by 刘必红 on 2017/5/24.
//  Copyright © 2017年 深圳前海巴斯巴网络服务有限公司. All rights reserved.
//

#import "BSBServiceListViewController.h"
#import "BSBServicesListModel.h"
#import "BSBScanListViewController.h"

@interface BSBServiceListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation BSBServiceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"管理租车点";
    
    [self requestList];
    [self configUI];
}

- (void)configUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavBarHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    
}

- (void)requestList
{
    NSDictionary *paramDic = @{@"id":[BSBSaveUserInfo getUserId],
                               @"sessionKey":[BSBSaveUserInfo getSessionKey]};
    [self sendRequestWithMethod:GET interface:PLInterface_GetAdminPlace urlParams:paramDic bodyParams:nil];
}

- (void)handleNetWorkResponseSuccess:(NSDictionary *)jsonDic
{
    [super handleNetWorkResponseSuccess:jsonDic];
    
    NSInteger interface = [jsonDic[@"interface"] integerValue];
    NSDictionary *responseDic = jsonDic[@"response"];
    BSBBaseModel *baseModel = [BSBBaseModel yy_modelWithDictionary:responseDic];
    
    switch (interface) {
        case PLInterface_GetAdminPlace:
        {
            
            if (baseModel.code == 1) {
                NSArray *listArray = responseDic[@"list"];
                for (NSDictionary *dic in listArray) {
                    BSBServicesListModel *model = [BSBServicesListModel yy_modelWithDictionary:dic];
                    
                    [self.dataSouce addObject:model];
                }
                
                [self.tableView reloadData];
            }
        }
            break;
            
        default:
            break;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

    }
    
    BSBServicesListModel *model = self.dataSouce[indexPath.row];
    
    cell.imageView.frame = CGRectMake(5, 13, 13, 18);
    cell.imageView.image = [UIImage imageNamed:@"icon_location"];
//    cell.imageView.backgroundColor = [UIColor grayColor];
    cell.textLabel.text = model.address;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BSBScanListViewController *ctl = [[BSBScanListViewController alloc] init];
    
    BSBServicesListModel *model = self.dataSouce[indexPath.row];
    ctl.companyName = model.name;
    ctl.place_id = model.t_rent_place_id;
    [self.navigationController pushViewController:ctl animated:YES];
}

-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
