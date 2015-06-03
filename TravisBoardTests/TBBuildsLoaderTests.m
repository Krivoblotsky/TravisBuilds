//
//  TBBuildsLoaderTests.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/3/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "TBBuildsLoader.h"
#import "TBBaseTestCase.h"
#import "ZMLRequestManager.h"
#import "TBAPIDefinitions.h"

@interface TBBuildsLoader (Testable)

- (instancetype)initWithCoreDataController:(HCDCoreDataStackController *)coreDataController
                            requestManager:(ZMLRequestManager *)requestManager;

@property (nonatomic, strong) ZMLRequestManager *requestManager;

@end

@interface TBBuildsLoaderTests : TBBaseTestCase

@property (nonatomic, strong) TBBuildsLoader *buildsLoader;
@property (nonatomic, strong) id requestManagerMock;
@property (nonatomic, strong) id coreDataControllerMock;

@end

@implementation TBBuildsLoaderTests

- (void)setUp
{
    [super setUp];

    _requestManagerMock = [OCMockObject mockForClass:[ZMLRequestManager class]];
    _coreDataControllerMock = [OCMockObject mockForClass:[HCDCoreDataStackController class]];
    _buildsLoader = [[TBBuildsLoader alloc] initWithCoreDataController:_coreDataControllerMock requestManager:_requestManagerMock];
}

- (void)tearDown
{
    _coreDataControllerMock = nil;
    _requestManagerMock = nil;
    _buildsLoader = nil;
    [super tearDown];
}

- (void)testInitialSetup
{
    expect(self.buildsLoader.requestManager).to.equal(self.requestManagerMock);
    expect(self.buildsLoader.coreDataController).to.equal(self.coreDataControllerMock);
}

- (void)testRequestCalled
{
    [[self.requestManagerMock expect] runGETRequestWithEndpoint:TBAPIDefinitionsGetBuildsURL parameters:[OCMArg any] completion:[OCMArg any]];
    
    [self.buildsLoader loadBuilds];
    
    [self.requestManagerMock verify];
}

@end
