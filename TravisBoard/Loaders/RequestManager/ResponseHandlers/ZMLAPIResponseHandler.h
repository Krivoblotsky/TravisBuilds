//
//  ZMLRequestErrorHandler.h
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 1/5/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZMLResponseHandler.h"

static NSString * const ZMLRequestErrorHandlerErrorKey        = @"error";
static NSString * const ZMLRequestErrorHandlerBodyKey         = @"body";

static NSString * const ZMLRequestErrorHandlerDomain          = @"com.zmlerrorhandler.domain";

@interface ZMLAPIResponseHandler : NSObject <ZMLResponseHandler>

@end
