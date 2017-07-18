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
#import "MYQuestionTableViewCell.h"

@interface MYCommonQuestionViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong) NSArray *titleArray;
@property (nonatomic , strong) NSMutableArray *heightArray;
@property (nonatomic , strong) NSArray *rowTitleArray;
@property (nonatomic , strong) NSMutableArray *rowHeightArray;

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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerClass:[MYQuestionTableViewCell class] forCellReuseIdentifier:cellID];
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.height = [self.rowHeightArray[indexPath.section] floatValue];
    cell.labelArray = self.rowTitleArray[indexPath.section];
    
    return cell;
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.rowHeightArray[indexPath.section] floatValue];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - 头部点击事件
- (void)headerViewTapAtcion:(UIGestureRecognizer *)tap {
    
    MYQuestionHeaderView *view = (MYQuestionHeaderView *)tap.view;
//    [UIView animateWithDuration:0.15 animations:^{
//        view.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
//    }];
    
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    anim.toValue = @(M_PI);
//    anim.duration = 0.5;
//    anim.removedOnCompletion = YES;
//    [view.imageView.layer addAnimation:anim forKey:nil];
    
    
    NSString *section = [NSString stringWithFormat:@"%ld" , tap.view.tag];
    
    if ([self.dic[section] integerValue] == 0) {
        [self.dic setValue:@(1) forKey:section];
    } else {
        [self.dic setValue:@(0) forKey:section];
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:tap.view.tag];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationMiddle];
    
}

#pragma mark - 懒加载
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


- (NSArray *)rowTitleArray {
    if (!_rowTitleArray) {
        _rowTitleArray = @[@[
                            @"→在主界面点击底部菜单的[设备]，进入设备管理界面。" ,
                            @"→点击[添加新设备]" ,
                            @"→选择您所持有的设备进行搜索，在搜索出的设备里表中选中一个或多个设备后点击[测试]，运行呼吸灯出现闪烁,则表示这是您当前选定的设备" ,
                            @"→点击忧伤减的确定按钮即可绑定设备。" ,
                            @"→返回主界面后，点击[放松馆]，选取您想要的放松方式，开始放松之旅"] ,
                        @[@"点击底部菜单的[设备]进入设备管理界面，向左滑动想要删除的设备栏，点击[删除]。"] ,
                        @[@"点击底部菜单的[设备]进入设备管理界面，向左滑动想要关闭的设备栏，点击[关机],设备指示灯熄灭，表示设备已关机。"] ,
                        @[@"→点击摸个放松管进入运行界面。" ,
                          @"→在拥有多个按摩动作的放松馆，可以左右滑动或点击动作选项卡切换按摩动作。" ,
                          @"→点击力度条左右的[+][-]号调整力度" ,
                          @"点击最下方大按钮开始&暂停按摩。"] ,
                        @[@"出现主动关闭设备，设备断开连接一般有两种原因:" ,
                          @"蓝牙断开:蓝牙信号不稳定或者手机距离设备超过蓝牙的有效距离(半径10米左右)会导致设备断开，这种情况下不进行热合操作，贷蓝牙信号稳定或进入蓝牙有效距离后，继续操作即可。您也可以手动在设备管理页面点击该设备栏重新连接。" ,
                          @"设备电量过低:通常设备电量低于10%时会导致设备无法有效运行，经常断开连接，此时应给设备充电后才能使用。"] ,
                        @[@"通常设备电量低于10%会导致这种情况，这时候需要给设备充电后才能使用。"] ,
                        @[@"这种情况发生的几率非常小，在此情况下，可以使用针状物，轻捅底部重置按钮是设备恢复出厂设置，设备即可重新正常工作。"] ,
                        @[@"因为人的体质不同，以及人在不同的精神状态下身体的敏感度不同，所以对脉冲的感觉也不尽相同。如果感觉到刺痛，井盖立刻停止，换个时间在进行。如果您还想继续按摩，请改变设备的铁房位置，直到您不再有针刺感" ,
                          @"大多数情况下都是贴片黏性不够造成的刺痛感，则应该更换贴片或用水冲洗贴片并晾干后在进行按摩。"] ,
                        @[@"最佳位置:肩部、背部、腰部。" ,
                          @"次佳位置:臀部、腿部。" ,
                          @"忌帖位置:头颈部、胸腹部和其他敏感部位。"],
                        @[@"通常一副电极片可重复使用50次左右，在使用过程中电极片可直接水洗晾干后继续使用，如果电极片黏性不够会导致按摩出现刺痛感，这时候必须更换新的电极片。"] ,
                        @[@"儿童、孕妇、心脏病患者"]
                        ];
    }
    return _rowTitleArray;
}

- (NSMutableArray *)rowHeightArray {
    if (!_rowHeightArray) {
        _rowHeightArray = [NSMutableArray array];
        
        for (NSArray *textArray in self.rowTitleArray) {
            CGFloat height = 0;
            for (NSString *text in textArray) {
                height += [MYCalculateHeight calculateHeight:text fontSize:k13];
                height += kScreenW / 25 + 2;
                
            }
            height += kScreenW / 25;
            [_rowHeightArray addObject:@(height)];
        }
    }
    return _rowHeightArray;
}

@end
