//
//  SYShoppingList.h
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/18.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYShoppingList : NSObject

@property (nonatomic, strong) NSString *sid;                // id
@property (nonatomic, strong) NSString *img;                // img
@property (nonatomic, strong) NSString *title;              // 菜谱名称
@property (nonatomic, strong) NSString *ctime;              // 添加时间

+ (instancetype)shoppingListWithDict:(NSDictionary *)dict;
+ (NSArray *)shoppingListsWithArray:(NSArray *)shoppingListsArray;

@end
