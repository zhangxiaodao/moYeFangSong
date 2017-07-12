//
//  MYWorkTypeBtnView.h
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MYWorkTypeBtnViewDelegate <NSObject>

- (NSInteger)touchWhitchBtn:(NSInteger)item;

@end

@interface MYWorkTypeBtnView : UIView

@property (nonatomic , assign) id<MYWorkTypeBtnViewDelegate> delegate;

@end
