//
//  UICollectionViewWaterfallCell.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#define discribeHeight  15
#define admireBtnHeight 25

#import "CHTCollectionViewWaterfallCell.h"

@interface CHTCollectionViewWaterfallCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) SYButton *startBtn;
@property (nonatomic, strong) UILabel *recipeNameLabel;
@property (nonatomic, strong) UILabel *discribeLabel;
@property (nonatomic, strong) UILabel *admireNumLabel;
@property (nonatomic, strong) UILabel *collectionNumLabel;
@property (nonatomic, strong) SYButton *admireBtn;
@property (nonatomic, strong) SYButton *collectionBtn;
@end

@implementation CHTCollectionViewWaterfallCell

#define originX     5
#define titleWidth  ([UIScreen mainScreen].bounds.size.width-10)/2-5*2

- (void)setGood:(LNGood *)good {
    
    self.layer.cornerRadius = 4;
    
    _good = good;
    
    NSURL *url = [NSURL URLWithString:good.img];
    [self.iconView sd_setImageWithURL:url];
    self.recipeNameLabel.text = good.title;
    self.discribeLabel.text = good.discribe;
    self.admireNumLabel.text = good.admireNum;
    self.collectionNumLabel.text = good.collectionNum;
    
    
    [self setFrames];
}

- (void)setFrames {

    self.backgroundColor = [UIColor redColor];
    
//    _iconView.frame = CGRectMake(0, 0, _good.w, _good.h);
//    _startBtn.frame = CGRectMake(0, 0, _good.w/4, _good.w/4);
//    _startBtn.center = _iconView.center;
//    [_startBtn.layer setCornerRadius:_startBtn.frame.size.width/2];
//    CGSize contentSize = [_good.title stringForWidth:titleWidth font:_recipeNameLabel.font];
//    _recipeNameLabel.frame = CGRectMake(originX, CGRectGetMaxY(_iconView.frame)+5,
//                                        titleWidth, contentSize.height);
//    
//    _discribeLabel.frame = CGRectMake(originX, CGRectGetMaxY(_recipeNameLabel.frame), titleWidth, discribeHeight);
//    _admireBtn.frame = CGRectMake(originX, CGRectGetMaxY(_discribeLabel.frame), 25, admireBtnHeight);
//    _admireNumLabel.frame = CGRectMake(CGRectGetMaxX(_admireBtn.frame)+5, CGRectGetMinY(_admireBtn.frame), 50, CGRectGetHeight(_admireBtn.frame));
//    _collectionBtn.frame = CGRectMake(CGRectGetWidth(_iconView.frame)/2+10, CGRectGetMaxY(_discribeLabel.frame), 25, admireBtnHeight);
//    _collectionNumLabel.frame = CGRectMake(CGRectGetMaxX(_collectionBtn.frame)+5, CGRectGetMinY(_collectionBtn.frame), 50, CGRectGetHeight(_collectionBtn.frame));

    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(_good.w, _good.h));
    }];
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_good.w/4, _good.w/4));
        make.center.equalTo(_iconView);
    }];
    [_startBtn.layer setCornerRadius:_startBtn.frame.size.width/2];
    
    CGSize contentSize = [_good.title stringForWidth:titleWidth font:_recipeNameLabel.font];
    [_recipeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView.mas_bottom).with.offset(5);
        make.left.mas_equalTo(originX);
        make.size.mas_equalTo(CGSizeMake(titleWidth, contentSize.height));
    }];
    
    [_discribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_recipeNameLabel.mas_bottom);
        make.left.mas_equalTo(originX);
        make.size.mas_equalTo(CGSizeMake(titleWidth, discribeHeight));
    }];
    
    [_admireBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_discribeLabel.mas_bottom);
        make.left.mas_equalTo(originX);
        make.size.mas_equalTo(CGSizeMake(25, admireBtnHeight));
    }];
    
    [_admireNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_admireBtn.mas_right).with.offset(5);
        make.top.equalTo(_admireBtn.mas_top);
        make.width.mas_equalTo(50);
        make.height.equalTo(_admireBtn);
    }];
    
//    _admireNumLabel.frame = CGRectMake(CGRectGetMaxX(_admireBtn.frame)+5, CGRectGetMinY(_admireBtn.frame), 50, CGRectGetHeight(_admireBtn.frame));
//    _collectionBtn.frame = CGRectMake(CGRectGetWidth(_iconView.frame)/2+10, CGRectGetMaxY(_discribeLabel.frame), 25, admireBtnHeight);
//    _collectionNumLabel.frame = CGRectMake(CGRectGetMaxX(_collectionBtn.frame)+5, CGRectGetMinY(_collectionBtn.frame), 50, CGRectGetHeight(_collectionBtn.frame));

    
    
    _admireBtn.enabled = [_good.isAdmire intValue]==0 ? YES : NO;
    _collectionBtn.enabled = [_good.isCollection intValue]==0 ? YES : NO;
    
    NSString *image = [_good.isAdmire intValue]==0 ? @"admire" : @"admire_click";
    [_admireBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}

- (UIImageView *)iconView
{
    if (!_iconView)
    {
        _iconView = [[UIImageView alloc] init];
        _iconView.clipsToBounds = YES;
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
//        [_iconView.layer setCornerRadius:4];
        [_iconView.layer setMasksToBounds:YES];
        [self.contentView addSubview:_iconView];
        
        _startBtn = [SYButton buttonWithType:UIButtonTypeCustom];
//        [_startBtn setImage:[UIImage imageNamed:@"start.jpg"] forState:UIControlStateNormal];
        [_startBtn setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_startBtn];
    }
    return _iconView;
}

- (UILabel *)recipeNameLabel
{
    if (!_recipeNameLabel)
    {
        _recipeNameLabel = [[UILabel alloc] init];
        _recipeNameLabel.font = [UIFont systemFontOfSize:15];
        _recipeNameLabel.numberOfLines = 0;
        _recipeNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:_recipeNameLabel];
    }
    return _recipeNameLabel;
}

- (UILabel *)discribeLabel
{
    if (!_discribeLabel)
    {
        _discribeLabel = [[UILabel alloc] init];
        _discribeLabel.font = [UIFont systemFontOfSize:10];
        _discribeLabel.textColor = [UIColor lightGrayColor];
        
        [self.contentView addSubview:_discribeLabel];
    }
    return _discribeLabel;
}

- (UILabel *)admireNumLabel
{
    if (!_admireNumLabel)
    {
        _admireBtn = [SYButton buttonWithType:UIButtonTypeCustom];
        [_admireBtn addTarget:self action:@selector(admireAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_admireBtn];
        
        _admireNumLabel = [[UILabel alloc] init];
        _admireNumLabel.font = [UIFont systemFontOfSize:11];
        _admireNumLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_admireNumLabel];
    }
    return _admireNumLabel;
}

- (UILabel *)collectionNumLabel
{
    if (!_collectionNumLabel)
    {
        _collectionBtn = [SYButton buttonWithType:UIButtonTypeCustom];
        [_collectionBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
        [_collectionBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_collectionBtn];
        
        _collectionNumLabel = [[UILabel alloc] init];
        _collectionNumLabel.font = [UIFont systemFontOfSize:11];
        _collectionNumLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_collectionNumLabel];
    }
    return _collectionNumLabel;
}

- (CGSize) titleSize{
    return [[Common sharedService] getLableSize:[UIFont systemFontOfSize:15] withString:_good.title withCGSize:CGSizeMake(titleWidth, 2000)];
}

+ (NSMutableArray *)getContentHeight:(NSArray *)goods {
    
    NSMutableArray *goodList = [NSMutableArray array];
    for (LNGood *good in goods) {
        good.contentHeight = [[self alloc] contentHeight:good];
        [goodList addObject:good];
    }
    return goodList;
}

- (CGFloat)contentHeight:(LNGood *)good {
    _good = good;
    CGSize size = [good.title stringForWidth:titleWidth font:[UIFont systemFontOfSize:15]];
    CGFloat height = size.height+discribeHeight+admireBtnHeight+5*2;
    return height;
}

- (void)admireAction {
    if ([_delegate respondsToSelector:@selector(addAdmire:)]) {
        [_delegate addAdmire:self];
    }
}

- (void)collectionAction {
    if ([_delegate respondsToSelector:@selector(addCollection:)]) {
        [_delegate addCollection:self];
    }
}

@end
