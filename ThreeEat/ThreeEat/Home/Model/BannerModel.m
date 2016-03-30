//
//  BannerModel.m
//  ThreeEat
//
//  Created by Samsun on 16/3/14.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

+ (NSMutableArray *)bannerModelWithArray:(NSArray *)info
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<info.count; i++) {
        BannerModel *model = [[self alloc] initWithDict:info[i]];
        [array addObject:model];
    }
    return array;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void) connectToAPI:(NSString *)url parameters:(NSDictionary *)parameters {
    
    [self SYConnectToAPI:url parameters:parameters model:self];
}

@end
