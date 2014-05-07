//
//  ContentManager.h
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 5/7/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentManager : NSObject

+ (ContentManager *)sharedManager;

- (NSArray *)generateConversation;

@end
