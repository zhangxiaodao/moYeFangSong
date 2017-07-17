//
//  MYWorkViewBaseController.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYWorkTypeBtnView.h"
@interface MYWorkViewBaseController : UIViewController
@property (nonatomic , strong) NSArray *imageNameAy;
@property (nonatomic , copy) NSString *backImageName;
@property (nonatomic , strong) NSArray *typeArray;

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) MYWorkTypeBtnView *btnView;

@end
