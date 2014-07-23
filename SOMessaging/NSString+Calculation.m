//
//  NSString+Calculation.m
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

#import "NSString+Calculation.h"

@implementation NSString (Calculation)

- (CGSize)usedSizeForMaxWidth:(CGFloat)width withFont:(UIFont *)font
{
    NSTextStorage *textStorage = [[NSTextStorage alloc]
                                  initWithString:self];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize: CGSizeMake(width, MAXFLOAT)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    [textStorage addAttribute:NSFontAttributeName value:font
                        range:NSMakeRange(0, [textStorage length])];
    [textContainer setLineFragmentPadding:0.0];

    [layoutManager glyphRangeForTextContainer:textContainer];
    CGRect frame = [layoutManager usedRectForTextContainer:textContainer];
    return CGSizeMake(ceilf(frame.size.width),ceilf(frame.size.height));
}

- (CGSize)usedSizeForMaxWidth:(CGFloat)width withAttributes:(NSDictionary *)attributes
{
    NSAttributedString *attrutedString = [[NSAttributedString alloc] initWithString:self attributes:attributes];
    
    UITextView *tempTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    [tempTextView setTextContainerInset:UIEdgeInsetsZero];
    tempTextView.textContainer.lineFragmentPadding = 0;

    tempTextView.attributedText = attrutedString;
    [tempTextView.layoutManager glyphRangeForTextContainer:tempTextView.textContainer];
    
    CGRect usedFrame = [tempTextView.layoutManager usedRectForTextContainer:tempTextView.textContainer];
    
    return CGSizeMake(ceilf(usedFrame.size.width),ceilf(usedFrame.size.height));
}

@end
