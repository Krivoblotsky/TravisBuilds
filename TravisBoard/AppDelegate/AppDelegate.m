//
//  AppDelegate.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/1/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "AppDelegate.h"
#import "TBContentDownloader.h"
#import "TBLocalFilesManager.h"

@interface AppDelegate ()

@property (nonatomic, strong) TBContentDownloader *c;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    TBLocalFilesManager *filesManager = [TBLocalFilesManager defaultManager];
    


    self.c = [TBContentDownloader defaultDownloader];
    [self.c downloadItemAtURL:[NSURL URLWithString:@"http://a402.idata.over-blog.com/4/68/98/87/windows-8-300x197-1-.png"]
                     localURL:[filesManager.imagesCacheFolder URLByAppendingPathComponent:@"windows.jpeg"]];
}

@end
