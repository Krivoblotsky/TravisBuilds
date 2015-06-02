//
//  ZMLAPIConfiguration.m
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 1/5/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "ZMLAPIConfiguration.h"
#import "TBAPIDefinitions.h"

#import "ZMLBaseJSONSerializer.h"
#import "ZMLBaseRequestSerializer.h"

@interface ZMLAPIConfiguration ()

@property (nonatomic, strong, readwrite) AFHTTPRequestSerializer *requestSerializer;
@property (nonatomic, strong, readwrite) AFHTTPResponseSerializer *responseSerializer;

@end

@implementation ZMLAPIConfiguration

+ (instancetype)defaultConfiguration
{
    return [[self alloc] initWithRequestSerializer:[ZMLBaseRequestSerializer serializer]
                                responseSerializer:[ZMLBaseJSONSerializer serializer]];
}

- (instancetype)initWithRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                       responseSerializer:(AFHTTPResponseSerializer *)responseSerializer
{
    self = [super init];
    if (self) {
        _requestSerializer = requestSerializer;
        _responseSerializer = responseSerializer;
    }
    return self;
}

#pragma mark - Public Getters

- (NSString *)baseURLPath
{
    return TBAPIDefinitionsBaseURL;
}

@end
