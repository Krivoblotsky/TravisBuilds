//
//  TBRoundedImageView.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/9/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBRoundedImageView.h"

@interface TBRoundedImageView ()

@property (nonatomic, strong) NSImage *test;

@end

@implementation TBRoundedImageView

- (void)setImage:(NSImage *)image
{
    [super setImage: nil];
    
    self.test = image;
    [self setNeedsDisplay];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [NSGraphicsContext saveGraphicsState];
    
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:dirtyRect
                                                         xRadius:self.bounds.size.width / 2.0f
                                                         yRadius:self.bounds.size.height / 2.0f];
    [path addClip];
    
    [self.test drawInRect:dirtyRect
             fromRect:NSZeroRect
            operation:NSCompositeSourceOver
             fraction:1.0];
    
    [NSGraphicsContext restoreGraphicsState];
}

@end
