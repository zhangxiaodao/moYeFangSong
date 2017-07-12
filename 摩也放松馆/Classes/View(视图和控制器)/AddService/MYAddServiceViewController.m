//
//  MYAddServiceViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/7.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYAddServiceViewController.h"
#import "MYSearchSerViewController.h"

@interface MYAddServiceViewController ()
@property (nonatomic , strong) CAShapeLayer *shapeLayer;
@end

@implementation MYAddServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)setupUI {
    
    UIButton *addSer = [UIButton cz_textButton:@"添加新设备" fontSize:k14 normalColor:kMainColor highlightedColor:kMainColor];
    [self.view addSubview:addSer];
    addSer.frame = CGRectMake(kScreenW / 11.5, kScreenW / 15,kScreenW / 1.2, kScreenW / 5);
    [addSer addTarget:self action:@selector(touchDownAtcion) forControlEvents:UIControlEventTouchDown];
    [addSer addTarget:self action:@selector(touchUpInsideAtcion) forControlEvents:UIControlEventTouchUpInside];
    
    self.shapeLayer = [self addLineDashLayer:addSer lineColor:kCOLOR(215, 220, 203)];
    
    UILabel *alertLabel = [UILabel cz_labelWithText:@"设备左滑可以换机和删除哦~" fontSize:k13 color:[UIColor lightGrayColor] textAligment:NSTextAlignmentCenter superView:self.view];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kScreenW / 25 - self.tabBarController.tabBar.height);
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenW / 25));
    }];
    
    
}


- (void)touchDownAtcion{
    self.shapeLayer.hidden = YES;
}

- (void)touchUpInsideAtcion{
    self.shapeLayer.hidden = NO;
    
    MYSearchSerViewController *searchVC = [[MYSearchSerViewController alloc]init];
    searchVC.navigationItem.title = @"搜索设备";
    [self.navigationController pushViewController:searchVC animated:YES];
    
}


/**
 给控件添加虚线框

 @param superView 给定的控件
 @param color 虚线框的颜色
 */
- (CAShapeLayer *)addLineDashLayer:(UIView *)superView lineColor:(UIColor *)color{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    shapeLayer.lineWidth = 1;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    CGPathAddRect(path, nil, superView.layer.bounds);
    shapeLayer.path = path;
    NSArray *lineDashArray = [NSArray arrayWithObjects:[NSNumber numberWithInteger:5],[NSNumber numberWithInteger:2], nil];
    shapeLayer.lineDashPattern = lineDashArray;
    [superView.layer addSublayer:shapeLayer];
    
    CGPathRelease(path);
    
    return shapeLayer;
}

@end
