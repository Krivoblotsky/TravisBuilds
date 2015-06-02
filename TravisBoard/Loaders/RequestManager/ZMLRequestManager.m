//
//  ZMLRequestManager.m
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 1/5/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "ZMLRequestManager.h"
#import "ZMLAPIResponseHandler.h"

static ZMLRequestManager *defaultManager = nil;
@interface ZMLRequestManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) ZMLAPIResponseHandler *responseHandler;

@end

@implementation ZMLRequestManager

- (instancetype)initWithConfiguration:(ZMLAPIConfiguration *)configuration
{
    self = [super init];
    if (self) {
        /* The config */
        _configuration = configuration;
        _responseHandler = [ZMLAPIResponseHandler new];
    }
    return self;
}

#pragma mark -
#pragma mark - HTTP Routines
#pragma mark - 

#pragma mark - GET

- (void)runGETRequestWithEndpoint:(NSString *)endpointPath parameters:(id)parameters completion:(ZMLRequestManagerCompletionBlock)completionBlock
{
    __weak __typeof(self) weakSelf = self;
    [self.sessionManager GET:endpointPath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [weakSelf extractBody:responseObject error:nil endpoint:endpointPath method:ZMLRequestManagerRequestMethodGET parameters:parameters attachment:nil completion:completionBlock];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [weakSelf extractBody:nil error:error endpoint:endpointPath method:ZMLRequestManagerRequestMethodGET parameters:parameters attachment:nil completion:completionBlock];
    }];
}

#pragma mark - POST

- (void)runPOSTRequestWithEndpoint:(NSString *)endpointPath parameters:(id)parameters attachment:(ZMLRequestAttachment *)attachment completion:(ZMLRequestManagerCompletionBlock)completionBlock
{
    __weak __typeof(self) weakSelf = self;
    
    /* Set attachment if needed */
    void(^block)(id<AFMultipartFormData>) = nil;
    if (attachment) {
        block = ^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:attachment.fileURL name:attachment.name error:nil];
        };
    }
    
    /* Run the request */
    [self.sessionManager POST:endpointPath parameters:parameters constructingBodyWithBlock:block
                      success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf extractBody:responseObject error:nil endpoint:endpointPath method:ZMLRequestManagerRequestMethodPOST parameters:parameters attachment:attachment completion:completionBlock];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [weakSelf extractBody:nil error:error endpoint:endpointPath method:ZMLRequestManagerRequestMethodPOST parameters:parameters attachment:attachment completion:completionBlock];
    }];
}

- (void)runPOSTRequestWithEndpoint:(NSString *)endpointPath parameters:(id)parameters completion:(ZMLRequestManagerCompletionBlock)completionBlock
{
    __weak __typeof(self) weakSelf = self;
    [self.sessionManager POST:endpointPath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [weakSelf extractBody:responseObject error:nil endpoint:endpointPath method:ZMLRequestManagerRequestMethodPOST parameters:parameters attachment:nil completion:completionBlock];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [weakSelf extractBody:nil error:error endpoint:endpointPath method:ZMLRequestManagerRequestMethodPOST parameters:parameters attachment:nil completion:completionBlock];
    }];
}

#pragma mark - PUT

- (void)runPUTRequestWithEndpoint:(NSString *)endpointPath parameters:(id)parameters completion:(ZMLRequestManagerCompletionBlock)completionBlock
{
    __weak __typeof(self) weakSelf = self;
    [self.sessionManager PUT:endpointPath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [weakSelf extractBody:responseObject error:nil endpoint:endpointPath method:ZMLRequestManagerRequestMethodPUT parameters:parameters attachment:nil completion:completionBlock];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [weakSelf extractBody:nil error:error endpoint:endpointPath method:ZMLRequestManagerRequestMethodPUT parameters:parameters attachment:nil completion:completionBlock];
    }];
}

- (void)runPUTRequestWithEndpoint:(NSString *)endpointPath parameters:(id)parameters attachment:(ZMLRequestAttachment *)attachment completion:(ZMLRequestManagerCompletionBlock)completionBlock
{
    /* Set attachment if needed */
    void(^block)(id<AFMultipartFormData>) = nil;
    if (attachment) {
        block = ^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:attachment.fileURL name:attachment.name error:nil];
        };
    }

    __weak __typeof(self) weakSelf = self;
    NSString *urlString = [[NSURL URLWithString:endpointPath relativeToURL:self.sessionManager.baseURL] absoluteString];
    NSURLRequest *request = [self.sessionManager.requestSerializer multipartFormRequestWithMethod:ZMLRequestManagerRequestMethodPUT URLString:urlString parameters:parameters constructingBodyWithBlock:block error:nil];
    NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error == nil) {
            [weakSelf extractBody:responseObject error:nil endpoint:endpointPath method:ZMLRequestManagerRequestMethodPUT parameters:parameters attachment:attachment completion:completionBlock];
        } else {
            [weakSelf extractBody:nil error:error endpoint:endpointPath method:ZMLRequestManagerRequestMethodPUT parameters:parameters attachment:attachment completion:completionBlock];
        }
    }];
    [task resume];
}

#pragma mark - DELETE

- (void)runDELETERequestWithEndpoint:(NSString *)endpointPath parameters:(id)parameters completion:(ZMLRequestManagerCompletionBlock)completionBlock
{
    __weak __typeof(self) weakSelf = self;
    [self.sessionManager DELETE:endpointPath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [weakSelf extractBody:responseObject error:nil endpoint:endpointPath method:ZMLRequestManagerRequestMethodDELETE parameters:parameters attachment:nil completion:completionBlock];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [weakSelf extractBody:nil error:error endpoint:endpointPath method:ZMLRequestManagerRequestMethodDELETE parameters:parameters attachment:nil completion:completionBlock];
    }];
}

#pragma mark -
#pragma mark - Private
#pragma mark -

//@TODO: Refactoring candidate no.2
- (void)extractBody:(id)object error:(NSError *)error endpoint:(NSString *)endpoint method:(NSString *)method parameters:(id)parameters attachment:(ZMLRequestAttachment *)attachment completion:(ZMLRequestManagerCompletionBlock)completionBlock
{
    [self.responseHandler extractErrorFromResponse:object networkError:error endpoint:endpoint method:method parameters:parameters attachment:attachment completion:^(id object, NSError *error) {
        completionBlock(object, error);
    }];
}

- (void)cancel
{
    [[self.sessionManager tasks] enumerateObjectsUsingBlock:^(NSURLSessionTask *task, NSUInteger idx, BOOL *stop) {
        [task cancel];
    }];
}

#pragma mark - Private

- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        
        /* Setup session configuration */
        NSURL *baseAPIURL = [NSURL URLWithString:self.configuration.baseURLPath];
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        /* Create an instance */
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseAPIURL sessionConfiguration:sessionConfiguration];
        self.sessionManager.responseSerializer = self.configuration.responseSerializer;
        self.sessionManager.requestSerializer = self.configuration.requestSerializer;
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return _sessionManager;
}

@end
