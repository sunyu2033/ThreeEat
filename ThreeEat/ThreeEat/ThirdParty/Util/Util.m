//
//  Util.m
//
//  Created by sigboat on 14-4-15.
//  Copyright (c) 2014年 sigboat. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
//    alert.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1f];
    alert.backgroundColor = [UIColor redColor];
    
    alert.tag = 100;
    [alert show];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(removeAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alert,@"alert", nil] repeats:NO];
}

+ (void)removeAlert:(NSTimer *)timer
{
    UIAlertView *alert = (UIAlertView *)[timer.userInfo objectForKey:@"alert"];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [timer invalidate];
    timer = nil;
}

CGAffineTransform aspectFit(CGRect innerRect, CGRect outerRect)
{
	CGFloat scaleFactor = MIN(outerRect.size.width/innerRect.size.width, outerRect.size.height/innerRect.size.height);
	CGAffineTransform scale = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
	CGRect scaledInnerRect = CGRectApplyAffineTransform(innerRect, scale);
	CGAffineTransform translation =
	CGAffineTransformMakeTranslation((outerRect.size.width - scaledInnerRect.size.width) / 2 - scaledInnerRect.origin.x,
									 (outerRect.size.height - scaledInnerRect.size.height) / 2 - scaledInnerRect.origin.y);
	return CGAffineTransformConcat(scale, translation);
}

@end
