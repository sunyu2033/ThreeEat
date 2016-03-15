//
//  HomeViewController.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/14.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#define heightOfHeader    172

#import "HomeViewController.h"
#import "BannerModel.h"
#import "AdView.h"
#import "BannerModel.h"
#import "LNGood.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "CollectionHeader.h"

@interface HomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CHTCollectionViewDelegateWaterfallLayout>

// 商品列表数组
@property (nonatomic, strong) NSMutableArray *goodsList;
// 当前的数据索引
@property (nonatomic, assign) NSInteger index;
// 是否正在加载数据标记
@property (nonatomic, assign, getter=isLoading) BOOL loading;
// 瀑布流布局
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CollectionHeader *headerView;

@end

@implementation HomeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
    
    NSLog(@"SCREEN_HEIGHT1111:%f", SCREEN_HEIGHT);
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    
    NSLog(@"SCREEN_HEIGHT222:%f", SCREEN_HEIGHT);
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    CHTCollectionViewWaterfallLayout *flowLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
    flowLayout.minimumColumnSpacing = 8;
    flowLayout.minimumInteritemSpacing = 8;

    //collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-30-64) collectionViewLayout:flowLayout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.tag = 10101;
    _collectionView.backgroundColor = self.view.backgroundColor;                //GETColor(240, 240, 240, 1);
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.allowsMultipleSelection = NO;                    //默认为NO,是否可以多选
    _collectionView.scrollEnabled = YES;
    
    //注册
    [_collectionView registerClass:[CHTCollectionViewWaterfallCell class] forCellWithReuseIdentifier:@"CHTCollectionViewWaterfallCell"];
    
    //定义 section的  headerView
    //此处的identifier:@"HeaderView" 和 viewForSupplementaryElementOfKind 中的必须一样
    //还可以设置footer
    [_collectionView registerClass:[CollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
//    flowLayout.headerReferenceSize = CGSizeMake(200, heightOfHeader);
    [self.view addSubview:_collectionView];
    
    [self loadData];
}

/**
 *  加载数据
 */
- (void)loadData {
    
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setObject:@"193" forKey:@"h"];
    [dict1 setObject:@"290" forKey:@"w"];
    [dict1 setObject:@"http://xqproduct.xiangqu.com/FoYm07fprsGaSbbFYzAUXbAwMH09?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/1800x1200/" forKey:@"img"];
    [dict1 setObject:@"法式香草面包(Fougasse)配番茄干" forKey:@"title"];
    [dict1 setObject:@"甜点和烘烤食品" forKey:@"discribe"];
    [dict1 setObject:@"6,263" forKey:@"admireNum"];
    [dict1 setObject:@"1" forKey:@"isAdmire"];
    [dict1 setObject:@"21.3K" forKey:@"collectionNum"];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setObject:@"290" forKey:@"h"];
    [dict2 setObject:@"290" forKey:@"w"];
    [dict2 setObject:@"http://xqproduct.xiangqu.com/FhvU7uVm1ojzbtvPp3z66-MgxBH2?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/730x730/" forKey:@"img"];
    [dict2 setObject:@"速成巧克力布丁" forKey:@"title"];
    [dict2 setObject:@"快手甜品" forKey:@"discribe"];
    [dict2 setObject:@"21.3K" forKey:@"admireNum"];
    [dict2 setObject:@"0" forKey:@"isAdmire"];
    [dict2 setObject:@"6,298" forKey:@"collectionNum"];
    
    
    NSArray *array = [NSArray arrayWithObjects:dict1,dict2,dict2,dict2,
//                      dict2, dict2, dict1, dict2, dict2, dict1, dict2, dict2, dict1, dict2, dict2,
                      nil];
    
    NSArray *goods = [LNGood goodsWithArray:array];
    [self.goodsList addObjectsFromArray:goods];
    // 设置布局的属性
    // 刷新数据
    [self.collectionView reloadData];
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建可重用的cell
    CHTCollectionViewWaterfallCell *cell = (CHTCollectionViewWaterfallCell *)[collectionView
                                 dequeueReusableCellWithReuseIdentifier:@"CHTCollectionViewWaterfallCell"
                                 forIndexPath:indexPath];
    cell.good = self.goodsList[indexPath.item];
    return cell;
}

#pragma mark - FooterView
/**
 *  追加视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        [headerView setBackgroundColor:[UIColor redColor]];
        //广告轮播
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
        
        AdView *adView = [AdView adScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, heightOfHeader) modelArr:models imagePropertyName:@"bannerUrl" pageControlShowStyle:UIPageControlShowStyleCenter];
        [adView setAdTitlePropertyName:@"bannerTitle" withShowStyle:AdTitleShowStyleCenter];
        //    adView.isNeedCycleRoll = YES;     //    是否需要支持定时循环滚动，默认为YES
        adView.adMoveTime = 5.0;                //设置图片滚动时间,默认3s
        
        //图片被点击后回调的方法
        adView.callBackForModel = ^(BannerModel *banner) {
            NSLog(@"%@--%@",banner.bannerTitle, banner.bannerUrl);
        };
        [headerView addSubview:adView];
        
        reusableview = headerView;

    }else if (kind == UICollectionElementKindSectionFooter) {
        
    }
    return reusableview;
}

#pragma mark - UICollectionViewDelegate
//点击了某个collectionCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath:%ld", (long)indexPath.row);
}

#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    if (self.footerView == nil || self.isLoading) {
//        return;
//    }
    
//    if (self.footerView.frame.origin.y < (scrollView.contentOffset.y + scrollView.bounds.size.height)) {
        // 如果正在刷新数据，不需要再次刷新
        self.loading = YES;
//        [self.footerView.indicator startAnimating];
        // 模拟数据刷新
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.footerView = nil;
//            [self loadData];
            self.loading = NO;
        });
//    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - 懒加载
- (NSMutableArray *)goodsList {
    if (_goodsList == nil) {
        _goodsList = [NSMutableArray array];
    }
    return _goodsList;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LNGood *good = _goodsList[indexPath.row];
    CGSize size = CGSizeMake(good.w, good.h);
    NSLog(@"width:%f height:%f", size.width, size.height);
    return size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
