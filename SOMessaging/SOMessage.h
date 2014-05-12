//
//  SOMessage.h
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/23/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOMessageType.h"

@interface SOMessage : NSObject

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
