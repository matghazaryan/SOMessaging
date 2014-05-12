//
//  UINavigationController+Rotation.m
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

#import "UINavigationController+Rotation.h"
#import <objc/runtime.h>

@implementation UINavigationController (Rotation)

NSString const *kCantAutorotateKey = @"cantAutorotate.key";

+ (void)load
{
    [self swizzleOriginalSelectorWithName:@"shouldAutorotate" toSelectorWithName:@"my_shouldAutorotate"];
}

#pragma mark - Swizzle Utils methods
+ (void)swizzleOriginalSelectorWithName:(NSString *)origName toSelectorWithName:(NSString *)swizzleName
{
    Method origMethod = class_getInstanceMethod([self class], NSSelectorFromString(origName));
    Method newMethod = class_getInstanceMethod([self class], NSSelectorFromString(swizzleName));
    method_exchangeImplementations(origMethod, newMethod);
}

#pragma mark - Getters
- (BOOL)cantAutorotate
{
    return [objc_getAssociatedObject(self, &kCantAutorotateKey) boolValue];
}

#pragma mark - Setters
- (void)setCantAutorotate:(BOOL)cantAutorotate
{
    objc_setAssociatedObject(self, &kCantAutorotateKey, @(cantAutorotate), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)my_shouldAutorotate
{
    if ([self respondsToSelector:@selector(cantAutorotate)] && self.cantAutorotate) {
        return NO;
    }
    return [self my_shouldAutorotate];
}



@end
