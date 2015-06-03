//
//  TBBuildsLoader.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/2/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBBuildsLoader.h"
#import "TBBuild+Additions.h"
#import "ZMLRequestManager.h"
#import "TBAPIDefinitions.h"

@interface TBBuildsLoader ()

/* Represents current request manager */
@property (nonatomic, strong) ZMLRequestManager *requestManager;

@end

@implementation TBBuildsLoader

#pragma mark - Public Initializers

+ (instancetype)loaderWithCoreDataController:(HCDCoreDataStackController *)coreDataController
{
    return [[self alloc] initWithCoreDataController:coreDataController];
}

- (instancetype)initWithCoreDataController:(HCDCoreDataStackController *)coreDataController
{
    ZMLAPIConfiguration *config = [ZMLAPIConfiguration defaultConfiguration];
    ZMLRequestManager *requestManager = [[ZMLRequestManager alloc] initWithConfiguration:config];
    return [self initWithCoreDataController:coreDataController requestManager:requestManager];
}

#pragma mark - Designated Initializer. Testable constructor.

- (instancetype)initWithCoreDataController:(HCDCoreDataStackController *)coreDataController
                            requestManager:(ZMLRequestManager *)requestManager
{
    self = [super init];
    if (self) {
        _requestManager = requestManager;
        _coreDataController = coreDataController;
    }
    return self;
}

#pragma mark - Public

- (void)loadBuilds
{
    [self.requestManager runGETRequestWithEndpoint:TBAPIDefinitionsGetBuildsURL
                                        parameters:nil
                                        completion:^(id object, NSError *error)
    {
        if (error == nil) {
            /* Save builds to th local DB */
            [self _saveBuildsWithObject:object];
        }
    }];
}

#pragma mark - Private

- (void)_saveBuildsWithObject:(id)object
{
    NSManagedObjectContext *context = [self.coreDataController createChildContextWithType:NSPrivateQueueConcurrencyType];
    [context performBlock:^{
        
        /* Save objects */
        [EKManagedObjectMapper arrayOfObjectsFromExternalRepresentation:object
                                                            withMapping:[TBBuild objectMapping]
                                                 inManagedObjectContext:context];
        
        NSError *error = nil;
        if ([context save:&error]) {
            [self.coreDataController save];
        } else {
            NSLog(@"CD Save error - %@", error);
        }
    }];
}

@end
