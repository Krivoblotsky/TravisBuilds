//
//  TBArtworksProvider.h
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/9/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

/* Dependencies */
@class TBLocalFilesManager, TBContentDownloader, NSCache;
@interface TBArtworksProvider : NSObject

/**
 *  Default convenience initializer
 *
 *  @return TBArtworksProvider.
 */
+ (instancetype)defaultProvider;

/**
 *  Convenience initializer
 *
 *  @param diskCacheController   TBLocalFilesManager
 *  @param memoryCacheController NSCache
 *  @param contentDownloader     TBContentDownloader
 *
 *  @return TBArtworksProvider
 */
+ (instancetype)providerWithDiskCacheController:(TBLocalFilesManager *)diskCacheController
                          memoryCacheController:(NSCache *)memoryCacheController
                              contentDownloader:(TBContentDownloader *)contentDownloader;

/**
 *  Designated initializer for injecting dependencies
 *
 *  @param diskCacheController   TBLocalFilesManager
 *  @param memoryCacheController NSCache
 *  @param contentDownloader     TBContentDownloader
 *
 *  @return TBArtworksProvider
 */
- (instancetype)initWithDiskCacheController:(TBLocalFilesManager *)diskCacheController
                      memoryCacheController:(NSCache *)memoryCacheController
                          contentDownloader:(TBContentDownloader *)contentDownloader NS_DESIGNATED_INITIALIZER;

#pragma mark - Artworks Providing

/**
 *  Provides artwork for given url. Uses memory cache if available, then uses disk cache if available, then uses network if available
 *
 *  @param url        NSURL
 *  @param completion void (^)(NSImage *artwork, NSError *error)
 */
- (void)provideArtworkForURL:(NSURL *)url withCompletion:(void (^)(NSImage *artwork, NSError *error))completion;

@end

@interface TBArtworksProvider (Unavailable)

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
