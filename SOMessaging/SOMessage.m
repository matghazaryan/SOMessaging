//
//  SOMessage.m
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/23/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "SOMessage.h"

@implementation SOMessage

- (id)init
{
    self = [super init];
    if (self) {
        self.date = [NSDate date];
    }
    
    return self;
}

@end
