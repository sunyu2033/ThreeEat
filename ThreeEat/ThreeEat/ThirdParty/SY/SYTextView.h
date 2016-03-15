//
//  SYTextView.h
//  快乐面试会
//
//  Created by WuJiaqi on 16/2/22.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYTextView : UITextView

@property (nonatomic, strong) UILabel *placeholdLabel;

- (id)initWithFrame:(CGRect)frame placehold:(NSString *)placehold;

@end
