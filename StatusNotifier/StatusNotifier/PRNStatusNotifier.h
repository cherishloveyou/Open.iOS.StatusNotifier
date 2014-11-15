//
//  PRNStatusNotifier.h
//  StatusNotifier
//
//  Created by 翁阳 on 14/11/14.
//  Copyright (c) 2014年 prinsun. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PRNStatusNotifierDelegate;

/**
 *  状态栏通知器
 */
@interface PRNStatusNotifier : NSObject

- (void)showWithMessage:(NSString *)message;

- (void)showWithMessage:(NSString *)message object:(id)anObject;

- (void)hide;


@property (nonatomic, weak) id<PRNStatusNotifierDelegate> delegate;

@end


@protocol PRNStatusNotifierDelegate <NSObject>
@optional

- (void)statusNotifier:(PRNStatusNotifier *)notifier didTapWithObject:(id)object;

@end