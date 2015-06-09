//
//  TBContentDownloader.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/8/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBContentDownloader.h"

@interface TBContentDownloader () <NSURLSessionDelegate>

/* Represents current session */
@property (nonatomic, strong) NSURLSession *session;

/* Represents current file manager */
@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation TBContentDownloader

+ (instancetype)defaultDownloader
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    return [self downloaderWithSession:session];
}

+ (instancetype)downloaderWithSession:(NSURLSession *)session
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [[self alloc] initWithSession:session fileManager:fileManager];
}

- (instancetype)initWithSession:(NSURLSession *)session fileManager:(NSFileManager *)fileManager
{
    self = [super init];
    if (self) {
        _session = session;
        _fileManager = fileManager;
    }
    return self;
}

#pragma mark - Public

- (void)downloadItemAtURL:(NSURL *)remoteURL localURL:(NSURL *)localURL
{
    NSParameterAssert(remoteURL);
    NSParameterAssert(localURL);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:remoteURL];
    [self downloadItemWithRequest:request localURL:localURL];
}

- (void)downloadItemWithRequest:(NSURLRequest *)request localURL:(NSURL *)localURL
{
    NSParameterAssert(request);
    NSParameterAssert(localURL);
    
    [self _notifyWillStartDownloadingForURL:request.URL];
    
    /* Start the task */
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithRequest:request
                                                                 completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
    {    
        if (error != nil) {
            
            /* Notify error here */
            [self _notifyError:error withURL:localURL];
        } else {
            
            /* Notify sucess here */
            [self _moveDownloadedContent:location toURL:localURL];
            [self _notifySuccessWithURL:request.URL localURL:localURL];
        }
    }];
 
    [downloadTask resume];
}

#pragma mark - Private

- (void)_notifyWillStartDownloadingForURL:(NSURL *)remoteURL
{
    if ([self.delegate respondsToSelector:@selector(contentDownloader:willStartDownloadingForURL:)]) {
        [self.delegate contentDownloader:self willStartDownloadingForURL:remoteURL];
    }
}

- (void)_notifySuccessWithURL:(NSURL *)remoteURL localURL:(NSURL *)localURL
{
    if ([self.delegate respondsToSelector:@selector(contentDownloader:didFinishDownloadingForRemoteURL:localURL:)]) {
        [self.delegate contentDownloader:self didFinishDownloadingForRemoteURL:remoteURL localURL:localURL];
    }
}

- (void)_notifyError:(NSError *)error withURL:(NSURL *)url
{
    if ([self.delegate respondsToSelector:@selector(contentDownloader:didFailDownloadingForURL:error:)]) {
        [self.delegate contentDownloader:self didFailDownloadingForURL:url error:error];
    }
}

- (BOOL)_moveDownloadedContent:(NSURL *)sourceURL toURL:(NSURL *)destinationURL
{
    NSError *error = nil;
    BOOL result = [self.fileManager moveItemAtURL:sourceURL toURL:destinationURL error:&error];
    
    if (!result) {
        NSLog(@"%s", __PRETTY_FUNCTION__);
        NSLog(@"%@", error);
    }
    return result;
}

@end
