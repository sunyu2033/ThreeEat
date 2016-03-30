//
//  LNGood.h
//  WaterfallFlowDemo
//
//  Created by Lining on 15/5/3.
//  Copyright (c) 2015年 Lining. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNGood : SYMainModel
@property (nonatomic, assign) CGFloat h;                    // 图片高
@property (nonatomic, assign) CGFloat w;                    // 图片宽
@property (nonatomic, strong) NSString *img;                // 图片地址
@property (nonatomic, strong) NSString *title;              // 菜谱名称
@property (nonatomic, strong) NSString *discribe;           // 菜谱描述
@property (nonatomic, strong) NSString *admireNum;          // 点赞个数
@property (nonatomic, strong) NSString *isAdmire;           // 点赞
@property (nonatomic, strong) NSString *collectionNum;      // 收藏数
@property (nonatomic, strong) NSString *isCollection;       // 收藏
@property (nonatomic, assign) CGFloat contentHeight;        // 内容高度（除图片以外的高度）

+ (instancetype)goodWithDict:(NSDictionary *)dict atIndex:(NSUInteger)index; // 字典转模型
+ (NSArray *)goodsWithArray:(NSArray *)goodsArray; // 根据索引返回商品数组

- (void) connectToAPI:(NSString *)url parameters:(NSDictionary *)parameters;
@end
