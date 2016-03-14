//
//  TextFieldVerified.h
//  HappyWork
//
//  Created by WuJiaqi on 15/7/15.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextFieldVerified : NSObject

+ (TextFieldVerified *)sharedService;

//注册信息是否正确
//参数registerInfo:注册信息   0:账号    1:密码    2:确认密码
- (NSString *)verifiedRegisterInfo:(NSArray *)registerInfo;

- (NSString *)verifiedRegisterHrInfo:(NSArray *)registerInfo;

//用户名是否符合标准
- (BOOL) verifiedUsername:(NSString *)username;
@end
