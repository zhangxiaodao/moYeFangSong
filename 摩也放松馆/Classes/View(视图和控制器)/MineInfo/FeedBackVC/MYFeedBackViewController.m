//
//  MYFeedBackViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/17.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYFeedBackViewController.h"
#import "MYFeedBackInputView.h"
#import "MYFeedBackTableViewCell.h"
#import "MYCalculateHeight.h"

#define inputViewHeight (kScreenW / 6.8)
@interface MYFeedBackViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSouce;

@property (nonatomic , strong) MYFeedBackInputView *inputView;

@end
static NSString *identify = @"MKJChatTableViewCell";


@implementation MYFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)setupUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64 - 30) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
    [tableView registerClass:[MYFeedBackTableViewCell class] forCellReuseIdentifier:identify];
    self.tableView = tableView;
    
    UIView *view = [[UIView alloc] init];
    tableView.tableFooterView = view;
    
    // 底部输入栏
    MYFeedBackInputView *inputView = [[MYFeedBackInputView alloc] initWithFrame:CGRectMake(0, kScreenH - inputViewHeight - 64, kScreenW, inputViewHeight)];
    [self.view addSubview:inputView];
    
    inputView.textField.delegate = self;
    [inputView.button addTarget:self action:@selector(clickSengMsg:) forControlEvents:UIControlEventTouchUpInside];
    self.inputView = inputView;
    
    
    // 注册键盘的通知hide or show
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - 发送按钮点击事件
- (void)clickSengMsg:(UIButton *)btn {
    if (![self.inputView.textField.text isEqualToString:@""])
    {
        NSString *msg = self.inputView.textField.text;
        [self.dataSouce addObject:msg];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSouce.count - 1 inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataSouce.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
    if (self.dataSouce.count != 0) {
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark - notification  Atcion
- (void)keyBoardShow:(NSNotification *)noti {
    CGRect rec = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"%@",NSStringFromCGRect(rec));
    
    CGRect tempRec = self.view.frame;
    tempRec.origin.y = - (rec.size.height) + 64;
    self.view.frame = tempRec;
    
    self.tableView.frame = CGRectMake(0, rec.size.height, kScreenW, kScreenH - 64 - rec.size.height - inputViewHeight);
    if (self.dataSouce.count != 0)
    {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSouce.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)keyboardHide:(NSNotification *)noti {
    self.view.frame = CGRectMake(0, 64, kScreenW, kScreenH);
    self.tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH - 64 - inputViewHeight);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MYFeedBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    [cell refreshCell:self.dataSouce[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *msg = self.dataSouce[indexPath.row];
    CGFloat height = [MYCalculateHeight calculateHeight:msg fontSize:k15];
    return height + 45;
    
}

- (NSMutableArray *)dataSouce
{
    if (_dataSouce == nil) {
        _dataSouce = [[NSMutableArray alloc] init];
    }
    return _dataSouce;
}

- (void)click:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

@end
