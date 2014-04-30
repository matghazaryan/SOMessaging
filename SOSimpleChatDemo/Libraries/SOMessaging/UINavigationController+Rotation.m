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
    if (self.cantAutorotate) {
        return NO;
    }
    return [self my_shouldAutorotate];
}



@end
