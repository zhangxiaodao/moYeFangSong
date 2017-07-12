//
//  MYCustomLayout.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYCustomLayout : UICollectionViewLayout

@property (nonatomic , assign) CGSize itemSize;
@property (nonatomic , assign) CGFloat spacing;
@property (nonatomic , assign) CGFloat scale;
@property (nonatomic , assign) UIEdgeInsets edgeInset;
@property (nonatomic , assign) UICollectionViewScrollDirection scrollDirection;

@end
