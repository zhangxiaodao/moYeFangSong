//
//  MYOperationViewController.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/7.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYOperationViewController.h"
#import "MYOperationCell.h"
#import "MYWorkViewController.h"


static NSString *celled = @"MYOperationCell";

@interface MYOperationViewController ()<UICollectionViewDelegate , UICollectionViewDataSource>
@property (nonatomic , strong) NSArray *nameArray;
@property (nonatomic , strong) NSArray *imageArray;
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
    MYWorkViewController *workVC = [[MYWorkViewController alloc]init];
    workVC.navigationItem.title = self.nameArray[indexPath.item];
    [self.navigationController pushViewController:workVC animated:YES];
}

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

@end
