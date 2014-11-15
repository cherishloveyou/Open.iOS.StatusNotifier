//
//  PRNViewController.m
//  StatusNotifier
//
//  Created by 翁阳 on 14/11/14.
//  Copyright (c) 2014年 prinsun. All rights reserved.
//

#import "PRNViewController.h"
#import "PRNStatusNotifier.h"

@interface PRNViewController ()
{
    PRNStatusNotifier *notifier;
}
@end

@implementation PRNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	notifier = [[PRNStatusNotifier alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showNotifier:(id)sender {
    
    [notifier showWithMessage:@"hello"];
}

@end
