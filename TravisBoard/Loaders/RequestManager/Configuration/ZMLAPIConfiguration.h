//
//  ZMLAPIConfiguration.h
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 1/5/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface ZMLAPIConfiguration : NSObject

/**
 *  Returns default configuration instance
 *  
 *  @note default configuraton will have AFHTTPRequestSerializer and AFJSONResponseSerializer
 *  @return ZMLAPIConfiguration instance
 */
+ (instancetype)defaultConfiguration;

/**
 *  Designated initializer
 *
 *  @param requestSerializer  AFHTTPRequestSerializer   request serializer
 *  @param responseSerializer AFHTTPResponseSerializer  response serializer
 *  @param responseHandler    id <ZMLResponseHandler>   object conforming to ZMLResponseHandler protocol for request errors aggregating
 *
 *  @return ZMLAPIConfiguration instance
 */
- (instancetype)initWithRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                       responseSerializer:(AFHTTPResponseSerializer *)responseSerializer NS_DESIGNATED_INITIALIZER;


/**
 *  Represents current request serializer
 */
@property (nonatomic, strong, readonly) AFHTTPRequestSerializer *requestSerializer;

/**
 *  Represents current response serializer
 */
@property (nonatomic, strong, readonly) AFHTTPResponseSerializer *responseSerializer;


/**
 *  API endpoint getter
 */
@property (nonatomic, strong, readonly) NSString *baseURLPath;

@end
