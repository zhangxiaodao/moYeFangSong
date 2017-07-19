//
//  MYOperationViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/7.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYOperationViewController.h"
#import "MYOperationCell.h"
#import "MYWorkViewBaseController.h"


static NSString *celled = @"MYOperationCell";

@interface MYOperationViewController ()<UICollectionViewDelegate , UICollectionViewDataSource>
@property (nonatomic , strong) NSArray *nameArray;
@property (nonatomic , strong) NSArray *imageArray;
@property (nonatomic , strong) NSArray *firstTypeArray;
@property (nonatomic , strong) NSArray *firstImageArray;
@property (nonatomic , strong) NSArray *secondArray;
@property (nonatomic , strong) NSArray *secondImageArray;

@property (nonatomic , strong) NSArray *backImageArray;
@end

@implementation MYOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = kCOLOR(249, 251, 252);
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MYOperationCell *cell = (MYOperationCell *)[collectionView dequeueReusableCellWithReuseIdentifier:celled forIndexPath:indexPath];
    cell.imageName = self.imageArray[indexPath.item];
    cell.text = self.nameArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MYWorkViewBaseController *workVC = [[MYWorkViewBaseController alloc]init];
    workVC.navigationItem.title = self.nameArray[indexPath.item];
    workVC.backImageName = self.backImageArray[indexPath.item];
    
    if (indexPath.item == 0) {
        workVC.typeArray = [NSArray arrayWithArray:self.firstTypeArray];
        workVC.imageNameAy = [NSArray arrayWithArray:self.firstImageArray];
    } else if (indexPath.item == 1) {
        workVC.typeArray = [NSArray arrayWithArray:self.secondArray];
        workVC.imageNameAy = [NSArray arrayWithArray:self.secondImageArray];
    } else {
        workVC.typeArray = @[];
        workVC.imageNameAy = @[];
    }
    
    [self.navigationController pushViewController:workVC animated:YES];
}

#pragma mark - 懒加载
- (NSArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [NSArray arrayWithObjects:@"经典模式" , @"中医理疗" , @"禅*道" ,@"宅印象" ,@"办公室" ,@"听潮" ,@"空谷" ,@"在路上" ,@"小憩" ,@"旅行" , nil];
    }
    return _nameArray;
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSArray arrayWithObjects:@"jingDian" , @"zhongYi" , @"chanDao" , @"zhai" , @"banGongShi" , @"tingChao" , @"kongGu" , @"zaiLuShang" , @"xiaoQi" ,@"lvXing" ,nil];
    }
    return _imageArray;
}

- (NSArray *)firstTypeArray {
    if (!_firstTypeArray) {
        _firstTypeArray = [NSArray arrayWithObjects: @"揉", @"按", @"挤", @"抚", @"肘", @"锤", nil];
    }
    return _firstTypeArray;
}

- (NSArray *)secondArray {
    if (!_secondArray) {
        _secondArray = [NSArray arrayWithObjects:@"推拿",@"针灸",@"火罐",@"刮痧", nil];
    }
    return _secondArray;
}

- (NSArray *)firstImageArray {
    if (!_firstImageArray) {
        _firstImageArray = @[@"rou" , @"an" , @"ji" , @"fu" , @"zhou" , @"chui"];
    }
    return _firstImageArray;
}

- (NSArray *)secondImageArray {
    if (!_secondImageArray) {
        _secondImageArray = @[@"tuiNa",@"zhenJiu",@"huoGuan",@"guaSha"];
    }
    return _secondImageArray;
}

- (NSArray *)backImageArray {
    if (!_backImageArray) {
        _backImageArray = @[@"work_back" , @"work_back" , @"chanDao_back" , @"zhai_back" , @"banGong_back" , @"tingChao_back" , @"kongGu_back" , @"zaiLuShang_back" , @"xiaoQi_back" , @"lvXing_back"];
    }
    return _backImageArray;
}

@end
