//
//  TBBuildsLoader.h
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/2/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HardCoreData/HCDCoreDataStackController.h>

@interface TBBuildsLoader : NSObject

/**
 *  Convenience initializer
 *
 *  @param coreDataController HCDCoreDataStackController
 *
 *  @return TBBuildsLoader
 */
+ (instancetype)loaderWithCoreDataController:(HCDCoreDataStackController *)coreDataController;

/**
 *  Designated initializer
 *
 *  @param coreDataController HCDCoreDataStackController
 *
 *  @return TBBuildsLoader
 */
- (instancetype)initWithCoreDataController:(HCDCoreDataStackController *)coreDataController;

/* Current core data controller */
@property (nonatomic, strong, readonly) HCDCoreDataStackController *coreDataController;

/* Starts loading builds operation. Builds will be downloaded into main MOC of the controller */
- (void)loadBuilds;

@end
