//
//  SYTool.h
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/22.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SYTool;

@protocol SYToolDelegate <NSObject>

- (void)didFinishedClearCache:(SYTool *)tool;

@end

@interface SYTool : NSObject

@property (nonatomic, assign) id<SYToolDelegate>delegate;

- (void)clearAppCache;

@end
