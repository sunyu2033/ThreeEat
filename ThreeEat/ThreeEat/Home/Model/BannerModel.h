//
//  BannerModel.h
//  ThreeEat
//
//  Created by Samsun on 16/3/14.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYMainModel.h"

@interface BannerModel : SYMainModel

@property (nonatomic, strong) NSString *bannerUrl;
@property (nonatomic, strong) NSString *bannerTitle;

+ (NSMutableArray *)bannerModelWithArray:(NSArray *)info;

//数据请求
- (void) connectToAPI:(NSString *)url parameters:(NSDictionary *)parameters;
@end
