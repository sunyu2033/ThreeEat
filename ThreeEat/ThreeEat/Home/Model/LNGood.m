//
//  LNGood.m
//  WaterfallFlowDemo
//
//  Created by Lining on 15/5/3.
//  Copyright (c) 2015年 Lining. All rights reserved.
//

#define cellWidth   ([UIScreen mainScreen].bounds.size.width-10)/2

#import "LNGood.h"

@implementation LNGood
/**
 *  字典转模型
 */
+ (instancetype)goodWithDict:(NSDictionary *)dict atIndex:(NSUInteger)index {
    CGFloat height;
    LNGood *good = [[self alloc] init];
    [good setValuesForKeysWithDictionary:dict];
    good.w = cellWidth;
    
    switch (index%5) {
        case 1:
            height = cellWidth*1.3;
            break;
        case 2:
            height = cellWidth*1.1;
            break;
        case 3:
            height = cellWidth*1.7;
            break;
        case 4:
            height = cellWidth*1.4;
            break;
        default:
            height = cellWidth*1.5;
            break;
    }
    good.h = height;
    
    return good;
}

/**
 *  根据索引返回商品数组
 */
+ (NSArray *)goodsWithArray:(NSArray *)goodsArray {
    
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:goodsArray.count];
    
    [goodsArray enumerateObjectsUsingBlock: ^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        
        [tmpArray addObject:[self goodWithDict:dict atIndex:idx]];
    }];
    return tmpArray.copy;
}
@end
