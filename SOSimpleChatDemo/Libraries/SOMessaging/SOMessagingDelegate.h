//
//  SOMessagingDelegate.h
//  SOSimpleChatDemo
//
//  Created by artur on 4/24/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SOMessageCell;
@class SOMessageInputView;
@protocol SOMessagingDelegate <NSObject>

@optional
- (void)didSelectMedia:(NSData *)media inMessageCell:(SOMessageCell *)cell;
- (void)messageInputView:(SOMessageInputView *)inputView didSendMessage:(NSString *)message;
- (void)messageInputViewDidSelectMediaButton:(SOMessageInputView *)inputView;

@end
