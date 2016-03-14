//
//  BaseViewController.h
//  JTB2C
//
//  Created by wtfan on 8/4/13.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController
@property (nonatomic, retain) MBProgressHUD* loadingView;
@property (nonatomic, assign) BOOL isShowTabbar;
-(void)setTitle:(NSString *)title;
-(void)setLeftNavigationItemWithCustomView:(UIView*)cusView;
-(void)setRightNavigationItemWithCustomView:(UIView*)cusView;
-(void)startLoading;
-(void)stopLoading;
- (void)endEdit;

-(void)onBack;
@end
