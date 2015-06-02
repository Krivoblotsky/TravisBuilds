//
//  ZMLBaseJSONSerializer.m
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 1/12/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "ZMLBaseJSONSerializer.h"



@implementation ZMLBaseJSONSerializer

//- (BOOL)validateResponse:(NSHTTPURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
//{
//    BOOL validate = [super validateResponse:response data:data error:error];
//    return validate;
//}
//
//- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
//{
//    __block id object = [super responseObjectForResponse:response data:data error:error];
//    __block id parsedObject = nil;
//    
//    ZMLAPIResponseHandler *responseHandler = [ZMLAPIResponseHandler new];
//    [responseHandler extractErrorFromResponse:object networkError:*error completion:^(id mappedObject, NSError *mappedError) {
//        parsedObject = [mappedObject copy];
//        *error = mappedError;
//    }];
//    
//    return [super];
//}

@end
