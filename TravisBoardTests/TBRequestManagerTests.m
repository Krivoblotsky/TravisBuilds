//
//  TBRequestManagerTests.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/3/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "TBBaseTestCase.h"
#import "ZMLTestableRequestManager.h"

@interface TBRequestManagerTests : TBBaseTestCase

@property (nonatomic, strong) id sessionMock;
@property (nonatomic, strong) ZMLTestableRequestManager *testableRequestManager;

@property (nonatomic, strong) NSString *testableEndpoint;
@property (nonatomic, strong) NSDictionary *testableParams;


@end


@implementation TBRequestManagerTests

- (void)setUp
{
    [super setUp];
    
    _sessionMock = [OCMockObject mockForClass:[AFHTTPSessionManager class]];
    _testableRequestManager = [[ZMLTestableRequestManager alloc] initWithSessionManager:_sessionMock];
    
    _testableEndpoint = @"test_endpoint";
    _testableParams = @{@"key":@"value"};
}

- (void)tearDown
{
    [super tearDown];
    _testableRequestManager = nil;
    _sessionMock = nil;
}

- (void)testInstance
{
    ZMLRequestManager *manager = [[ZMLRequestManager alloc] initWithConfiguration:nil];
    expect(manager).toNot.equal(nil);
}

- (void)testGETRequestInvoked
{
    /* Setup */
    [[_sessionMock expect] GET:_testableEndpoint parameters:_testableParams success:[OCMArg any] failure:[OCMArg any]];
    
    /* Run */
    [_testableRequestManager runGETRequestWithEndpoint:_testableEndpoint parameters:_testableParams completion:nil];
    
    /* Verify */
    [_sessionMock verify];
}

- (void)testPOSTRequestInvoked
{
    /* Setup */
    [[_sessionMock expect] POST:_testableEndpoint parameters:_testableParams success:[OCMArg any] failure:[OCMArg any]];
    
    /* Run */
    [_testableRequestManager runPOSTRequestWithEndpoint:_testableEndpoint parameters:_testableParams completion:nil];
    
    /* Verify */
    [_sessionMock verify];
}

- (void)testPUTRequestInvoked
{
    /* Setup */
    [[_sessionMock expect] PUT:_testableEndpoint parameters:_testableParams success:[OCMArg any] failure:[OCMArg any]];
    
    /* Run */
    [_testableRequestManager runPUTRequestWithEndpoint:_testableEndpoint parameters:_testableParams completion:nil];
    
    /* Verify */
    [_sessionMock verify];
}

- (void)testDELETERequestInvoked
{
    /* Setup */
    [[_sessionMock expect] DELETE:_testableEndpoint parameters:_testableParams success:[OCMArg any] failure:[OCMArg any]];
    
    /* Run */
    [_testableRequestManager runDELETERequestWithEndpoint:_testableEndpoint parameters:_testableParams completion:nil];
    
    /* Verify */
    [_sessionMock verify];
}

@end
