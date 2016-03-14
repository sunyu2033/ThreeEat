//
//  TextFieldVerified.m
//  HappyWork
//
//  Created by WuJiaqi on 15/7/15.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import "TextFieldVerified.h"
#import "Common.h"

@implementation TextFieldVerified

// 共享的单例对象
+ (TextFieldVerified *)sharedService {
    static TextFieldVerified *_sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [[self alloc] init];
    });
    
    return _sharedService;
}

- (NSString *)verifiedRegisterInfo:(NSArray *)registerInfo {
    
    NSString *isCanRegister = @"";
    
    if (![[Common sharedService] isBlankString:registerInfo[0]] && ![[Common sharedService] isBlankString:registerInfo[1]] && ![[Common sharedService] isBlankString:registerInfo[2]]) {
        
        if ([registerInfo[1] isEqualToString:registerInfo[2]]) {
            
            if ([self verifiedUsername:registerInfo[0]]) {
                
                if ([self verifiedPassword:registerInfo[1]]) {
                    
                    isCanRegister = @"true";
                } else {
                    
                    isCanRegister = @"密码格式不正确";
                }
            } else {
                
                isCanRegister = @"手机号码或邮箱不正确";
            }
        } else {
            
            isCanRegister = @"两次密码不相同";
        }
    } else {
        
        isCanRegister = @"账号或密码不能为空";
    }
    return isCanRegister;
}

- (NSString *)verifiedRegisterHrInfo:(NSArray *)registerInfo {
    
    NSString *isCanRegister = @"false";
    
    if ([self verifiedUsername:registerInfo[0]]) {
        
        if ([self verifiedPassword:registerInfo[1]]) {
            
            if ([registerInfo[1] isEqualToString:registerInfo[2]]) {
                isCanRegister = @"true";
            } else {
                isCanRegister = @"密码不相同";
            }
        } else {
            isCanRegister = @"密码最少6位";
        }
    } else {
        isCanRegister = @"请用正确的邮箱或手机号码注册";
    }
    
    return isCanRegister;
}

//检查用户名是否为手机或邮箱
- (BOOL) verifiedUsername:(NSString *)username {
    
    return [self validateEmail:username] || [self validateMobile:username];
}

//检查密码长度
- (BOOL) verifiedPassword:(NSString *)password {
    
    BOOL isPasswordOk = false;
    if ([password length]>=6 && [password length]<=20) {
        isPasswordOk = true;
    }
    return isPasswordOk;
}

//邮箱验证
- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

//手机号码验证
- (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以1打头、11位
    NSString *phoneRegex =@"^1\\d{10}$";
    NSPredicate *phoneTest =[NSPredicate predicateWithFormat:@"SELF MATCHES%@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


@end
