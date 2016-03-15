//
//  UICollectionViewWaterfallCell.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallCell.h"
#import "LNGood.h"
#import "UIImageView+WebCache.h"


@interface CHTCollectionViewWaterfallCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *recipeNameLabel;
@property (nonatomic, strong) UILabel *discribeLabel;
@property (nonatomic, strong) UILabel *admireNumLabel;
@property (nonatomic, strong) UILabel *collectionNumLabel;
@end

@implementation CHTCollectionViewWaterfallCell

#define originX     10
#define titleWidth  132

- (void)setGood:(LNGood *)good {
    
    self.layer.cornerRadius = 4;
    
    _good = good;
    NSURL *url = [NSURL URLWithString:good.img];
    [self.iconView sd_setImageWithURL:url];
    self.recipeNameLabel.text = good.title;
    self.discribeLabel.text = good.discribe;
    self.admireNumLabel.text = good.admireNum;
    self.collectionNumLabel.text = good.collectionNum;
//    NSLog(@"w:%ld h:%ld url:%@ title:%@ discribe:%@ admireNum:%@ collectionNum:%@", (long)good.w, (long)good.h, good.img, good.title, good.discribe, good.admireNum, good.collectionNum);
}


- (UIImageView *)iconView
{
    if (!_iconView)
    {
        NSLog(@"1111");
        _iconView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
//        _iconView.frame = CGRectMake(0, 0, 152, 204);
        _iconView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)recipeNameLabel
{
    if (!_recipeNameLabel)
    {
        NSLog(@"2222");
        _recipeNameLabel = [[UILabel alloc] init];
        _recipeNameLabel.font = [UIFont systemFontOfSize:15];
        _recipeNameLabel.numberOfLines = 0;
        _recipeNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize contentSize = [[Common sharedService] getLableSize:_recipeNameLabel.font withString:_good.title withCGSize:CGSizeMake(titleWidth, 2000)];
        _recipeNameLabel.frame = CGRectMake(originX, CGRectGetMaxY(_iconView.frame)+5, titleWidth, contentSize.height);
        [self addSubview:_recipeNameLabel];
    }
    return _recipeNameLabel;
}

- (UILabel *)discribeLabel
{
    if (!_discribeLabel)
    {
        NSLog(@"3333");
        _discribeLabel = [[UILabel alloc] init];
        _discribeLabel.font = [UIFont systemFontOfSize:10];
        _discribeLabel.textColor = [UIColor lightGrayColor];
        _discribeLabel.frame = CGRectMake(originX, CGRectGetMaxY(_recipeNameLabel.frame), titleWidth, 15);
        
        [self addSubview:_discribeLabel];
    }
    return _discribeLabel;
}

- (UILabel *)admireNumLabel
{
    if (!_admireNumLabel)
    {
        NSLog(@"4444");
        NSString *image = [_good.isAdmire intValue]==0 ? @"admire" : @"admire_click";
        SYButton *admireBtn = [SYButton buttonWithType:UIButtonTypeCustom];
        admireBtn.frame = CGRectMake(originX, CGRectGetMaxY(_discribeLabel.frame)+5, 25, 25);
        [admireBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [self addSubview:admireBtn];
        
        _admireNumLabel = [[UILabel alloc] init];
        _admireNumLabel.font = [UIFont systemFontOfSize:11];
        _admireNumLabel.textColor = [UIColor lightGrayColor];
        _admireNumLabel.frame = CGRectMake(CGRectGetMaxX(admireBtn.frame)+5, CGRectGetMinY(admireBtn.frame), 50, CGRectGetHeight(admireBtn.frame));
        [self addSubview:_admireNumLabel];
    }
    return _admireNumLabel;
}

- (UILabel *)collectionNumLabel
{
    if (!_collectionNumLabel)
    {
        NSLog(@"5555");
        SYButton *collectionBtn = [SYButton buttonWithType:UIButtonTypeCustom];
        collectionBtn.frame = CGRectMake(CGRectGetWidth(_iconView.frame)/2+10, CGRectGetMaxY(_discribeLabel.frame)+5, 25, 25);
        [collectionBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
        [self addSubview:collectionBtn];
        
        _collectionNumLabel = [[UILabel alloc] init];
        _collectionNumLabel.font = [UIFont systemFontOfSize:11];
        _collectionNumLabel.textColor = [UIColor lightGrayColor];
        _collectionNumLabel.frame = CGRectMake(CGRectGetMaxX(collectionBtn.frame)+5, CGRectGetMinY(collectionBtn.frame), 50, CGRectGetHeight(collectionBtn.frame));
        [self addSubview:_collectionNumLabel];
    }
    return _collectionNumLabel;
}
@end
