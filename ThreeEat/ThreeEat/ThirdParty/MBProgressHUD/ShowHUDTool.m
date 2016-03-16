//
//  ShowHUDTool.m
//  MvBox
//
//  Created by 刘一一 on 14-4-1.
//  Copyright (c) 2014年 51mvbox. All rights reserved.
//

#define  APPLEGATE ((AppDelegate*)([UIApplication sharedApplication].delegate))

#import "ShowHUDTool.h"
#import "MBProgressHUD.h"

@implementation ShowHUDTool


+ (void)showHUDImageWithTitle:(NSString *)title
{
   
    AppDelegate *appDelegate =  APPLEGATE;
    
    MBProgressHUD *myHud = [[MBProgressHUD alloc]initWithWindow:appDelegate.window];
    [appDelegate.window addSubview:myHud];
    
    myHud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    myHud.mode =  MBProgressHUDModeCustomView;
    myHud.labelText = title;
    
    
    [myHud showAnimated:YES whileExecutingBlock:^{
        sleep(DefaultAnimationTime);
    } completionBlock:^{
        [myHud removeFromSuperview];
       
    }];
}

+ (void)showFaildImageWithTitle:(NSString *)title
{
    
    AppDelegate *appDelegate =  APPLEGATE;
    
    MBProgressHUD *myHud = [[MBProgressHUD alloc]initWithWindow:appDelegate.window];
    [appDelegate.window addSubview:myHud];
    
    myHud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37-delete"]];
    myHud.mode =  MBProgressHUDModeCustomView;
    myHud.labelText = title;
    
    
    [myHud showAnimated:YES whileExecutingBlock:^{
        sleep(DefaultAnimationTime);
    } completionBlock:^{
        [myHud removeFromSuperview];
        
    }];
}
+(void)showHUDWithImgWithTitle:(NSString *)title
{
    AppDelegate *appDelegate =  APPLEGATE;
    
    [ShowHUDTool hiddenAllHUDForView:appDelegate.window animated:NO];

    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:appDelegate.window];
    [appDelegate.window addSubview:hud];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(DefaultAnimationTime);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
    
}

+(void)showHUDWithImgWithTitle:(NSString *)title withView:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    

    
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(DefaultAnimationTime);
    } completionBlock:^{
        [hud removeFromSuperview];
        
    }];
    
}

+(MBProgressHUD *)showHUDWithLoadingWithTitle:(NSString *)title withView:(UIView *)view animated:(BOOL)animated
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];

//    hud.dimBackground = YES;
    hud.labelText = title;
    
    return hud;
    
}

+(void)hiddenHUDLoadingForView:(UIView *)view animated:(BOOL)animated
{
    [MBProgressHUD hideHUDForView:view animated:animated];
}

+(void)hiddenAllHUDForView:(UIView *)view animated:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:view animated:animated];
}


@end
