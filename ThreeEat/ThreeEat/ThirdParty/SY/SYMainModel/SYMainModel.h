//
//  SYMainModel.h
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/26.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
@class SYMainModel;

@protocol SYMainModelDelegate <NSObject>

//
- (void)didFinishedConnection:(SYMainModel *)model data:(NSDictionary *)data;
- (void)didFailConnection:(SYMainModel *)model error:(NSError *)error;

@end

@interface SYMainModel : NSObject

@property (nonatomic, assign) id<SYMainModelDelegate> delegate;

- (void)SYConnectToAPI:(NSString *)url parameters:(NSDictionary *)parameters model:(SYMainModel *)model;

- (void)SYUploadImageToAPI:(NSString *)url
                parameters:(NSDictionary *)parameters
                 imageData:(NSData *)imageData
                 imageName:(NSString *)imageName
                     model:(SYMainModel *)model;
@end
