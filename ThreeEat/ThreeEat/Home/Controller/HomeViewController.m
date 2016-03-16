//
//  HomeViewController.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/14.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#define heightOfHeader    172
#define HEADER_IDENTIFIER @"WaterfallHeader"

#import "HomeViewController.h"
#import "BannerModel.h"
#import "AdView.h"
#import "BannerModel.h"
#import "LNGood.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CollectionHeader.h"
#import "MJRefresh.h"

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
    
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    [self startLoading];
    
    [self createRefreshView];
    
    CHTCollectionViewWaterfallLayout *flowLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
    flowLayout.headerHeight = heightOfHeader;
    
    //collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = self.view.backgroundColor;                //GETColor(240, 240, 240, 1);
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.allowsMultipleSelection = NO;                    //默认为NO,是否可以多选
    _collectionView.scrollEnabled = YES;
    
    //注册
    [_collectionView registerClass:[CHTCollectionViewWaterfallCell class] forCellWithReuseIdentifier:@"CHTCollectionViewWaterfallCell"];
    
    //定义 section的  headerView
    //此处的identifier:@"HeaderView" 和 viewForSupplementaryElementOfKind 中的必须一样
    //还可以设置footer
    [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
               withReuseIdentifier:HEADER_IDENTIFIER];
    [self.view addSubview:_collectionView];
    
    [self loadData];
}

//创建刷新和加载更多地控件
- (void)createRefreshView{
//    _slimeView = [[SRRefreshView alloc] init];
//    _slimeView.delegate = self;
//    _slimeView.upInset = 0;
//    _slimeView.slimeMissWhenGoingBack = YES;
//    _slimeView.slime.bodyColor = [Colour setBgRGB:0xb34a4f];
//    _slimeView.slime.skinColor = [UIColor whiteColor];
//    _slimeView.slime.lineWith = 1;
//    _slimeView.slime.shadowBlur = 0;
//    _slimeView.slime.shadowColor = [UIColor clearColor];
//    [_tableview addSubview:_slimeView];
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    _collectionView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _collectionView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _collectionView.footerRefreshingText = @"正在帮你加载中,请稍等";
}

/**
 *  加载数据
 */
- (void)loadData {
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setObject:@"http://xqproduct.xiangqu.com/FoYm07fprsGaSbbFYzAUXbAwMH09?imageView2/2/w/300/q/90/format/jpg/@w/$w$@/@h/$h$@/1800x1200/" forKey:@"img"];
    [dict1 setObject:@"速成巧克力布丁" forKey:@"title"];
    [dict1 setObject:@"甜点和烘烤食品" forKey:@"discribe"];
    [dict1 setObject:@"6,263" forKey:@"admireNum"];
    [dict1 setObject:@"1" forKey:@"isAdmire"];
    [dict1 setObject:@"21.3K" forKey:@"collectionNum"];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setObject:@"http://a.hiphotos.baidu.com/image/h%3D200/sign=b913c88785025aafcc3279cbcbedab8d/562c11dfa9ec8a130b27d9a7f003918fa0ecc0bc.jpg" forKey:@"img"];
    [dict2 setObject:@"法式香草面包(Fougasse)配番茄干" forKey:@"title"];
    [dict2 setObject:@"快手甜品" forKey:@"discribe"];
    [dict2 setObject:@"21.3K" forKey:@"admireNum"];
    [dict2 setObject:@"0" forKey:@"isAdmire"];
    [dict2 setObject:@"6,298" forKey:@"collectionNum"];
    
    
    NSArray *array = [NSArray arrayWithObjects:dict1,dict2,dict2,dict2,dict1,dict2,dict2,dict2,dict2,dict1,dict2,dict2,dict2,dict1,nil];
    
    NSArray *goods = [LNGood goodsWithArray:array];
    goods = [CHTCollectionViewWaterfallCell getContentHeight:goods];
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
    
    LNGood *good = self.goodsList[indexPath.row];
    cell.good = good;
    
    return cell;
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *reusableView = nil;
//    
//    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
//        
//    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
//    }
//    
//    return reusableView;
//}
#pragma mark - FooterView
/**
 *  追加视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == CHTCollectionElementKindSectionHeader)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                  withReuseIdentifier:HEADER_IDENTIFIER
                                                                                         forIndexPath:indexPath];
        [reusableview setBackgroundColor:[UIColor redColor]];
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
        [reusableview addSubview:adView];
        
//        reusableview = headerView;

    }else if (kind == CHTCollectionElementKindSectionFooter) {
        
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
    
    LNGood *good = _goodsList[indexPath.item];
    CGSize size = CGSizeMake(good.w, good.h+good.contentHeight);
    return size;
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section
//{
//    return heightOfHeader;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
