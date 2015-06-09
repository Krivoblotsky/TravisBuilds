//
//  TBBuildsArrayController.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/9/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBBuildsArrayController.h"

@implementation TBBuildsArrayController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _initialSetup];
    }
    return self;
}

- (instancetype)initWithContent:(id)content
{
    self = [super initWithContent:content];
    if (self) {
        [self _initialSetup];
    }
    return self;
}

#pragma mark - Private

- (void)_initialSetup
{
    self.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"buildNumber" ascending:NO]];
}

@end
