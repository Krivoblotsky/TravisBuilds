//
//  TBGravatarLinksBuilder.h
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/9/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBGravatarLinksBuilder : NSObject

/**
 *  Craetes gravatar image url
 *
 *  @param email NSString
 *
 *  @return TBGravatarLinksBuilder
 */
+ (NSURL *)gravatarUserImageURLWithEmail:(NSString *)email;

@end
