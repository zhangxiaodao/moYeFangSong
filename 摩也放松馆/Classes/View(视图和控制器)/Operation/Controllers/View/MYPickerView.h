//
//  MYPickerView.h
//  MYPickerViewSample
//
//  Created by MYio Yasui on 3/29/14.
//  Copyright (c) 2014 MYio Yasui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MYPickerViewStyle) {
	MYPickerViewStyle3D = 1,
	MYPickerViewStyleFlat
};

@class MYPickerView;

@protocol MYPickerViewDataSource <NSObject>
@required
- (NSUInteger)numberOfItemsInPickerView:(MYPickerView *)pickerView;
@optional
- (NSString *)pickerView:(MYPickerView *)pickerView titleForItem:(NSInteger)item;
- (UIImage *)pickerView:(MYPickerView *)pickerView imageForItem:(NSInteger)item;
@end

@protocol MYPickerViewDelegate <UIScrollViewDelegate>
@optional
- (void)pickerView:(MYPickerView *)pickerView didSelectItem:(NSInteger)item;
- (CGSize)pickerView:(MYPickerView *)pickerView marginForItem:(NSInteger)item;
- (void)pickerView:(MYPickerView *)pickerView configureLabel:(UILabel * const)label forItem:(NSInteger)item;
@end

@interface MYPickerView : UIView

@property (nonatomic, weak) id <MYPickerViewDataSource> dataSource;
@property (nonatomic, weak) id <MYPickerViewDelegate> delegate;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIFont *highlightedFont;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *highlightedTextColor;
@property (nonatomic, assign) CGFloat interitemSpacing;
@property (nonatomic, assign) CGFloat fisheyeFactor; // 0...1; slight value recommended such as 0.0001
@property (nonatomic, assign, getter=isMaskDisabled) BOOL maskDisabled;
@property (nonatomic, assign) MYPickerViewStyle pickerViewStyle;
@property (nonatomic, assign) int selectedItem;
@property (nonatomic, assign, readonly) CGPoint contentOffset;



- (void)reloadData;
- (void)scrollToItem:(NSUInteger)item animated:(BOOL)animated;
- (void)selectItem:(NSUInteger)item animated:(BOOL)animated;
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end
