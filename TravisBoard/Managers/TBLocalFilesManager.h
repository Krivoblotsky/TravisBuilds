//
//  TBLocalFilesManager.h
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/8/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBLocalFilesManager : NSObject

/**
 *  Convenience initializer
 *
 *  @return TBLocalFilesManager
 */
+ (instancetype)defaultManager;

/**
 *  Designated initializer
 *
 *  @param fileManager NSFileManager
 *
 *  @return NSFileManager
 */
- (instancetype)initWithFileManager:(NSFileManager *)fileManager NS_DESIGNATED_INITIALIZER;

/* Represents images cache folder */
@property (nonatomic, strong, readonly) NSURL *imagesCacheFolder;

@end

@interface TBLocalFilesManager (Unavailable)

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
