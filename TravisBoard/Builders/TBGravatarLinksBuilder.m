//
//  TBGravatarLinksBuilder.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/9/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBGravatarLinksBuilder.h"
#import <CommonCrypto/CommonCrypto.h>

static NSString * const TBGravatarLinksBuilderHostURL = @"http://www.gravatar.com/avatar/";

@implementation TBGravatarLinksBuilder

#pragma mark - Public

+ (NSURL *)gravatarUserImageURLWithEmail:(NSString *)email
{
    if (!email) {
        return nil;
    }
    
    NSString *hash = [self preparedHash:email];
    NSString *composedString = [[TBGravatarLinksBuilderHostURL stringByAppendingString:hash] stringByAppendingString:@"?s=200"];
    return [NSURL URLWithString:composedString];
}

#pragma mark - 

+ (NSString *)preparedHash:(NSString *)rawString
{
    NSString *preparedString = [rawString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    preparedString = [preparedString lowercaseString];
    preparedString = [self md5String:preparedString];
    return preparedString;
}

+ (NSString *)md5String:(NSString *)rawString
{
    const char *cStr = [rawString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
