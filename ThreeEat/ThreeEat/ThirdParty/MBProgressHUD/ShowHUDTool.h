//
//  ShowHUDTool.h
//  MvBox
//
//  Created by 刘一一 on 14-4-1.
//  Copyright (c) 2014年 51mvbox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "MJExtension.h"
@interface ShowHUDTool : NSObject
#define DefaultAnimationTime 1.5


+ (void)showHUDWithImgWithTitle:(NSString *)title;
+ (void)showHUDImageWithTitle:(NSString *)title;
+ (void)showHUDWithImgWithTitle:(NSString *)title withView:(UIView *)view;
+ (void)showFaildImageWithTitle:(NSString *)title;
+(MBProgressHUD *)showHUDWithLoadingWithTitle:(NSString *)title withView:(UIView *)view animated:(BOOL)animated;

//菊花loading
+ (void)hiddenHUDLoadingForView:(UIView *)view animated:(BOOL)animated;
+ (void)hiddenAllHUDForView:(UIView *)view animated:(BOOL)animated;


@end
