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
/**
 * Called when user tap the media image view
 */
- (void)didSelectMedia:(NSData *)media inMessageCell:(SOMessageCell *)cell;

/**
 * Called when user tap on send button
 */
- (void)messageInputView:(SOMessageInputView *)inputView didSendMessage:(NSString *)message;

/**
 * Called when user tap on attach media button
 */
- (void)messageInputViewDidSelectMediaButton:(SOMessageInputView *)inputView;

@end
