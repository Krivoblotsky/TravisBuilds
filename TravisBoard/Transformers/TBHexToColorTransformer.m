//
//  TBHexToColorTransformer.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/2/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBHexToColorTransformer.h"
#import "TBNSColorHexMacros.h"
#import <AppKit/NSColor.h>

@implementation TBHexToColorTransformer

- (id)transformedValue:(id)value
{
    if (![value isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSColor *color = ZMLNSColorFromHexString(value);
    return color;
}

- (id)reverseTransformedValue:(NSColor *)color
{
    if (![color isKindOfClass:[NSColor class]]) {
        return nil;
    }
    NSString* hexString = [NSString stringWithFormat:@"%02X%02X%02X",
                           (int) (color.redComponent * 0xFF), (int) (color.greenComponent * 0xFF),
                           (int) (color.blueComponent * 0xFF)];
    return hexString;
}

@end
