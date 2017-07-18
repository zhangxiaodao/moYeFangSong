//
//  MYUserInfoViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/17.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYUserInfoViewController.h"
#import "MYUserInfoBaseViewController.h"

@interface MYUserInfoViewController ()<UITableViewDelegate , UITableViewDataSource , MYUserInfoBaseDelegate>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSArray *nameArray;
@property (nonatomic , strong) NSMutableArray *modelArray;
@property (nonatomic , strong) NSArray *vcArray;
@property (nonatomic , strong) MYUserInfoModel *model;


@end
static NSString *cellID = @"cellID";
@implementation MYUserInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [[MYUserInfoModel alloc]init];
    if ([kStanderDefault objectForKey:@"UserInfoModel"]) {
        self.model = [kStanderDefault objectForKey:@"UserInfoModel"];
    } else {
        self.model.sex = @"女";
        self.model.birthday = @"1991-1-1";
        self.model.height = @"170cm";
        self.model.weight = @"50kg";
        self.model.phoneNumber = @"";
    }
    
    [self setupUI];
}


- (void)setupUI {
    _tableView = [[UITableView alloc]initWithFrame:kScreenFrame style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(-kScreenW / 10.7, 0, 0, 0);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.nameArray[indexPath.row];
    cell.detailTextLabel.text = self.modelArray[indexPath.row];
    
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *clsName = self.vcArray[indexPath.row];
    MYUserInfoBaseViewController *vc = [[NSClassFromString(clsName) alloc] init];
    vc.delegate = self;
    vc.navigationItem.title = self.nameArray[indexPath.row];
    vc.bottomViewHidden = @"YES";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)sendInfoToSuperVC:(MYUserInfoModel *)model {
    
    self.model = model;
    
    [self.modelArray removeAllObjects];
    [self.modelArray addObject:self.model.phoneNumber];
    [self.modelArray addObject:self.model.sex];
    [self.modelArray addObject:self.model.birthday];
    [self.modelArray addObject:self.model.height];
    [self.modelArray addObject:self.model.weight];
    
    [self.tableView reloadData];
}

#pragma mark - 懒加载
- (NSArray *)vcArray {
    if (!_vcArray) {
        _vcArray = @[@"MYPhoneViewController" ,
                     @"MYSexViewController" ,
                     @"MYBirthdayViewController" ,
                     @"MYHeightViewController" ,
                     @"MYWeightViewController"];
    }
    return _vcArray;
}

- (NSArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray arrayWithObjects:self.model.phoneNumber , self.model.sex ,self.model.birthday ,self.model.height ,self.model.weight, nil];
    }
    return _modelArray;
}

- (NSArray *)nameArray {
    if (!_nameArray) {
        _nameArray = @[@"手机号" ,
                       @"性别" ,
                       @"出生日期" ,
                       @"身高" ,
                       @"体重"];
    }
    return _nameArray;
}

@end
