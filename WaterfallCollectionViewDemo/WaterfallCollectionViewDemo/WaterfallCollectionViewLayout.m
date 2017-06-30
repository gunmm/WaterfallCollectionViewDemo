//
//  WaterfallCollectionViewLayout.m
//  ttt
//
//  Created by 闵哲 on 2017/6/29.
//  Copyright © 2017年 Gunmm. All rights reserved.
//

#import "WaterfallCollectionViewLayout.h"


//行距
static const CGFloat rowMargin = 10;
//列距
static const CGFloat columnMargin = 10;

static const UIEdgeInsets insets = {10, 10, 10, 10};

//列数
static const int columns = 3;

@interface WaterfallCollectionViewLayout()

//每一列的最大Y值
@property (nonatomic, strong) NSMutableArray *columnsMaxYarray;

//存放所有cell的布局属性
@property (nonatomic, strong) NSMutableArray *cellAttrisArray;

@end

@implementation WaterfallCollectionViewLayout

//懒加载
- (NSMutableArray *)columnsMaxYarray {
    if (!_columnsMaxYarray) {
        _columnsMaxYarray = [NSMutableArray array];
    }
    return _columnsMaxYarray;
}
- (NSMutableArray *)cellAttrisArray {
    if (!_cellAttrisArray) {
        _cellAttrisArray = [NSMutableArray array];
    }
    return _cellAttrisArray;
}


//collectionview的内容尺寸
- (CGSize)collectionViewContentSize {
    CGFloat maxY = [self.columnsMaxYarray[0] doubleValue];
    for (int i = 0; i < self.columnsMaxYarray.count; i++) {
        CGFloat columnY = [self.columnsMaxYarray[i] doubleValue];
        if (maxY < columnY) {
            maxY = columnY;
        }
    }
    return CGSizeMake(10, maxY + insets.bottom);
}


- (void)prepareLayout {
    [super prepareLayout];
    
    //重置每一列的最大Y值
    [self.columnsMaxYarray removeAllObjects];
    for (int i = 0; i < columns; i++) {
        [self.columnsMaxYarray addObject:@(insets.top)];
    }
    
    //计算所有cell的布局属性
    [self.cellAttrisArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.cellAttrisArray addObject:attributes];
    }
}


//返回所有元素的布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.cellAttrisArray;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //水平方向总间距
    CGFloat xMargin = insets.left + insets.right + (columns - 1)*columnMargin;
    //cell的宽度
    CGFloat w = (_totalWidth - xMargin)/columns;
    
    //cell?的高度
    CGFloat h = 50 + arc4random_uniform(150);
    
    //找最短的列号  和高度值
    CGFloat minY = [self.columnsMaxYarray[0] doubleValue];
    NSInteger minColumn = 0;
    for (int i = 0; i < self.columnsMaxYarray.count; i++) {
        CGFloat columnMaxY = [self.columnsMaxYarray[i] doubleValue];
        
        if (minY > columnMaxY) {
            minY = columnMaxY;
            minColumn = i;
        }
    }
   
   //cell的x值
    CGFloat x = insets.left + minColumn * (w + columnMargin);
    //cell的y值
    CGFloat y = minY + rowMargin;
    
    //cell的frame
    attribute.frame = CGRectMake(x, y, w, h);
    
    self.columnsMaxYarray[minColumn] = @(CGRectGetMaxY(attribute.frame));
    
    return attribute;
}



@end
