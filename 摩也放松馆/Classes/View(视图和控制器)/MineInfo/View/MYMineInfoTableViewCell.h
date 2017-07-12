//
//  MYMineInfoTableViewCell.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/10.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYMineInfoTableViewCell : UITableViewCell
@property (nonatomic , copy) NSString *imageName;
@property (nonatomic , copy) NSString *text;
@property (nonatomic , strong) NSIndexPath *indexPath;

@end
