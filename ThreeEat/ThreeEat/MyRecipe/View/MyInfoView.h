//
//  MyInfoView.h
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/17.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYInfo.h"
@class MyInfoView;

@protocol MyInfoViewDelegate <NSObject>

- (void)pushToFavorViewController:(MyInfoView *)view;
- (void)pushToSettingViewController:(MyInfoView *)view;

@end

@interface MyInfoView : UIView

@property (nonatomic, assign) id<MyInfoViewDelegate> delegate;
@property (nonatomic, strong) SYInfo *info;

@end
