//
//  MyInfoView.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/17.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import "MyInfoView.h"

@interface MyInfoView ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *levelNameLabel;
@property (nonatomic, strong) SYButton *favorBtn;
@property (nonatomic, strong) SYButton *setttingBtn;

@end

@implementation MyInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [HexStringToColor colorWithHexString:@"eeeeee"];
    }
    return self;
}

- (void)setInfo:(SYInfo *)info {
    
    NSURL *url = [NSURL URLWithString:info.icon];
    [self.iconView sd_setImageWithURL:url];
    self.usernameLabel.text = info.username;
    self.levelNameLabel.text = info.levelName;
    [self.favorBtn setTitle:@"我喜欢的" forState:UIControlStateNormal];
    [self.setttingBtn setImage:[UIImage imageNamed:@"admire_click"] forState:UIControlStateNormal];
    
    [self setFrames];
}

- (void)setFrames {
    
    _iconView.frame = CGRectMake(10, 0, 50, 50);
    _iconView.center = CGPointMake(_iconView.center.x, self.center.y);
    _usernameLabel.frame = CGRectMake(CGRectGetMaxX(_iconView.frame)+5, CGRectGetMinY(_iconView.frame)+2, 100, 15);
    _levelNameLabel.frame = CGRectMake(CGRectGetMinX(_usernameLabel.frame), CGRectGetMaxY(_usernameLabel.frame)+10, 100, 20);
    _setttingBtn.frame = CGRectMake(CGRectGetWidth(self.frame)-40, CGRectGetMaxY(_usernameLabel.frame), 30, 30);
    _favorBtn.frame = CGRectMake(CGRectGetMinX(_setttingBtn.frame)-80, CGRectGetMaxY(_usernameLabel.frame), 60, 30);
    NSLog(@"setting:%f favor:%f", CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (UIImageView *)iconView
{
    if (!_iconView)
    {
        _iconView = [[UIImageView alloc] init];
        _iconView.clipsToBounds = YES;
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        [_iconView.layer setCornerRadius:4];
        [_iconView.layer setMasksToBounds:YES];
        [self addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)usernameLabel
{
    if (!_usernameLabel)
    {
        _usernameLabel = [[UILabel alloc] init];
        _usernameLabel.font = [UIFont systemFontOfSize:15];
        _usernameLabel.numberOfLines = 0;
        _usernameLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_usernameLabel];
    }
    return _usernameLabel;
}

- (UILabel *)levelNameLabel
{
    if (!_levelNameLabel)
    {
        _levelNameLabel = [[UILabel alloc] init];
        _levelNameLabel.font = [UIFont systemFontOfSize:17];
        _levelNameLabel.numberOfLines = 0;
        _levelNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_levelNameLabel];
    }
    return _levelNameLabel;
}

- (SYButton *)favorBtn
{
    if (!_favorBtn) {
        _favorBtn = [SYButton buttonWithType:UIButtonTypeCustom];
//        _favorBtn.backgroundColor = [UIColor redColor];
        _favorBtn.layer.cornerRadius = 3;
        _favorBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_favorBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_favorBtn addTarget:self action:@selector(pushFavorAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_favorBtn];
    }
    return _favorBtn;
}

- (SYButton *)setttingBtn
{
    if (!_setttingBtn) {
        _setttingBtn = [SYButton buttonWithType:UIButtonTypeCustom];
        _setttingBtn.layer.cornerRadius = 3;
        [_setttingBtn addTarget:self action:@selector(pushSettingAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_setttingBtn];
    }
    return _setttingBtn;
}

- (void)pushFavorAction
{
    if ([_delegate respondsToSelector:@selector(pushToFavorViewController:)]) {
        [_delegate pushToFavorViewController:self];
    }
}

- (void)pushSettingAction
{
    if ([_delegate respondsToSelector:@selector(pushToSettingViewController:)]) {
        [_delegate pushToSettingViewController:self];
    }
}

@end
