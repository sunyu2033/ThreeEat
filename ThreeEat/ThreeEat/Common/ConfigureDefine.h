//
//  ConfigureDefine.h
//  HappyWork
//
//  Created by WuJiaqi on 15/3/20.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#ifndef HappyWork_ConfigureDefine_h
#define HappyWork_ConfigureDefine_h

#define FONTWITHSIZE(frontSize) [UIFont systemFontOfSize:frontSize] //字体设置

#define IS_IPHONE_FIVE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136),[[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334),[[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960),[[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus CGSizeEqualToSize([UIScreen mainScreen].bounds.size,CGSizeMake(414, 736))

//背景色
#define BACKGROUPCOLOR [UIColor colorWithRed:223.f/255.f green:223.f/255.f blue:223.f/255.f alpha:1]

//系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//ios7
#define SYSTEM_iOS7  [[[UIDevice currentDevice] systemVersion] floatValue]>=7.0 && [[[UIDevice currentDevice] systemVersion] floatValue]<8.0

//iOS 7,8 statusbar问题兼容处理
#define kIOS7StatusbarOffSet ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? 20.0f : 0.0f)

//ios8
#define SYSTEM_IOS8 [[[UIDevice currentDevice] systemVersion] floatValue]>=8.0

//手机屏幕适配  4
#define IS_IPHONE_FOUR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,960),[[UIScreen mainScreen] currentMode].size) : NO)

//5S
#define IS_IPHONE_FIVE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136),[[UIScreen mainScreen] currentMode].size) : NO)

//6
#define IS_IPHONE_SIX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334),[[UIScreen mainScreen] currentMode].size) : NO)

//6 Plus
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//屏幕宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([UIScreen mainScreen].bounds.size)

//导航栏的高度
#define navigationHight (self.navigationController.navigationBar.frame.size.height)

//设置界面行的高度
#define rowHight  46

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//设备id
#define DEVICE_ID   [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]

#define WINDOWS_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]

#endif
