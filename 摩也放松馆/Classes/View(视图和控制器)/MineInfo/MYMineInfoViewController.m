//
//  MYMineInfoViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/7.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYMineInfoViewController.h"
#import "MYMineInfoTableViewCell.h"
static NSString *cellID = @"cellID";

@interface MYMineInfoViewController ()<UITableViewDelegate , UITableViewDataSource>

@end

@implementation MYMineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc]initWithFrame:kScreenFrame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tableView registerClass:[MYMineInfoTableViewCell class] forCellReuseIdentifier:cellID];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 2;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenW / 5.8;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MYMineInfoTableViewCell *cell = (MYMineInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.indexPath = indexPath;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenW / 18.75;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


@end
