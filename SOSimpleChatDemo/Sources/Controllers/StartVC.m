//
//  StartVC.m
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/23/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "StartVC.h"
#import "SOMessage.h"

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
    NSMutableArray *messages = [NSMutableArray new];
    for (int i = 0; i < 4; i++) {
        SOMessage *message = [[SOMessage alloc] init];
        message.fromMe = i%2;
        
        message.text = @"Hello, how are you? Hello, how are you? Hello, how are you?";
        
        [messages addObject:message];
    }
        
    return messages;
}

- (NSTimeInterval)intervalForMessagesGrouping
{
    return 0;
}

@end
