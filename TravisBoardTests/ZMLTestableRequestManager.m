//
//  ZMLTestableRequestManager.m
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 1/5/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "ZMLTestableRequestManager.h"

@interface ZMLTestableRequestManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation ZMLTestableRequestManager

- (instancetype)initWithSessionManager:(AFHTTPSessionManager *)manager
{
    self = [super initWithConfiguration:nil];
    if (self) {
        self.sessionManager = manager;
    }
    return self;
}

@end
