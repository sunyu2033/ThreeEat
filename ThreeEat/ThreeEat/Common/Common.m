//
//  Common.m
//  HappyWork
//
//  Created by WuJiaqi on 15/3/24.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#define maxScreenWidth [UIScreen mainScreen].bounds.size.width
#define maxScreenHeight [UIScreen mainScreen].bounds.size.height
#define  CCLastLongitude @"CCLastLongitude"
#define  CCLastLatitude  @"CCLastLatitude"
#define  CCLastCity      @"CCLastCity"
#define  CCLastAddress   @"CCLastAddress"

#import "Common.h"
#import "ConfigureDefine.h"
//#import "DefaultsNames.h"

@implementation Common

//@synthesize latStr,lngStr;

// 共享的单例对象
+ (Common *)sharedService {
    static Common *_sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [[self alloc] init];
    });
    
    return _sharedService;
}

//适配ios7的NavigationBar位置问题
- (void)fixNavigationBar:(UIViewController *)viewController
{
    if (SYSTEM_iOS7) {
        viewController.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

//时间戮转字符串
- (NSString *)stringFromTimestamp:(NSString *)timestamp withFormat:(NSString *)dateFormat
{
    NSDate *confromTimesp;
    if (timestamp!=nil) {
        confromTimesp = [[NSDate alloc] initWithTimeIntervalSince1970:[timestamp intValue]];
    }else{
        confromTimesp = [NSDate date];
    }
    
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc]init];
    [date_formatter setDateFormat:dateFormat];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [date_formatter setTimeZone:timeZone];
    
    NSString *dateString = [date_formatter stringFromDate:confromTimesp];
    
    return dateString;
}

//转换nsdate为字符串
- (NSString*)formatDate:(NSDate *)date withFormat:(NSString *)formatString
{
    // A convenience method that formats the date in Month-Year format
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatString;
    return [formatter stringFromDate:date];
}

//转换字符串为nsdate
-(NSDate*) convertDateFromString:(NSString*)dateString withFormatter:(NSString *)formatterString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterString];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *date=[formatter dateFromString:dateString];
    
    return date;
}

//指定时间与当前时间差多少天－－返回天数
- (NSString *)stringFromTimestamp:(NSString *)timestamp
{
    
    int timesp = [self secondStringFromTimestamp:timestamp];
    NSString *dayNum = [NSString stringWithFormat:@"%d", timesp/(60*60*24)];

    return dayNum;
}

//指定时间与当前时间差多少天－－返回秒数
- (int)secondStringFromTimestamp:(NSString *)timestamp
{
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[timestamp intValue]];
    NSTimeInterval secondNum = [[NSDate date] timeIntervalSinceDate:date];
    
    return (int)secondNum;
}

//指定时间与当前时间相差大约多久
- (NSString *) timeStringFromNow:(NSString *)timestamp {
    
    NSString *string = @"";
    
    int secondTime = [self secondStringFromTimestamp:timestamp];
    int minuteTime = secondTime/60;
    int hourTime = minuteTime/60;
    int dayTime = hourTime/24;
    int monthTime = dayTime/30;
    int yearTime = monthTime/12;
    
    if (secondTime<60) {
        
        string = [NSString stringWithFormat:@"%d秒前", secondTime];
    }else if (minuteTime>=1 && minuteTime<60) {
        
        string = [NSString stringWithFormat:@"%d分钟前", minuteTime];
    }else if (hourTime>=1 && hourTime<24) {
        
        string = [NSString stringWithFormat:@"%d个小时前", hourTime];
    }else if (dayTime>=1 && dayTime<30) {
        
        string = [NSString stringWithFormat:@"%d天前", dayTime];
    }else if (monthTime>=1 && monthTime<12) {
        
        string = [NSString stringWithFormat:@"%d个月前", monthTime];
    }else if (yearTime>=1) {
        
        string = [NSString stringWithFormat:@"%d年前", yearTime];
    }
    
    return string;
}

//是否已启用定位
- (BOOL)isEnableLocationManager {

//    BOOL isEnable = [CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied ? YES : NO;
    
//    if ([CLLocationManager locationServicesEnabled] &&
//        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized
//         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
//            //定位功能可用，开始定位
//            NSLog(@"定位可用");
//        }
//    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || ![CLLocationManager locationServicesEnabled]){
//        NSLog(@"定位功能不可用，提示用户或忽略");
//    }
    
    if (([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied)) {
        NSLog(@"定位可用");
    }else{
        NSLog(@"定位不可用");
    }
    return ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied);
}

////启用定位，获取经纬度
-(void) getLocaltion {
    
    //判断用户是否开启了定位
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"Starting CllocationManager");
        locationManager.distanceFilter = 5.0;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        if (SYSTEM_IOS8) {
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
    }else{
        NSLog(@"定位未开启，暂不能获取数据");
    }
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
//    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks,NSError *error) {
        NSLog(@"placemarksplacemarks:%@", placemarks);
         if (placemarks.count > 0) {
             placemark = [placemarks objectAtIndex:0];
             
             NSLog(@"country:%@",placemark.country);
             NSLog(@"postalCode:%@",placemark.postalCode);
             NSLog(@"ISOcountryCode%@",placemark.ISOcountryCode);
             NSLog(@"administrativeArea:%@",placemark.administrativeArea);
             NSLog(@"subAdministrativeArea:%@",placemark.subAdministrativeArea);
             NSLog(@"locality:%@",placemark.locality);
             NSLog(@"subLocality:%@",placemark.subLocality);
             NSLog(@"thoroughfare:%@",placemark.thoroughfare);
             NSLog(@"subThoroughfare:%@",placemark.subThoroughfare);
             NSLog(@"省市地址:administrativeArea______%@",placemark.administrativeArea);
             
             NSString *_lastAddress = [NSString stringWithFormat:@"%@%@%@%@%@%@",placemark.country,placemark.administrativeArea,placemark.locality,placemark.subLocality,placemark.thoroughfare,placemark.subThoroughfare];//详细地址
             NSLog(@"详细地址:______%@", _lastAddress);
         }
    
        NSLog(@"经纬度：%f--%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
        latStr = [NSString stringWithFormat:@"%lf", newLocation.coordinate.latitude];
        lngStr = [NSString stringWithFormat:@"%lf", newLocation.coordinate.longitude];
        
        if (latStr.length!=0 && lngStr.length!=0) {
            self.myBlock(lngStr,latStr, placemark.administrativeArea);
        }
        [manager stopUpdatingLocation];
    }];
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"ioyuityi%@", error);
    //Error Domain=kCLErrorDomain Code=0 "The operation couldn’t be completed. (kCLErrorDomain error 0.)"
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"hgjghrtwet－－%@",error);
}

//页面返回pop
- (void)returnAction:(UINavigationController *)navigationController {
    [navigationController popViewControllerAnimated:YES];
}

//页面返回第一层
- (void)returnToRootViewAction:(UIViewController *)viewController {
    [viewController.navigationController popToRootViewControllerAnimated:YES];
}

//移动view
- (void)moveViewEvent:(UIView *)view withFrame:(CGRect)Rect duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration
                     animations:^{
                         view.frame = (CGRect)Rect;
                     }completion:nil];
}

//取得label的自适应宽高
- (CGSize)getLableSize:(UIFont *)font withString:(NSString *)string withCGSize:(CGSize)size
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font ,NSFontAttributeName,nil];
    CGSize labelSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
    
    return labelSize;
}

//隐藏返回按钮上面的文字
- (void)hideWordsInReturnButton:(UIViewController *)controller
{
    [controller.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:controller action:nil];
    [controller.navigationItem setBackBarButtonItem:backBtn];
}

//当push时隐藏Tabbar
- (void)hideTabbarWhenPushed:(UIViewController *)viewController
{
    [viewController setHidesBottomBarWhenPushed:YES];
}

//打电话
- (void)makeCall:(UIViewController *)viewController withTelephone:(NSString *)telephoneNumber
{
    NSString *telephoneString  =[NSString stringWithFormat:@"tel://%@", telephoneNumber];
    UIWebView*callWebview = [[UIWebView alloc] init];
    NSURL *telURL = [NSURL URLWithString:telephoneString];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [viewController.view addSubview:callWebview];
}

//去除searchBar自带的背景
- (void)removeBackGroundColorFromSearchBar:(UISearchBar *)searchBar
{
    for (UIView *view in searchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
        
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
}

//判断字符串是否为空字符
- (BOOL)isBlankString:(NSString *)string
{
    
//    NSLog(@"stringstring:%@", string);
    
    if (string == nil || string == NULL) {
        
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
    }
    return NO;
}

//检测密码长度
- (BOOL) checkPassLenght:(NSString *)password
{
    
    if ([password length]<6 || [password length]>20) {
        
        NSLog(@"passwordpassword:%@", password);
        return NO;
    }else{
        
        return YES;
    }
}

- (NSTimeZone *)timeZoneWithShangHai {
    
    return [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
}

- (NSString *)timeStringWithNow {
    
    NSString *time = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    return time;
}

- (UIImage *)imageFromTextImageMix:(UIImage *)oldImage andCGSize:(CGSize)itemSize{
    
//    CGSize itemSize = CGSizeMake(30, 30);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [oldImage drawInRect:imageRect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

//图文混排上下居中
+(instancetype)buttonWithImage:(UIImage *)image
                         title:(NSString *)title
                        target:(id)target
                      selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [button.imageView setContentMode:UIViewContentModeCenter];
    //    UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    [button setImageEdgeInsets:UIEdgeInsetsMake(-10.0,
                                                0.0,
                                                0.0,
                                                -titleSize.width)];
    [button setImage:image forState:UIControlStateNormal];
    
    [button.titleLabel setContentMode:UIViewContentModeCenter];
    [button.titleLabel setBackgroundColor:[UIColor clearColor]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(60.0,
                                                -image.size.width,
                                                0.0,
                                                0.0)];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target
               action:selector
     forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

////设置不同颜色的文字：分割字符后面变色
//- (NSMutableAttributedString *) getAttributeText:(NSString *)string withColor:(UIColor *)color andSeperateString:(NSString *)seperateStr {
//    
//    NSRange range = [string rangeOfString:seperateStr];
//    NSInteger location =  range.location;
//    NSInteger length = [[string substringFromIndex:location+1] length];
//    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:string];
//    [attributeText addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(location+1, length)];
//
//    return attributeText;
//}

//设置不同颜色的文字：分割字符前面变色
- (NSMutableAttributedString *) getAttributeText:(NSString *)string withColor:(UIColor *)color andSeperateString:(NSString *)seperateStr {
    
    NSRange range = [string rangeOfString:seperateStr];
    NSInteger location =  range.location;
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeText addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, location+1)];
    
    return attributeText;
}

//判断是否有中文
-(BOOL)IsChinese:(NSString *)str {
    for(int i=0; i<[str length]; i++){
        int a = [str characterAtIndex:i];
        if(!(a > 0x4e00 && a < 0x9fff)) {
            return NO;
        }
    }
    return YES;
}

//文件管理
- (NSFileManager *) fileManager {
    
    return [NSFileManager defaultManager];
}

//文件路径
- (NSString *)filePath:(NSString *)fileName {
    
    //获取document路径,括号中属性为当前应用程序独享
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,      NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    //定义记录文件全名以及路径的字符串filePath
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    return filePath;
}

//判断文件是否存在
- (BOOL)isFileExist:(NSString *)fileName {

    NSFileManager *fileManager = [self fileManager];
    NSString *filePath = [self filePath:fileName];
    
    return [fileManager fileExistsAtPath:filePath];
}

//创建文件
- (BOOL)createFile:(NSString *)fileName {
    
    //如果第一次进入没有文件，我们就创建这个文件
    NSFileManager *fileManager = [self fileManager];
    NSString *filePath = [self filePath:fileName];

    return [fileManager createFileAtPath:filePath contents:nil attributes:nil];
}
@end
