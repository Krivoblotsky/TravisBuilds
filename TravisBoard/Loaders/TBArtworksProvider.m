//
//  TBArtworksProvider.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/9/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBArtworksProvider.h"
#import "TBLocalFilesManager.h"
#import "TBContentDownloader.h"

@interface TBArtworksProvider ()

/* Represents current local files manager */
@property (nonatomic, strong) TBLocalFilesManager *diskCacheController;

/* Represents current content downloader */
@property (nonatomic, strong) TBContentDownloader *contentDownloader;

/* Represents current memory cache controller */
@property (nonatomic, strong) NSCache *memoryCacheController;

@end

@implementation TBArtworksProvider

+ (instancetype)defaultProvider
{
    TBLocalFilesManager *localFilesManager = [TBLocalFilesManager defaultManager];
    NSCache *memoryCache = [NSCache new];
    TBContentDownloader *contentDownloader = [TBContentDownloader defaultDownloader];
    return [self providerWithDiskCacheController:localFilesManager memoryCacheController:memoryCache contentDownloader:contentDownloader];
}

+ (instancetype)providerWithDiskCacheController:(TBLocalFilesManager *)diskCacheController
                          memoryCacheController:(NSCache *)memoryCacheController
                              contentDownloader:(TBContentDownloader *)contentDownloader
{
    return [[self alloc] initWithDiskCacheController:diskCacheController
                               memoryCacheController:memoryCacheController
                                   contentDownloader:contentDownloader];
}


- (instancetype)initWithDiskCacheController:(TBLocalFilesManager *)diskCacheController
                      memoryCacheController:(NSCache *)memoryCacheController
                          contentDownloader:(TBContentDownloader *)contentDownloader
{
    self = [super init];
    if (self) {
        _diskCacheController = diskCacheController;
        _memoryCacheController = memoryCacheController;
        _contentDownloader = contentDownloader;
    }
    return self;
}

#pragma mark - Public

- (void)provideArtworkForURL:(NSURL *)url withCompletion:(void (^)(NSImage *artwork, NSError *error))completion
{
    NSString *lastPathComponent = url.lastPathComponent;
    NSURL *localURL = [self.diskCacheController.imagesCacheFolder URLByAppendingPathComponent:lastPathComponent];
    
    /* Query memory cache */
    NSImage *cachedImage = [self.memoryCacheController objectForKey:lastPathComponent];
    if (cachedImage) {
        completion(cachedImage, nil);
        return;
    }
    
    
    
    [self.contentDownloader downloadItemAtURL:url localURL:localURL completion:^(NSURL *remoteURL, NSURL *localURL, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            /* Create image */
            NSImage *image = [[NSImage alloc] initWithContentsOfFile:localURL.path];
            
            /* Add to cache */
            [self.memoryCacheController setObject:image forKey:localURL.lastPathComponent];
            
            /* Notify the completion */
            completion(image, error);
        });
    }];
}

@end
