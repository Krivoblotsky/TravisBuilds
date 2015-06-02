//
//  ZMLRequestManager.h
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 1/5/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMLAPIConfiguration.h"
#import "ZMLRequestAttachment.h"

static NSString * const ZMLRequestManagerRequestMethodGET     = @"GET";
static NSString * const ZMLRequestManagerRequestMethodPOST    = @"POST";
static NSString * const ZMLRequestManagerRequestMethodPUT     = @"PUT";
static NSString * const ZMLRequestManagerRequestMethodDELETE  = @"DELETE";

typedef void(^ZMLRequestManagerCompletionBlock)(id object, NSError *error);

@interface ZMLRequestManager : NSObject

/**
 *  Instantiate manager with given configuration
 *
 *  @param configuration ZMLAPIConfiguration
 *
 *  @return ZMLRequestManager instance
 */
- (instancetype)initWithConfiguration:(ZMLAPIConfiguration *)configuration;

/**
 *  Current configuration. Settable via constructor
 */
@property (nonatomic, strong, readonly) ZMLAPIConfiguration *configuration;

/**
 *  Runs GET request
 *
 *  @param endpointPath    NSString. Endpoint path
 *  @param parameters      id parameters. Could be NSDictionary or NSArray
 *  @param completionBlock ZMLRequestManagerCompletionBlock completion
 */
- (void)runGETRequestWithEndpoint:(NSString *)endpointPath parameters:(id)parameters completion:(ZMLRequestManagerCompletionBlock)completionBlock;

/**
 *  Runs POST request
 *
 *  @param endpointPath    NSString. Endpoint path
 *  @param parameters      id parameters. Could be NSDictionary or NSArray
 *  @param completionBlock ZMLRequestManagerCompletionBlock completion
 */
- (void)runPOSTRequestWithEndpoint:(NSString *)endpointPath parameters:(id)parameters completion:(ZMLRequestManagerCompletionBlock)completionBlock;

/**
 *  Runs POST request with custom multipart from data
 *
 *  @param endpointPath    NSString
 *  @param parameters      id
 *  @param block           ZMLRequestAttachment to be included in multipart data
 *  @param completionBlock ZMLRequestManagerCompletionBlock
 */
- (void)runPOSTRequestWithEndpoint:(NSString *)endpointPath parameters:(id)parameters attachment:(ZMLRequestAttachment *)attachment completion:(ZMLRequestManagerCompletionBlock)completionBlock;

/**
 *  Runs PUT request
 *
 *  @param endpointPath    NSString. Endpoint path
 *  @param parameters      id parameters. Could be NSDictionary or NSArray
 *  @param completionBlock ZMLRequestManagerCompletionBlock completion
 */
- (void)runPUTRequestWithEndpoint:(NSString *)endpointPath parameters:(id)parameters completion:(ZMLRequestManagerCompletionBlock)completionBlock;

/**
 *  Runs PUT request with custom miltipart form data
 *
 *  @param endpointPath    NSString
 *  @param parameters      id
 *  @param block           ZMLRequestAttachment to be included in multipart data
 *  @param completionBlock ZMLRequestManagerCompletionBlock
 */
- (void)runPUTRequestWithEndpoint:(NSString *)endpointPath parameters:(id)parameters attachment:(ZMLRequestAttachment *)attachment completion:(ZMLRequestManagerCompletionBlock)completionBlock;

/**
 *  Runs DELETE request
 *
 *  @param endpointPath    NSString. Endpoint path
 *  @param parameters      id parameters. Could be NSDictionary or NSArray
 *  @param completionBlock ZMLRequestManagerCompletionBlock completion
 */
- (void)runDELETERequestWithEndpoint:(NSString *)endpointPath parameters:(id)parameters completion:(ZMLRequestManagerCompletionBlock)completionBlock;

/**
 *  Cancels all running requests
 */
- (void)cancel;

@end
