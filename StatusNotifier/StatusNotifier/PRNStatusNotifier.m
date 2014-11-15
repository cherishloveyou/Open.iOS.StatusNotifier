//
//  PRNStatusNotifier.m
//  StatusNotifier
//
//  Created by 翁阳 on 14/11/14.
//  Copyright (c) 2014年 prinsun. All rights reserved.
//

#import "PRNStatusNotifier.h"

@interface PRNStatusNotifier ()
{
    UIWindow *notifierWindow;
    UILabel *notifierLabel;
    id tagObject;
}


@end

@implementation PRNStatusNotifier


- (id)init
{
    if (self = [super init]) {
        notifierWindow = [[UIWindow alloc] init];
        notifierWindow.windowLevel = UIWindowLevelNormal;
        notifierWindow.windowLevel = UIWindowLevelStatusBar + 1.0f;
        notifierWindow.frame = [UIApplication sharedApplication].statusBarFrame;
        notifierWindow.backgroundColor = [UIColor clearColor];
        notifierWindow.hidden = NO;
        notifierWindow.rootViewController = [[UIViewController alloc] init];
        
        notifierLabel = [[UILabel alloc] init];
        notifierLabel.textAlignment = NSTextAlignmentCenter;
        notifierLabel.backgroundColor = [UIColor blueColor];
        notifierLabel.textColor = [UIColor whiteColor];
        notifierLabel.font = [UIFont boldSystemFontOfSize:12];
        notifierLabel.layer.cornerRadius = 10.0;
        notifierLabel.layer.masksToBounds = YES;
        
        notifierLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
        [notifierLabel addGestureRecognizer:tapGesture];
    }
    return self;
}


- (void)showWithMessage:(NSString *)message
{
    [self showWithMessage:message object:nil];
}

- (void)showWithMessage:(NSString *)message object:(id)anObject
{
    tagObject = anObject;
    
    if (notifierLabel.window) {
        [notifierLabel removeFromSuperview];
    }
    
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    
    notifierLabel.text = message;
    notifierLabel.frame = CGRectMake(statusBarFrame.size.width, 0.0, 120.0, statusBarFrame.size.height);
    [notifierWindow addSubview:notifierLabel];
    
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:0.25 animations:^{
        notifierLabel.frame = CGRectMake(statusBarFrame.size.width - 110, 0.0, 120, statusBarFrame.size.height);
    } completion:^(BOOL finished) {
        [self shakeNotifier:0];
    }];
    
}

- (void)shakeNotifier:(NSInteger)times
{
    if (times > 10) return;
    if (notifierLabel.window == nil) return;
    
    [UIView animateWithDuration:0.12 animations:^{
        int distance = (times % 2) ? 2 : -2;
        
        CGRect frame = notifierLabel.frame;
        frame.origin.x += distance;
        notifierLabel.frame = frame;
        
    } completion:^(BOOL finished) {
        [self shakeNotifier:(times + 1)];
    }];
}

- (void)hide
{
    if (notifierLabel.window == nil) return;
    [notifierLabel removeFromSuperview];
}

- (void)handleTapGesture
{
    [self hide];
    
    if ([self.delegate respondsToSelector:@selector(statusNotifier:didTapWithObject:)]) {
        [self.delegate statusNotifier:self didTapWithObject:tagObject];
    }
}


@end
