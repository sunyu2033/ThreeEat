//
//  BannerModel.m
//  ThreeEat
//
//  Created by Samsun on 16/3/14.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#define ConnectResultDataIsSuccess  @"true"

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

+ (NSDictionary) connectToAPI:(NSString *)url parameter:(NSDictionary *)parameters {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSDictionary dictionary];
        dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

@end
