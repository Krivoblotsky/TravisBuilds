//
//  TBLocalFilesManager.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/8/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBLocalFilesManager.h"

static NSString * const TBLocalFilesManagerImagesFolder = @"images";

@interface TBLocalFilesManager ()

/* Reprsents default file manager */
@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation TBLocalFilesManager
@synthesize imagesCacheFolder = _imagesCacheFolder;

+ (instancetype)defaultManager
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [[self alloc] initWithFileManager:fileManager];
}

- (instancetype)initWithFileManager:(NSFileManager *)fileManager
{
    self = [super init];
    if (self) {
        _fileManager = fileManager;
    }
    return self;
}

#pragma mark - Accessors

- (NSURL *)imagesCacheFolder
{
    if (!_imagesCacheFolder) {
        
        NSURL *cachesDirectory = [self _rootCachesDirectory];
        NSString *bundleIdentifier = [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey];
        NSURL *applicationURL = [cachesDirectory URLByAppendingPathComponent:bundleIdentifier];
        NSURL *imagesURL = [applicationURL URLByAppendingPathComponent:TBLocalFilesManagerImagesFolder];
        
        BOOL isDirectory;
        if (![self.fileManager fileExistsAtPath:imagesURL.path isDirectory:&isDirectory]) {
            
            NSError *error = nil;
            BOOL folderCreateResult = [self.fileManager createDirectoryAtPath:imagesURL.path withIntermediateDirectories:YES attributes:nil error:&error];
            if (!folderCreateResult) {
                NSLog(@"%@", error);
            }
        }
        _imagesCacheFolder = imagesURL;
    }
    return _imagesCacheFolder;
}

#pragma mark - Private

- (NSURL *)_rootCachesDirectory
{
    NSURL *cachesDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
    return cachesDirectory;
}

@end
