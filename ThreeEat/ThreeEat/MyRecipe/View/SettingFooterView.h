//
//  SettingFooterView.h
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/22.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingFooterView;

@protocol SettingFooterViewDelegate <NSObject>

- (void)pushToLoginViewController:(SettingFooterView *)view;
- (void)pushToRegisterViewController:(SettingFooterView *)view;

@end

@interface SettingFooterView : UIView

@property (nonatomic, assign) id<SettingFooterViewDelegate>delegate;

@end
