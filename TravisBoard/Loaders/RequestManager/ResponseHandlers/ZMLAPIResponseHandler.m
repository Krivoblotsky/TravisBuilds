//
//  ZMLRequestErrorHandler.m
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 1/5/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "ZMLAPIResponseHandler.h"

@implementation ZMLAPIResponseHandler

- (void)extractErrorFromResponse:(id)responseObject networkError:(NSError *)networkError endpoint:(NSString *)endpoint method:(NSString *)method parameters:(id)parameters attachment:(ZMLRequestAttachment *)attachment completion:(ZMLResponseHandlerCompletion)completion
{
    /* We've got network error */
    if (networkError) {
        /* Notify network error */
        completion(nil, networkError);
        return;
    }
    
    completion(responseObject, nil);
    
//    /* Response is a dictionary */
//    if ([responseObject isKindOfClass:[NSDictionary class]]) {
//        
//        /* Grab the error */
//        NSError *error = [ZMLAPIErrorMapper errorObjectWithErrorBody:responseObject[ZMLRequestErrorHandlerErrorKey]];
//        
//        /* Everything is fine */
//        if (error.code == ZMLAPIErrorCodeOK) {
//            
//            /* Notify success */
//            completion(responseObject[ZMLRequestErrorHandlerBodyKey], nil);
//            return;
//        }
//        
//        /* Something is wrong */
//        completion(nil, error);
//        
//        /* Format is wrong */
//    } else {
//        completion(nil, [ZMLAPIErrorMapper wrongResponseFormatError]);
//    }
}

@end
