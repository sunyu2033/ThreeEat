//
//  SYTextView.m
//  快乐面试会
//
//  Created by WuJiaqi on 16/2/22.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "SYTextView.h"

@implementation SYTextView

- (id)initWithFrame:(CGRect)frame placehold:(NSString *)placehold
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self buildTextField:frame placehold:placehold];
    }
    return self;
}

- (void)buildTextField:(CGRect)frame placehold:(NSString *)placehold{
    
    self.frame = frame;
    self.returnKeyType = UIReturnKeyDone;
    self.layer.cornerRadius = 5.0;
    self.font = [UIFont systemFontOfSize:16];
    self.backgroundColor = [UIColor whiteColor];
    self.showsVerticalScrollIndicator = NO;
    self.scrollEnabled = NO;
    
    self.placeholdLabel = [[UILabel alloc] init];
    self.placeholdLabel.frame = CGRectMake(5, 0, CGRectGetWidth(self.frame)-5, 34);
    self.placeholdLabel.font = self.font;
    self.placeholdLabel.textColor = [UIColor lightGrayColor];
    self.placeholdLabel.text = [self.text length]==0 ? placehold : @"";
    [self addSubview:self.placeholdLabel];
}

@end
