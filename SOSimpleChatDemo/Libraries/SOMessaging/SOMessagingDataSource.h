//
//  SOMessagingDataSource.h
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/23/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SOMessageCell;
@protocol SOMessagingDataSource <NSObject>

@required

/**
 * Array of SOMessage objects.
 */
- (NSMutableArray *)messages;

/**
 * Messages will be grouped by returned time interval (in seconds).
 * return 0 if you don't want grouping.
 */
- (NSTimeInterval)intervalForMessagesGrouping;

/**
 * Return resizable image for sending balloon background image
 */
- (UIImage *)balloonImageForSending;

/**
 * Return resizable image for receiving balloon background image
 */
- (UIImage *)balloonImageForReceiving;

@optional
/**
 * Override this method if you want to customize cell that will be shown.
 * This method calls after cell configuration and adjustment
 */
- (void)configureMessageCell:(SOMessageCell *)cell forMessageAtIndex:(NSInteger)index;

/**
 * Maximum width of message
 */
- (CGFloat)messageMaxWidth;

/**
 * Minimum height of message
 */
- (CGFloat)messageMinHeight;

/**
 * Font of message
 */
- (UIFont *)messageFont;

/**
 * Size of photo or video thumbnail imageView
 */
- (CGSize)mediaThumbnailSize;

/**
 * Size user's imageview
 */
- (CGSize)userImageSize;

 @end
