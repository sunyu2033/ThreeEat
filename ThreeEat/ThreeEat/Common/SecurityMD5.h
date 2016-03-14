//
//  SecurityUtil.h
//  SigBoat_XiangMei
//
//  Created by sigboat on 15/1/19.
//  Copyright (c) 2015年 sigboat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityMD5 : NSObject


#pragma mark - md5 加密
+(NSString *)md5:(NSString *)password;

@end
