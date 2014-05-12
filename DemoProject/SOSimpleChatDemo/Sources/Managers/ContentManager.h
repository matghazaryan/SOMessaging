//
//  ContentManager.h
//  SOSimpleChatDemo
//
// Created by : arturdev
// Copyright (c) 2014 SocialObjects Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentManager : NSObject

+ (ContentManager *)sharedManager;

- (NSArray *)generateConversation;

@end
