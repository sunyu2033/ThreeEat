//
//  SYInfo.h
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/17.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYInfo : NSObject

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *levelName;

+ (instancetype)infoWithDict:(NSDictionary *)dict;

@end
