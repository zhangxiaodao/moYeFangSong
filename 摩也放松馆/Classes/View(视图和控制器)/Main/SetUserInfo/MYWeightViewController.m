//
//  MYWeightViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/6.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYWeightViewController.h"
#import "MYDividingRuleView.h"
#import "MYPhoneViewController.h"

@interface MYWeightViewController ()<MYDividingRuleViewDelegate>
@property (nonatomic , strong) UILabel *weightLabel;

@end

@implementation MYWeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    [super setupUI];
    
    self.titlelabel.text = @"请选择您的体重";
    
    self.backbtn.hidden = NO;
    self.nextbtn.hidden = NO;
    
    UIImageView *weightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weight"]];
    [self.centerView addSubview:weightImageView];
    [weightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.centerView.mas_centerX);
        make.centerY.mas_equalTo(self.centerView.mas_centerY).offset(kScreenW / 15);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 6.5, kScreenW / 1.3));
    }];
    
    MYDividingRuleView *ruleView = [MYDividingRuleView showRulerWithFrame:CGRectMake(0, 0, kScreenW / 1.3, kScreenW / 4.6875) ruleCount:200 average:@(1) currentValue:100 horizontal:YES];
    [self.centerView addSubview:ruleView];
    [ruleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.centerView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 1.3, kScreenW / 4.6875));
        make.top.mas_equalTo(weightImageView.mas_top).offset(kScreenW / 15);
    }];
    ruleView.rulerDelegate = self;
    ruleView.backgroundColor = [UIColor whiteColor];

    UIView *handView = [[UIView alloc]init];
    [self.view addSubview:handView];
    [handView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ruleView.mas_centerX);
        make.top.mas_equalTo(ruleView.mas_top);
        make.size.mas_equalTo(CGSizeMake(1, 40));
    }];
    handView.backgroundColor = kMainColor;
    
    UILabel *weightLabel = [UILabel cz_labelWithText:@"" fontSize:k40 color:kMainColor textAligment:NSTextAlignmentCenter superView:self.centerView];
    [weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ruleView.mas_centerX);
        make.bottom.mas_equalTo(weightImageView.mas_top).offset(- kScreenW / 30);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 8));
    }];
    self.weightLabel = weightLabel;
}

- (void)nextbtnAtcion {
    MYPhoneViewController *phoneVC = [[MYPhoneViewController alloc]init];
    phoneVC.navigationItem.title = @"完善个人信息(5/5)";
    [self.navigationController pushViewController:phoneVC animated:YES];
}

#pragma mark - MYDividingRuleViewDelegate
- (void)dividingRuleCurrentVaule:(MYDividingRuleScrollView *)rulerScrollView {
    NSString *text = [NSString stringWithFormat:@"%.0fkg",rulerScrollView.rulerValue];
    self.weightLabel.attributedText = [NSAttributedString cz_AttributedSubString:NSMakeRange(text.length - 2, 2) attributedSize:k14 attributedColor:[UIColor lightGrayColor] text:text];
}

@end
