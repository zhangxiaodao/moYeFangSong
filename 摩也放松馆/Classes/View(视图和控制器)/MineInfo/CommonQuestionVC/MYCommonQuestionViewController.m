//
//  MYCommonQuestionViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/17.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYCommonQuestionViewController.h"
#import "MYQuestionHeaderView.h"
#import "MYCalculateHeight.h"

@interface MYCommonQuestionViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong) NSArray *titleArray;
@property (nonatomic , strong) NSMutableArray *heightArray;


@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSMutableDictionary *dic;

@end
static NSString *cellID = @"cellID";
@implementation MYCommonQuestionViewController

- (NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
        for (int i = 0; i < 8; i++) {
            [_dic setValue:@(0) forKey:[NSString stringWithFormat:@"%d" , i]];
        }
    }
    return _dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    _tableView = [[UITableView alloc]initWithFrame:kScreenFrame style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSectionFooterHeight:0];
    _tableView.backgroundColor = [UIColor clearColor];

}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionStr = [NSString stringWithFormat:@"%ld" , section];
    if ([self.dic[sectionStr] intValue] == 1) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat height = [self.heightArray[section] floatValue];
    MYQuestionHeaderView *view = [[MYQuestionHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, height + kScreenW * 2 / 25) withText:self.titleArray[section]];
    view.tag = section;
    view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewTapAtcion:)];
    [view addGestureRecognizer:tap];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = [self.heightArray[section] floatValue];
    return height + kScreenW * 2 / 25;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - 头部点击事件
- (void)headerViewTapAtcion:(UIGestureRecognizer *)tap {
    
    MYQuestionHeaderView *view = (MYQuestionHeaderView *)tap.view;
    [UIView animateWithDuration:0.15 animations:^{
        view.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }];
    
    
    NSString *section = [NSString stringWithFormat:@"%ld" , tap.view.tag];
    
    if ([self.dic[section] integerValue] == 0) {
        [self.dic setValue:@(1) forKey:section];
    } else {
        [self.dic setValue:@(0) forKey:section];
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:tap.view.tag];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"如何绑定设备?" ,
                        @"如何解绑设备?" ,
                        @"如何通过手机关闭设备?" ,
                        @"如何进行运行界面设定?" ,
                        @"出现[设备断开连接]应该怎么办?" ,
                        @"APP在运行时而身体已经感觉不到按摩的动作是什么情况导致的?怎么办?" ,
                        @"出现设备死机的情况怎么办?" ,
                        @"按摩的时候突然出现针刺的感觉，是怎么回事?" ,
                        @"设备贴在什么位置按摩效果好?" ,
                        @"关于电极片" ,
                        @"忌用人群"];
    }
    return _titleArray;
}

- (NSMutableArray *)heightArray {
    if (!_heightArray) {
        _heightArray = [NSMutableArray array];
        
        for (NSString *text in self.titleArray) {
            [_heightArray addObject:@([MYCalculateHeight calculateHeight:text fontSize:k15])];
        }
        
    }
    return _heightArray;
}

@end
