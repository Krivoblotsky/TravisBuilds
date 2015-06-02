//
//  TBNSColorHexMacros.h
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 1/8/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#ifndef Zoomlee_ZMLUIColorHexMacros_h
#define Zoomlee_ZMLUIColorHexMacros_h

#define ZMLNSColorFromRGB(rgbValue) [NSColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ZMLNSColorFromRGBWithAlpha(rgbValue,a) [NSColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define ZMLNSColorFromHexString(hexValue) ({                      \
    unsigned colorInt = 0;                                        \
    [[NSScanner scannerWithString:hexValue] scanHexInt:&colorInt];\
    ZMLNSColorFromRGB(colorInt);                                  \
})

#endif
