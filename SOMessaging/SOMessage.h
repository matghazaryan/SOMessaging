//
//  SOMessage.h
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
#import "SOMessageType.h"

@protocol SOMessage

/**
 * Message text
 */
@property (strong, nonatomic) NSString *text;

/**
 * Attributes for attributed message text
 */
@property (strong, nonatomic) NSDictionary *attributes;

/**
 * NSData from photo or video
 */
@property (strong, nonatomic) NSData *media;

/**
 * Default thumbnail for media.
 */
@property (strong, nonatomic) UIImage *thumbnail;

/**
 * Message sent date
 * Messages will be sorted by this property
 */
@property (strong, nonatomic) NSDate *date;

/**
 * Boolean value that indicates who is the sender
 * This is important property and will be used to decide in which side show message.
 */
@property (nonatomic) BOOL fromMe;

/**
 * Type of message.
 * Available values:
 * SOMessageTypeText, SOMessageTypePhoto, SOMessageTypeVideo
 */
@property (nonatomic) SOMessageType type;

@end
