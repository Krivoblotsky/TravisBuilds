//
//  ZMLTestableRequestManager.h
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 1/5/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "ZMLRequestManager.h"
#import <AFNetworking/AFNetworking.h>

@interface ZMLTestableRequestManager : ZMLRequestManager

- (instancetype)initWithSessionManager:(AFHTTPSessionManager *)manager;

@end
