//
//  MYHeightViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/6.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYHeightViewController.h"
#import "MYDividingRuleView.h"
#import "MYWeightViewController.h"

@interface MYHeightViewController ()<MYDividingRuleViewDelegate>
@property (nonatomic , strong) UILabel *heightLabel;
@end

@implementation MYHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlelabel.text = @"请选择您的身高";
    
    [self setupUI];
    
}

- (void)setupUI {
    
    self.backbtn.hidden = NO;
    self.nextbtn.hidden = NO;
    
    MYDividingRuleView *ruleView = [MYDividingRuleView showRulerWithFrame:CGRectMake(kScreenW / 1.5, 0, kScreenW / 4.4, kScreenH / 1.6) ruleCount:240 average:@(1) currentValue:170 horizontal:NO];
    [self.centerView addSubview:ruleView];
    ruleView.rulerDelegate = self;
    
    UIImageView *triangleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"triangle"]];
    [self.centerView addSubview:triangleImageView];
    [triangleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ruleView.mas_centerY);
        make.right.mas_equalTo(ruleView.mas_left);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
    }];
    
    UILabel *heightLabel = [UILabel cz_labelWithText:@"" fontSize:k40 color:kMainColor textAligment:NSTextAlignmentRight superView:self.centerView];
    [heightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ruleView.mas_centerY);
        make.right.mas_equalTo(self.centerView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 9.375));
    }];
    self.heightLabel = heightLabel;
    
    NSString *text = @"170cm";
    self.heightLabel.attributedText = [NSAttributedString cz_AttributedSubString:NSMakeRange(text.length - 2, 2) attributedSize:k14 attributedColor:[UIColor lightGrayColor] text:text];
}

- (void)nextbtnAtcion {
    MYWeightViewController *wightVC = [[MYWeightViewController alloc]init];
    wightVC.navigationItem.title = @"完善个人信息(4/5)";
    wightVC.model = self.model;
    [self.navigationController pushViewController:wightVC animated:YES];
}

#pragma mark - MYDividingRuleViewDelegate
- (void)dividingRuleCurrentVaule:(MYDividingRuleScrollView *)rulerScrollView {
    NSString *text = [NSString stringWithFormat:@"%.0fcm",rulerScrollView.rulerValue];
    self.heightLabel.attributedText = [NSAttributedString cz_AttributedSubString:NSMakeRange(text.length - 2, 2) attributedSize:k14 attributedColor:[UIColor lightGrayColor] text:text];
    self.model.height = self.heightLabel.attributedText.string;
    
}

@end
