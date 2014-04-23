//
//  StartVC.m
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/23/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "StartVC.h"

@interface StartVC ()

@end

@implementation StartVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark - SOMessaging data source
- (NSArray *)messages
{
    return [NSArray new];
}

- (NSTimeInterval)intervalForMessagesGrouping
{
    return 0;
}

- (UIImage *)balloonImageForSending
{
    return nil;
}

- (UIImage *)balloonImageForReceiving
{
    return nil;
}

@end
