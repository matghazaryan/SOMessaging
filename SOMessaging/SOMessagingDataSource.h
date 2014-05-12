//
//  SOMessagingDataSource.h
//  SOMessaging
//
// Created by : arturdev
// Copyright (c) 2014 SocialObjects Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

#import <Foundation/Foundation.h>

@class SOMessageCell;
@protocol SOMessagingDataSource <NSObject>

@required

/**
 * Array of SOMessage objects.
 */
- (NSMutableArray *)messages;

/**
 * Override this method if you want to customize cell that will be shown.
 * This method calls after cell default adjustment on every reuse time
 */
- (void)configureMessageCell:(SOMessageCell *)cell forMessageAtIndex:(NSInteger)index;

@optional

/**
 * Default implementation of this method is calculating height of the cell for message at given index.
 */
- (CGFloat)heightForMessageForIndex:(NSInteger)index;

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

/**
 * Maximum width of message
 */
- (CGFloat)messageMaxWidth;

/**
 * Minimum height of balloon
 */
- (CGFloat)balloonMinHeight;

/**
 * Minimum width of balloon
 */
- (CGFloat)balloonMinWidth;

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
