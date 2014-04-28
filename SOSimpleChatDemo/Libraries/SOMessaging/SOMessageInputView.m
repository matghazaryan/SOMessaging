//
//  SOMessageInputView.m
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/25/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "SOMessageInputView.h"

@interface SOMessageInputView() <UITextViewDelegate>

@end

@implementation SOMessageInputView

- (id)init
{
    self = [super init];
    if (self) {
        CGRect frame = CGRectZero;
        frame.size.height = kInitialInputViewHeight;
        frame.size.width = [UIScreen mainScreen].bounds.size.width;
        self.frame = frame;
        
        self.autoresizingMask = kAutoResizingMaskAll;
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor darkGrayColor];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 100, self.bounds.size.height - 4)];
    self.textView.textColor = [UIColor blackColor];
    self.textView.delegate = self;
//    self.textView.backgroundColor = [UIColor clearColor];
    [self.textView setTextContainerInset:UIEdgeInsetsZero];
    self.textView.textContainer.lineFragmentPadding = 0;
    
    [self addSubview:self.textView];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(self.bounds.size.width - 98, 2, 100, self.bounds.size.height - 4);
    [self.sendButton setTitle:@"Send!" forState:UIControlStateNormal];
    [self.sendButton addTarget:self action:@selector(sendTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.sendButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShowNote:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHideNote:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Public methods

- (void)adjustPosition
{
    CGRect frame = self.frame;
    frame.origin.y = self.superview.bounds.size.height - frame.size.height;
    self.frame = frame;
}

#pragma mark - Actions
- (void)sendTapped:(id)sender
{
    
}
#pragma mark - private Methods
- (void)adjustTextViewSize
{
    CGRect usedFrame = [self.textView.layoutManager usedRectForTextContainer:self.textView.textContainer];
    
    CGRect frame = self.textView.frame;
    CGFloat delta = ceilf(usedFrame.size.height) - frame.size.height;
    
    if (ceilf(usedFrame.size.height) > kInitialInputViewHeight) {
        frame.size.height = ceilf(usedFrame.size.height);
        frame.origin.y -= delta;
    }

    [UIView animateWithDuration:0.2f animations:^{
        self.textView.frame = frame;
    } completion:^(BOOL finished) {
        [self.textView scrollRectToVisible:self.textView.frame animated:YES];
    }];
}

#pragma mark - textview delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    [self adjustTextViewSize];
 
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self adjustTextViewSize];    
}

#pragma mark - Notifications handlers
- (void)handleKeyboardWillShowNote:(NSNotification *)notification
{
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = self.frame;
    frame.origin.y = self.superview.bounds.size.height - frame.size.height - keyboardRect.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:curve];
        self.frame = frame;
    }];
}

- (void)handleKeyboardWillHideNote:(NSNotification *)notification
{
//    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = self.frame;
    frame.origin.y = self.superview.bounds.size.height - frame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:curve];
        self.frame = frame;
    }];
}
@end
