//
//  SOPlaceholderedTextView.m
//  SOSimpleChatDemo
//
//  Created by artur on 4/28/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "SOPlaceholderedTextView.h"

@interface SOPlaceholderedTextView()

@property (strong, nonatomic) UILabel *placeholderLabel;

@end

@implementation SOPlaceholderedTextView

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup
{
    self.placeholderTextColor = [UIColor lightGrayColor];
    self.placeholderLabel = [[UILabel alloc] init];
    [self addSubview:self.placeholderLabel];
    self.placeholderLabel.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = placeholderText;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor
{
    _placeholderTextColor = placeholderTextColor;
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)textViewTextDidChange:(NSNotification *)note
{
    [self setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    if (self.placeholderText.length && !self.text.length) {

        if (!self.font) {
            self.font = [UIFont systemFontOfSize:12];
        }
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholderText attributes:@{NSForegroundColorAttributeName : self.placeholderTextColor, NSFontAttributeName : self.font}];
        
        self.placeholderLabel.attributedText = attrString;
        [self.placeholderLabel sizeToFit];
        self.placeholderLabel.hidden = NO;
    } else {
        self.placeholderLabel.hidden = YES;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
