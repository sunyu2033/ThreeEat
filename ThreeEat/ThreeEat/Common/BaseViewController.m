//
//  BaseViewController.m
//  JTB2C
//
//  Created by wtfan on 8/4/13.
//
//

#import "BaseViewController.h"
#import "HexStringToColor.h"
#import "ShowHUDTool.h"
/**
 UINavigationBar的类别
 实现对系统按钮样式的更改
 */
@interface UINavigationBar (UINavigationBarImage)
@end

@implementation UINavigationBar (UINavigationBarImage)
- (void)drawRect:(CGRect)rect {
	UIImage *image = [UIImage imageNamed:@"Titlebar.png"];
	assert(image!=nil);
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, image.size.height)];
}
@end

@interface BaseViewController ()

@end

@implementation BaseViewController
-(void)dealloc{
    self.loadingView = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isShowTabbar = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setTabBar];
}

- (void)setTabBar {
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setFrame:CGRectMake(0, 10, 22, 22)];
    [returnButton setImage:[UIImage imageNamed:@"nav_return"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    
    if (self!=[self.navigationController.viewControllers objectAtIndex:0]) {
        
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:returnButton];
        self.navigationItem.leftBarButtonItem = leftBarButton;
        self.tabBarController.tabBar.hidden = YES;
    }else{
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [HexStringToColor colorWithHexString:@"eeeeee"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = title;
    [label sizeToFit];
}

-(void)setLeftNavigationItemWithCustomView:(UIView*)cusView{
    UIBarButtonItem *m_buttonItem = [[UIBarButtonItem alloc] initWithCustomView:cusView];
    self.navigationItem.leftBarButtonItem = m_buttonItem;
}

-(void)setRightNavigationItemWithCustomView:(UIView*)cusView{
    UIBarButtonItem *m_buttonItem = [[UIBarButtonItem alloc] initWithCustomView:cusView];
    self.navigationItem.rightBarButtonItem = m_buttonItem;
}

#pragma mark -
#pragma mark Loading View
-(void)startLoading {
    [ShowHUDTool showHUDWithLoadingWithTitle:@"数据加载中" withView:self.view animated:YES];
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    if (self.loadingView==nil) {
//        // 初始化风火轮
//        MBProgressHUD* l_hud = [[MBProgressHUD alloc] init];
//        self.loadingView = l_hud;
//        self.loadingView.labelText = @"加载中...";
//        self.loadingView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0f, [UIScreen mainScreen].bounds.size.height/2.0f - 54.0f);
//        [self.view addSubview:self.loadingView];
//        [self.view bringSubviewToFront:self.loadingView];
//    }else{
//        
//    }
//    [self.loadingView show:YES];
}

-(void)stopLoading{
    
    [ShowHUDTool hiddenHUDLoadingForView:self.view animated:YES];
//	if (self.loadingView!=nil) {
//        [self.loadingView removeFromSuperview];
//        self.loadingView = nil;
//    }
}

- (void)endEdit
{
    [self.view endEditing:YES];
}
@end
