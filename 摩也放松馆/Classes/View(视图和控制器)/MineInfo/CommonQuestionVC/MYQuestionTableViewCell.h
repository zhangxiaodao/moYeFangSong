//
//  MYQuestionTableViewCell.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/18.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYQuestionTableViewCell : UITableViewCell

@property (nonatomic , strong) NSIndexPath *indexPath;

@property (nonatomic , assign) CGFloat height;

@property (nonatomic , strong) NSArray *labelArray;

@end
