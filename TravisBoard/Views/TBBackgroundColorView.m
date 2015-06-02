//
//  TBBackgroundColorView.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/2/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBBackgroundColorView.h"

@implementation TBBackgroundColorView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        [self _commonInit];
    }
    return self;
}

#pragma mark - Setters

- (void)setBackgroundColor:(NSColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    [self setNeedsDisplay:YES];
}

#pragma mark - Drawing

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    [self.backgroundColor setFill];
    NSRectFill(dirtyRect);
}

#pragma mark - Private

- (void)_commonInit
{
    _backgroundColor = [NSColor clearColor];
}

@end
