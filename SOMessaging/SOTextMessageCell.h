//
//  SOTextMessageCell.h
//  SupportKit
//
//  Created by Mike on 2014-06-17.
//  Copyright (c) 2014 Radialpoint. All rights reserved.
//

#import "SOMessageCell.h"

@interface SOTextMessageCell : SOMessageCell

@property (strong, nonatomic) UITextView *textView;

+(CGSize)sizeForMessage:(id<SOMessage>)message constrainedToWidth:(CGFloat)width withFont:(UIFont*)font;

@end
