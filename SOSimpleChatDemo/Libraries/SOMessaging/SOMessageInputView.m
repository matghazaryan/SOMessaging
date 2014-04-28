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
        [self setupInitialData];
        [self setup];
    }
    return self;
}

- (void)setupInitialData
{
    self.textInitialHeight = 40.0f;
    self.textMaxHeight = 130.0f;
    self.textTopMargin = 5.5f;
    self.textBottomMargin = 5.5f;
    
    CGRect frame = CGRectZero;
    frame.size.height = self.textInitialHeight;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    self.frame = frame;
    
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
}

- (void)setup
{
    self.backgroundColor = [UIColor colorWithRed:(237/255.0) green:(237/255.0) blue:(237/255.0) alpha:1];
    
    self.textBgImageView = [[UIImageView alloc] init];
    self.textBgImageView.backgroundColor = [UIColor clearColor];
    self.textBgImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.textBgImageView];
    
    self.textView = [[SOPlaceholderedTextView alloc] init];
    self.textView.textColor = [UIColor blackColor];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor clearColor];
    [self.textView setTextContainerInset:UIEdgeInsetsZero];
    self.textView.textContainer.lineFragmentPadding = 0;
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.textView];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.backgroundColor = [UIColor clearColor];
    [self.sendButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]
                          forState:UIControlStateNormal];
    [self.sendButton setTitleColor:[UIColor colorWithRed:0.0 green:65.0/255.0 blue:136.0/255.0 alpha:1.0]
                          forState:UIControlStateHighlighted];
    self.sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.sendButton addTarget:self action:@selector(sendTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sendButton];
    
    self.mediaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mediaButton addTarget:self action:@selector(mediaTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.mediaButton.contentMode = UIViewContentModeScaleAspectFit;
    self.mediaButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.mediaButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:self.mediaButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShowNote:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHideNote:) name:UIKeyboardWillHideNotification object:nil];
    
    self.textView.placeholderText = NSLocalizedString(@"Type message...", nil);
    [self.sendButton setTitle:NSLocalizedString(@"Send", nil) forState:UIControlStateNormal];
    self.sendButton.frame = CGRectMake(0, 0, 70, self.textInitialHeight - self.textTopMargin - self.textBottomMargin);
    
    [self.mediaButton setImage:[UIImage imageNamed:@"attachment.png"] forState:UIControlStateNormal];
    self.mediaButton.frame = CGRectMake(0, 0, 50, 24);
    
    [self adjustInputView];
}

#pragma mark - Public methods
- (void)adjustInputView
{
    CGRect mediaFrame = self.mediaButton.frame;
    mediaFrame.origin = CGPointMake(0, 0);
    self.mediaButton.frame = mediaFrame;
    self.mediaButton.center = CGPointMake(self.mediaButton.center.x, self.textInitialHeight/2);
    
    CGRect sendFrame = self.sendButton.frame;
    sendFrame.origin = CGPointMake(self.frame.size.width - sendFrame.size.width, 0);
    self.sendButton.frame = sendFrame;
    self.sendButton.center = CGPointMake(self.sendButton.center.x, self.textInitialHeight/2);
    
    self.textBgImageView.image = [[UIImage imageNamed:@"inputTextBG.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
    
    CGRect txtBgFrame = self.textBgImageView.frame;
    txtBgFrame.origin = CGPointMake(self.mediaButton.frame.origin.x + self.mediaButton.frame.size.width - self.textleftMargin, self.textTopMargin);
    txtBgFrame.size = CGSizeMake(self.frame.size.width - self.mediaButton.frame.size.width - self.textleftMargin - self.sendButton.frame.size.width - self.textRightMargin, self.textInitialHeight - self.textTopMargin - self.textBottomMargin);
    self.textBgImageView.frame = txtBgFrame;
    
    CGFloat topPadding = 6.0f;
    CGFloat bottomPadding = 5.0f;
    CGFloat leftPadding = 6.0f;
    CGFloat rightPadding = 6.0f;
    
    CGRect txtFrame = self.textView.frame;
    txtFrame.origin.x = txtBgFrame.origin.x + leftPadding;
    txtFrame.origin.y = txtBgFrame.origin.y + topPadding;
    txtFrame.size.width = txtBgFrame.size.width - leftPadding - rightPadding;
    txtFrame.size.height = txtBgFrame.size.height - topPadding - bottomPadding;
    self.textView.frame = txtFrame;
}

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

- (void)mediaTapped:(id)sender
{
    
}

#pragma mark - private Methods
- (void)adjustTextViewSize
{
    CGRect usedFrame = [self.textView.layoutManager usedRectForTextContainer:self.textView.textContainer];
    
    CGRect frame = self.textView.frame;
    CGFloat delta = ceilf(usedFrame.size.height) - frame.size.height;
    
//    if (ceilf(usedFrame.size.height) > self.textInitialHeight) {
//        frame.size.height = ceilf(usedFrame.size.height);
//        frame.origin.y -= delta;
//    }
//
//    [UIView animateWithDuration:0.2f animations:^{
//        self.textView.frame = frame;
//    } completion:^(BOOL finished) {
//        [self.textView scrollRectToVisible:self.textView.frame animated:YES];
//    }];
    
    CGRect frm = self.frame;
    frm.size.height += delta;
    frm.origin.y -= delta;
    [UIView animateWithDuration:0.2f animations:^{
        self.frame = frm;
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
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        keyboardRect = CGRectMake(keyboardRect.origin.x, keyboardRect.origin.y, MAX(keyboardRect.size.width,keyboardRect.size.height), MIN(keyboardRect.size.width,keyboardRect.size.height));
    }
    
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
