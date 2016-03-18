//
//  SYShoppingList.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/18.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import "SYShoppingList.h"

@implementation SYShoppingList

/**
 *  字典转模型
 */
+ (instancetype)shoppingListWithDict:(NSDictionary *)dict {
    
    SYShoppingList *shoppingList = [[self alloc] init];
    [shoppingList setValuesForKeysWithDictionary:dict];
    
    return shoppingList;
}

/**
 *  根据索引返回商品数组
 */
+ (NSArray *)shoppingListsWithArray:(NSArray *)shoppingListsArray {
    
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:shoppingListsArray.count];
    
    [shoppingListsArray enumerateObjectsUsingBlock: ^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        
        [tmpArray addObject:[self shoppingListWithDict:dict]];
    }];
    return tmpArray.copy;
}
@end
