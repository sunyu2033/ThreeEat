//
//  SYMainModel.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/26.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import "SYMainModel.h"

@implementation SYMainModel

//数据请求
- (void)SYConnectToAPI:(NSString *)url parameters:(NSDictionary *)parameters model:(SYMainModel *)model {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([self.delegate respondsToSelector:@selector(didFinishedConnection:data:)]) {
            [self.delegate didFinishedConnection:model data:data];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(didFailConnection:error:)]) {
            [self.delegate didFailConnection:model error:error];
        }
    }];
}

//单张图片上传
- (void)SYUploadImageToAPI:(NSString *)url
            parameters:(NSDictionary *)parameters
             imageData:(NSData *)imageData
             imageName:(NSString *)imageName
                 model:(SYMainModel *)model {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //申明请求的数据是json类型
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:imageName fileName:@"test.png" mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([self.delegate respondsToSelector:@selector(didFinishedConnection:data:)]) {
            [self.delegate didFinishedConnection:model data:data];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(didFailConnection:error:)]) {
            [self.delegate didFailConnection:model error:error];
        }
    }];

}

@end
