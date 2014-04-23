//
//  NSString+Calculation.m
//  SOSimpleChatDemo
//
//  Created by artur on 4/23/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "NSString+Calculation.h"

@implementation NSString (Calculation)

- (CGSize)usedSizeForMaxWidth:(CGFloat)width withFont:(UIFont *)font
{
    UITextView *tempTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    tempTextView.text = self;
    tempTextView.font = font;
    
    CGRect usedFrame = [tempTextView.layoutManager usedRectForTextContainer:tempTextView.textContainer];
    
    
    return usedFrame.size;
}

- (CGSize)usedSizeForMaxWidth:(CGFloat)width withAttributes:(NSDictionary *)attributes
{
    NSAttributedString *attrutedString = [[NSAttributedString alloc] initWithString:self attributes:attributes];
    
    UITextView *tempTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    tempTextView.attributedText = attrutedString;
    
    CGRect usedFrame = [tempTextView.layoutManager usedRectForTextContainer:tempTextView.textContainer];
    
    return usedFrame.size;
}

@end
