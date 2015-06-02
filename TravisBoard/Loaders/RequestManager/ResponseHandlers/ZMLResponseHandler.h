//
//  ZMLResponseHandler.h
//  Zoomlee
//
//  Created by Deszip on 17/02/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

typedef void(^ZMLResponseHandlerCompletion)(id <NSFastEnumeration> object, NSError *error);

@class ZMLRequestAttachment;
@protocol ZMLResponseHandler <NSObject>

@required

/**
 *  Proxy method to aggregate networking and API-based errors
 *  @note Extended version of - (void)extractErrorFromResponse:(id)responseObject networkError:(NSError *)networkError completion:(ZMLResponseHandlerCompletion)completion. If this one is implemented this method is responsive for error aggregation
 *
 *  @param responseObject id                            object representing response received from backend
 *  @param networkError   NSError                       error representing network layer error
 *  @param method         NSString
 *  @param parameters     id
 *  @param completion     ZMLResponseHandlerCompletion
 */
- (void)extractErrorFromResponse:(id)responseObject networkError:(NSError *)networkError endpoint:(NSString *)endpoint method:(NSString *)method parameters:(id)parameters attachment:(ZMLRequestAttachment *)attachment completion:(ZMLResponseHandlerCompletion)completion;

@end
