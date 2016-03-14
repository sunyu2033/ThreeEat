//
//  HomeViewController.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/14.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerModel.h"
#import "AdView.h"
#import "BannerModel.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *imagesURL = @[
                           @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                           @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                           @"http://img14.360buyimg.com/n6/jfs/t2200/83/1603372575/63020/fd2c7af2/56ce60aaNdc53e003.jpg"
                           ];
    // 情景三：图片配文字(可选)
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"代码在使用过程中出现问题",
                        @"您可以发邮件到qzycoder@163.com",
                        ];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:imagesURL[0] forKey:@"bannerUrl"];
    [dic1 setObject:titles[0] forKey:@"bannerTitle"];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:imagesURL[1] forKey:@"bannerUrl"];
    [dic2 setObject:titles[1] forKey:@"bannerTitle"];
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:imagesURL[2] forKey:@"bannerUrl"];
    [dic3 setObject:titles[2] forKey:@"bannerTitle"];
    
    NSMutableArray *models = [NSMutableArray arrayWithObjects:dic1, dic2, dic3, nil];
    models = [BannerModel bannerModelWithArray:models];
    NSLog(@"models:%@", models);
    
    AdView *adView = [AdView adScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 172) modelArr:models imagePropertyName:@"bannerUrl" pageControlShowStyle:UIPageControlShowStyleCenter];
    [adView setAdTitlePropertyName:@"bannerTitle" withShowStyle:AdTitleShowStyleCenter];
    
    //    是否需要支持定时循环滚动，默认为YES
    //    adView.isNeedCycleRoll = YES;
    
    //    设置图片滚动时间,默认3s
    adView.adMoveTime = 5.0;
    
    //图片被点击后回调的方法
    adView.callBackForModel = ^(BannerModel *banner)
    {
        NSLog(@"%@--%@",banner.bannerTitle, banner.bannerUrl);
    };
    [self.view addSubview:adView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
