//
//  SYInfo.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/17.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import "SYInfo.h"

@implementation SYInfo

/**
 *  字典转模型
 */
+ (instancetype)infoWithDict:(NSDictionary *)dict
{
    SYInfo *info = [[self alloc] init];
    [info setValuesForKeysWithDictionary:dict];
    return info;
}

@end
