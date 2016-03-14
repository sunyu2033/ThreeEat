//
//  Common.h
//  HappyWork
//
//  Created by WuJiaqi on 15/3/24.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"

typedef void (^locationBlock)(NSString *lng, NSString *lat, NSString *cityName);

@interface Common : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;                                     //获取位置
    CLLocation        *checkinLocation;                                     //保存获取到的位置信息
    
    //获取经纬度参数
    NSString *lngStr;
    NSString *latStr;
    CLPlacemark *placemark;
}

+ (Common *)sharedService;

//@property (nonatomic,copy)    NSString *lngStr;
//@property (nonatomic,copy)    NSString *latStr;
@property (nonatomic, retain) MBProgressHUD* loadingView;
@property (nonatomic,copy)    locationBlock  myBlock;                       //只能是copy类型

- (void)returnAction:(UINavigationController *)navigationController;        //pop返回

- (void)returnToRootViewAction:(UIViewController *)viewController;

- (void)fixNavigationBar:(UIViewController *)viewController;                //修正navigationBar

- (NSString *)stringFromTimestamp:(NSString *)timestamp;                    //返回天数

- (NSString *) timeStringFromNow:(NSString *)timestamp;                     //指定时间与当前时间相差大约多久

- (NSString*)formatDate:(NSDate *)date withFormat:(NSString *)formatString; //转换nsdate为字符串

//转换字符串为nsdate
-(NSDate*) convertDateFromString:(NSString*)dateString withFormatter:(NSString *)formatterString;

- (NSString *)stringFromTimestamp:(NSString *)timestamp
                 withFormat:(NSString *)dateFormat;                         //时间戮转字符串

- (BOOL)isEnableLocationManager;                                            //是否已启用定位
- (void)getLocaltion;                                                       //获取位置的方法

//移动view
- (void)moveViewEvent:(UIView *)view withFrame:(CGRect)Rect duration:(NSTimeInterval)duration;

//取得label的自适应宽高
- (CGSize)getLableSize:(UIFont *)font withString:(NSString *)string withCGSize:(CGSize)size;

//隐藏返回按钮上面的文字
- (void)hideWordsInReturnButton:(UIViewController *)controller;

//当push时隐藏Tabbar
- (void)hideTabbarWhenPushed:(UIViewController *)viewController;

//拨打电话
- (void)makeCall:(UIViewController *)viewController withTelephone:(NSString *)telephoneNumber;

//去除searchBar自带的背景
- (void)removeBackGroundColorFromSearchBar:(UISearchBar *)searchBar;

//判断字符串是否为空字符
- (BOOL)isBlankString:(NSString *)string;

//检测密码长度
- (BOOL)checkPassLenght:(NSString *)password;

- (NSString *)timeStringWithNow;

- (UIImage *)imageFromTextImageMix:(UIImage *)oldImage andCGSize:(CGSize)itemSize;

- (UIViewController *)getCurrentVC;

//设置不同颜色的文字
- (NSMutableAttributedString *)getAttributeText:(NSString *)string withColor:(UIColor *)color andSeperateString:(NSString *)seperateStr;

-(BOOL)IsChinese:(NSString *)str;

//判断文件是否存在
- (BOOL)isFileExist:(NSString *)fileName;

//创建文件
- (BOOL)createFile:(NSString *)fileName;

@end
