//
//  UICollectionViewWaterfallCell.h
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LNGood;
@class CHTCollectionViewWaterfallCell;

@protocol CHTCollectionViewWaterfallCellDelegate <NSObject>

- (void)addAdmire:(CHTCollectionViewWaterfallCell *)cell;

- (void)addCollection:(CHTCollectionViewWaterfallCell *)cell;

@end

@interface CHTCollectionViewWaterfallCell : UICollectionViewCell

@property (nonatomic, strong) id<CHTCollectionViewWaterfallCellDelegate>delegate;
@property (nonatomic, strong) LNGood *good;
@property (nonatomic, assign) NSInteger index;
+ (NSMutableArray *)getContentHeight:(NSArray *)goods;
@end
