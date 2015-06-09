//
//  TBArtworksProviderTests.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/9/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "TBBaseTestCase.h"
#import "TBArtworksProvider.h"
#import "TBLocalFilesManager.h"
#import "TBContentDownloader.h"

@interface TBArtworksProvider (Testable)

/* Represents current local files manager */
@property (nonatomic, strong) TBLocalFilesManager *diskCacheController;

/* Represents current content downloader */
@property (nonatomic, strong) TBContentDownloader *contentDownloader;

/* Represents current memory cache controller */
@property (nonatomic, strong) NSCache *memoryCacheController;

@end

@interface TBArtworksProviderTests : TBBaseTestCase

@property (nonatomic, strong) id memoryCacheMock;
@property (nonatomic, strong) id diskMemoryMock;
@property (nonatomic, strong) id contenteDownloaderMock;

@end

@implementation TBArtworksProviderTests

- (void)setUp
{
    [super setUp];
    _memoryCacheMock = [OCMockObject mockForClass:[NSCache class]];
    _diskMemoryMock = [OCMockObject mockForClass:[TBLocalFilesManager class]];
    _contenteDownloaderMock = [OCMockObject mockForClass:[TBContentDownloader class]];
}

- (void)tearDown
{
    [super tearDown];
    _memoryCacheMock = nil;
    _diskMemoryMock = nil;
    _contenteDownloaderMock = nil;
}

- (void)testInitialStateSetup
{
    TBArtworksProvider *provider = [[TBArtworksProvider alloc] initWithDiskCacheController:self.diskMemoryMock
                                                                     memoryCacheController:self.memoryCacheMock
                                                                         contentDownloader:self.contenteDownloaderMock];
    expect(provider.diskCacheController).to.equal(self.diskMemoryMock);
    expect(provider.memoryCacheController).to.equal(self.memoryCacheMock);
    expect(provider.contentDownloader).to.equal(self.contenteDownloaderMock);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
