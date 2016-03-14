//
//  TabbarView.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/14.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import "TabbarController.h"
#import "HomeViewController.h"
#import "MyRecipeViewController.h"
#import "ShoppingListViewController.h"
#import "HexStringToColor.h"

@implementation TabbarController

- (instancetype) init {
    
    self = [super init];
    if (self) {
        //设置tabBarController
        NSArray *tabbarTitles = @[@"首页", @"我的食谱", @"购物单"];
        NSArray *tabbarImages = @[@"home", @"myRecipe", @"shoppingList"];
        NSArray *tabbarSelectedImages=@[@"homeSelected",
                                       @"myRecipeSelected",
                                       @"shoppingListSelected"];
        NSArray *controllers = @[@"HomeViewController",
                                 @"MyRecipeViewController",
                                 @"ShoppingListViewController"];

        NSMutableArray *navs = [NSMutableArray array];
        for (int i=0; i<tabbarTitles.count; i++)
        {
            UIImage *image=[UIImage imageNamed:[tabbarImages objectAtIndex:i]];
            UIImage *selectedImage = [UIImage imageNamed:tabbarSelectedImages[i]];
            //声明这张图片用原图(别渲染)
            selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            Class controller = NSClassFromString(controllers[i]);
            UIViewController *vc = [[controller alloc] init];
            vc.title = tabbarTitles[i];
            vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:tabbarTitles[i] image:image selectedImage:selectedImage];
            
            UIImage *title_bg = [UIImage imageNamed:@"nav_background"];
            UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:vc];
            [navigationVC.navigationBar setBackgroundImage:title_bg forBarMetrics:UIBarMetricsDefault];
            [navs addObject:navigationVC];
        }
        self.viewControllers = [navs copy];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
