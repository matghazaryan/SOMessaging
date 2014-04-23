//
//  SOMessageType.h
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/23/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#ifndef SOSimpleChatDemo_SOMessageType_h
#define SOSimpleChatDemo_SOMessageType_h

typedef enum {
  SOMessageTypeText  = 0,
  SOMessageTypePhoto = 1 << 0,
  SOMessageTypeVideo = 1 << 1
} SOMessageType;

#endif
