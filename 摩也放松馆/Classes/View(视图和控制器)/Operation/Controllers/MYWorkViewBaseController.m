//
//  MYWorkViewBaseController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYWorkViewBaseController.h"
#import "MYNavViewController.h"
#import "MYCustomLayout.h"
#import "MYWorkCollectionViewCell.h"
#import "MYGearView.h"
@interface MYWorkViewBaseController ()<MYWorkTypeBtnViewDelegate , UICollectionViewDataSource , UICollectionViewDelegate>

@end

@implementation MYWorkViewBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCOLOR(249, 251, 252);
    
    [self setupNav];
    
    [self setupUI];
    
}

- (void)setupNav {
    MYNavViewController *nav = (MYNavViewController *)self.navigationController;
    
    UIColor *color = [UIColor lightGrayColor];
    
    [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    nav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    
    [nav.backButton setImage:[UIImage imageNamed:@"navigationButtonReturn_white"] forState:UIControlStateNormal];
    [nav.backButton setTitleColor:color forState:UIControlStateNormal];
    
}

- (void)setupUI {

    UIImageView *backIv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.backImageName]];
    [self.view addSubview:backIv];
    backIv.frame = CGRectMake(0, 0, kScreenW, kScreenH / 1.46);
    backIv.layer.shadowColor = kWhiteColor.CGColor;
    backIv.layer.shadowOffset = CGSizeMake(-5, 5);
    backIv.layer.shadowOpacity = 0.5;
    backIv.layer.shadowRadius = 5;
    
    MYWorkTypeBtnView *btnView = [[MYWorkTypeBtnView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenW / 10.5)];
    [self.view addSubview:btnView];
    btnView.typeArray = self.typeArray;
    btnView.delegate = self;
    self.btnView = btnView;
    
    MYCustomLayout *layout = [[MYCustomLayout alloc]init];
    layout.scale = 1.1;
    layout.itemSize = CGSizeMake(kScreenW / 1.36, kScreenH / 1.98);
    layout.spacing = kScreenW / 7.5;
    layout.edgeInset = UIEdgeInsetsMake(kScreenW / 7.5, kScreenW / 7.5, kScreenW / 7.5, kScreenW / 7.5);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64 + kScreenW / 10.5, kScreenW, kScreenH / 1.7) collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.showsHorizontalScrollIndicator = false;
    [collectionView registerClass:[MYWorkCollectionViewCell class] forCellWithReuseIdentifier:@"celled"];
    self.collectionView = collectionView;
    
    UILabel *timeLabel = [UILabel cz_labelWithText:@"30:00" fontSize:k30 color:kCOLOR(129, 175, 199) textAligment:NSTextAlignmentCenter superView:self.view];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW , kScreenW / 10));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(collectionView.mas_bottom);
    }];
    
    MYGearView *gearView = [[MYGearView alloc]initWithFrame:CGRectMake(0, kScreenH / 1.25, kScreenW, kScreenW / 7.5)];
    [self.view addSubview:gearView];
    
    UIButton *switchBtn = [UIButton cz_imageButton:@"switch" backgroundImageName:nil];
    [self.view addSubview:switchBtn];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6.25 , kScreenW / 5.36));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    [switchBtn addTarget:self action:@selector(switchAtcion) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - switchAtcion
- (void)switchAtcion {
    NSLog(@"点击了开关");
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNameAy.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MYWorkCollectionViewCell *cell = (MYWorkCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"celled" forIndexPath:indexPath];    
    cell.imageName = self.imageNameAy[indexPath.item];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    UIButton *btn = self.btnView.subviews[indexPath.item];
    
    [self.btnView btnAtcion:btn];
    
    
}

#pragma mark - MYWorkTypeBtnViewDelegate
- (void)touchWhitchBtn:(NSInteger)item {
   
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:item inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}

#pragma mark - 懒加载
//- (void)setTypeArray:(NSArray *)typeArray {
//    _typeArray = typeArray;
//}
//
//- (void)setImageNameAy:(NSArray *)imageNameAy {
//    _imageNameAy = imageNameAy;
//}

@end
