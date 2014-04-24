//
//  SOMessagingDelegate.h
//  SOSimpleChatDemo
//
//  Created by artur on 4/24/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SOMessageCell;
@protocol SOMessagingDelegate <NSObject>

@optional
- (void)didSelectMedia:(NSData *)media inMessageCell:(SOMessageCell *)cell;

@end
