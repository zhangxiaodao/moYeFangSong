//
//  MYCustomLayout.m
//  摩也放松馆
//
//  Created by 杭州阿尔法特 on 2017/7/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MYCustomLayout.h"

@interface MYCustomLayout ()
@property (nonatomic , strong) NSMutableArray *rectAttributes;;
@end

@implementation MYCustomLayout

- (NSMutableArray *)rectAttributes {
    if (!_rectAttributes) {
        _rectAttributes = [NSMutableArray array];
    }
    return _rectAttributes;
}

- (void)setItemSize:(CGSize)itemSize {
    
    if (!CGSizeEqualToSize(itemSize, CGSizeZero)) {
        _itemSize = itemSize;
    } else {
        _itemSize = CGSizeMake(280, 400);
    }
    
    [self invalidateLayout];
}

- (void)setSpacing:(CGFloat)spacing {
    if (spacing != 0.0) {
        _spacing = spacing;
    } else {
        _spacing = 20.0;
    }
    [self invalidateLayout];
}

- (void)setScale:(CGFloat)scale {
    if (scale != 0) {
        _scale = scale;
    } else {
        _scale = 1.0;
    }
    [self invalidateLayout];
}

- (void)setEdgeInset:(UIEdgeInsets)edgeInset {
    if (!UIEdgeInsetsEqualToEdgeInsets(edgeInset, UIEdgeInsetsZero)) {
        _edgeInset = edgeInset;
    } else {
        _edgeInset = UIEdgeInsetsMake(20, 20, 20, 20);
    }
    [self invalidateLayout];
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    [self invalidateLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    if (self.collectionView == nil) {
        return CGSizeZero;
    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat width , height;
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionHorizontal:
            width = count * (self.itemSize.width + self.spacing) - self.spacing + self.edgeInset.left + self.edgeInset.right;
            height = self.collectionView.bounds.size.height;
            break;
        case UICollectionViewScrollDirectionVertical:
            width = self.collectionView.bounds.size.width;
            height = count * (self.itemSize.height + self.spacing) - self.spacing + self.edgeInset.top + self.edgeInset.bottom;
        default:
            break;
    }
    return CGSizeMake(width, height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.collectionView == nil) {
        return nil;
    }
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.size = self.itemSize;
    
    CGFloat x , y;
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionHorizontal:
            x = self.edgeInset.left + indexPath.item * (self.itemSize.width + self.spacing);
            y = 0.5 * (self.collectionView.bounds.size.height - self.itemSize.height);
            break;
        case UICollectionViewScrollDirectionVertical:
            x = 0.5 * (self.collectionView.bounds.size.width - self.itemSize.width);
            y = self.edgeInset.top + indexPath.item*(self.itemSize.height+self.spacing);
            break;
        default:
            break;
    }
    attribute.frame = CGRectMake(x, y, self.itemSize.width, self.itemSize.height);
    return attribute;
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    if (self.collectionView == nil) {
        return nil;
    }
    
    NSMutableArray *attributes = [self attributes:rect];
    
    CGFloat scale , offset , deno;
    
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionHorizontal: {
            CGFloat centerX = (self.collectionView.contentOffset.x + 0.5 * self.collectionView.bounds.size.width);
            for (UICollectionViewLayoutAttributes *attribute in attributes) {
                offset = fabs(attribute.center.x - centerX);
                deno = self.itemSize.width + self.spacing;
                
                if (offset < deno) {
                    scale = 1 + (1 - offset / deno) * (self.scale - 1);
                    attribute.transform = CGAffineTransformMakeScale(scale, scale);
                    attribute.zIndex = 1;
                }
            }
        }
            break;
        case UICollectionViewScrollDirectionVertical: {
            CGFloat centerY = (self.collectionView.contentOffset.y + 0.5 * self.collectionView.bounds.size.height);
            for (UICollectionViewLayoutAttributes *attribute in attributes) {
                offset = fabs(attribute.center.y - centerY);
                deno = self.itemSize.height + self.spacing;
                
                if (offset < deno) {
                    scale = 1 + (1 - offset / deno) * (self.scale - 1);
                    attribute.transform = CGAffineTransformMakeScale(scale, scale);
                    attribute.zIndex = 1;
                }
            }
        }
        default:
            break;
    }
    
    return attributes;
}


/**
 控制控制最后UICollectionView的最后去哪里，我们这里需要做的吸附效果的逻辑代码就需要在这里完成。

 @param proposedContentOffset 原本UICollectionView停止滚动那一刻的位置
 @param velocity 滚动速度
 @return UICollectionView停止滚动那一刻的位置
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    if (self.collectionView == nil) {
        return proposedContentOffset;
    }
    
    CGRect rect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *attributes = [self layoutAttributesForElementsInRect:rect];
    
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionHorizontal: {
            CGFloat centerX = proposedContentOffset.x + 0.5 * self.collectionView.bounds.size.width;
            CGFloat minOffSetX = MAXFLOAT;
            
            for (UICollectionViewLayoutAttributes *attribute in attributes) {
                CGFloat offSetX = attribute.center.x - centerX;
                if (fabs(offSetX) < fabs(minOffSetX)) {
                    minOffSetX = offSetX;
                }
            }
            return CGPointMake(proposedContentOffset.x + minOffSetX, proposedContentOffset.y);
            
        }
        case UICollectionViewScrollDirectionVertical: {
            CGFloat centerY = proposedContentOffset.y + 0.5 * self.collectionView.bounds.size.height;
            CGFloat minOffsetY = MAXFLOAT;
            
            for (UICollectionViewLayoutAttributes *attribute in attributes) {
                CGFloat offSetY = attribute.center.y - centerY;
                if (fabs(offSetY) < fabs(minOffsetY)) {
                    minOffsetY = offSetY;
                }
            }
            return CGPointMake(proposedContentOffset.x, proposedContentOffset.y + minOffsetY);
        }
            break;
            
        default:
            break;
    }
    
}


- (NSMutableArray *)attributes:(CGRect)rect {
    if (self.collectionView == nil) {
        return [NSMutableArray array];
    }
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger preIndex , latIndex;
    
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionHorizontal:
            preIndex = (rect.origin.x - self.edgeInset.left) / (self.itemSize.width + self.spacing);
            latIndex = (CGRectGetMaxX(rect) - self.edgeInset.left) / (self.itemSize.width + self.spacing);
            break;
            
        case UICollectionViewScrollDirectionVertical:
            preIndex = (rect.origin.y - self.edgeInset.top) / (self.itemSize.height + self.spacing);
            latIndex = (CGRectGetMaxY(rect) - self.edgeInset.top) / (self.itemSize.height + self.spacing);
        default:
            break;
    }
    
    preIndex = preIndex <0 ? 0 : preIndex;
    preIndex = preIndex >= itemCount ? itemCount - 1 : preIndex;
    latIndex = latIndex >= itemCount ? itemCount - 1 :latIndex;
    
    [self.rectAttributes removeAllObjects];
    
    for (NSInteger i = preIndex; i <= latIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        //CGRectIntersectsRect 判断 两个 rect  是否相等
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [self.rectAttributes addObject:attribute];
        }
    }
    return self.rectAttributes;
}



@end
