//
//  UINavigationController+Rotation.m
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/30/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "UINavigationController+Rotation.h"
#import <objc/runtime.h>

@implementation UINavigationController (Rotation)

NSString const *kCanAutorotateKey = @"canAutorotate.key";

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
- (BOOL)canAutorotate
{
    return [objc_getAssociatedObject(self, &kCanAutorotateKey) boolValue];
}

#pragma mark - Setters
- (void)setCanAutorotate:(BOOL)canAutorotate
{
    objc_setAssociatedObject(self, &kCanAutorotateKey, @(canAutorotate), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)my_shouldAutorotate
{
    if (!self.canAutorotate) {
        return NO;
    }
    return [self my_shouldAutorotate];
}



@end
