//
//  TBContentDownloader.h
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/8/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TBContentDownloaderCompletionBlock)(NSURL *remoteURL, NSURL *localURL, NSError *error);

@protocol TBContentDownloaderDelegate;
@interface TBContentDownloader : NSObject

/**
 *  Convenience initializer. Instantiates downloader with default session
 *
 *  @return TBContentDownloader
 */
+ (instancetype)defaultDownloader;

/**
 *  Convenience initializer. Instantiates downloader with custom session
 *
 *  @param session NSURLSession
 *
 *  @return TBContentDownloader
 */
+ (instancetype)downloaderWithSession:(NSURLSession *)session;

/* Represents current delegate */
@property (nonatomic, weak) id <TBContentDownloaderDelegate> delegate;

#pragma mark - Public

/**
 *  Downloads item with given url and places it into local url
 *
 *  @param url      NSURL remoteURL
 *  @param localURL NSURL localURL
 */
- (void)downloadItemAtURL:(NSURL *)remoteURL localURL:(NSURL *)localURL completion:(TBContentDownloaderCompletionBlock)completion;

/**
 *  Downloads item with given request and places it into local url
 *
 *  @param url      NSURLRequest request
 *  @param localURL NSURL localURL
 */
- (void)downloadItemWithRequest:(NSURLRequest *)request localURL:(NSURL *)localURL completion:(TBContentDownloaderCompletionBlock)completion;

@end

@interface TBContentDownloader (Unavailable)

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

@protocol TBContentDownloaderDelegate <NSObject>

@optional

/**
 *  Notifies the delegate about content is about to start downloading. Invokes on arbitary queue.
 *
 *  @param downloader TBContentDownloader
 *  @param remoteURL  NSURL
 */
- (void)contentDownloader:(TBContentDownloader *)downloader willStartDownloadingForURL:(NSURL *)remoteURL;

/**
 *  Notifies the delegate about content has been downloaded. Invokes on arbitary queue.
 *
 *  @param downloader TBContentDownloader
 *  @param remoteURL  NSURL
 *  @param localURL   NSURL
 */
- (void)contentDownloader:(TBContentDownloader *)downloader didFinishDownloadingForRemoteURL:(NSURL *)remoteURL localURL:(NSURL *)localURL;

/**
 *  Notifies the delegate about content downloading failed. Invokes on arbitary queue.
 *
 *  @param downloader TBContentDownloader
 *  @param remoteURL  NSURL
 *  @param error      NSError
 */
- (void)contentDownloader:(TBContentDownloader *)downloader didFailDownloadingForURL:(NSURL *)remoteURL error:(NSError *)error;

@end