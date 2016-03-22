//
//  SYTool.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/22.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import "SYTool.h"

@implementation SYTool

- (void)clearAppCache
{
    dispatch_async(
                   
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       
                       NSLog(@"files :%lu",(unsigned long)[files count]);
                       
                       for (NSString *p in files) {
                           
                           NSError *error;
                           
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                               
                           }
                           
                       }
                       
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});

}

- (void)clearCacheSuccess {
    if ([_delegate respondsToSelector:@selector(didFinishedClearCache:)]) {
        [_delegate didFinishedClearCache:self];
    }
}

@end
