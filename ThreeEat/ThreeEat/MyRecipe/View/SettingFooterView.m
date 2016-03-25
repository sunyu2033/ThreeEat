//
//  SettingFooterView.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/22.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

#import "SettingFooterView.h"

@implementation SettingFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self buildView];
    }
    return self;
}

- (void)buildView {

    SYButton *loginBtn = [SYButton buttonWithType:UIButtonTypeCustom];
//    [loginBtn setFrame:CGRectMake(15, 60, kWidth-30, 44)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[HexStringToColor colorWithHexString:@"e83650"]];
    [loginBtn.layer setCornerRadius:6];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
    }];
    
    SYButton *registerBtn = [SYButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setFrame:CGRectMake(CGRectGetMinX(loginBtn.frame), CGRectGetMaxY(loginBtn.frame)+20, CGRectGetWidth(loginBtn.frame), CGRectGetHeight(loginBtn.frame))];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:[HexStringToColor colorWithHexString:@"e83650"]];
    [registerBtn.layer setCornerRadius:6];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(loginBtn);
        make.top.equalTo(loginBtn.mas_bottom).offset(20);
    }];
}

- (void)loginAction
{
    if ([_delegate respondsToSelector:@selector(pushToLoginViewController:)]) {
        [_delegate pushToLoginViewController:self];
    }
}

- (void)registerAction
{
    if ([_delegate respondsToSelector:@selector(pushToRegisterViewController:)]) {
        [_delegate pushToRegisterViewController:self];
    }
}

@end
