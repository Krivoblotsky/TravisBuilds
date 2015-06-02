//
//  TBBuildsListViewController.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/1/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBBuildsListViewController.h"
#import "TBBuildsListRowView.h"
#import <HardCoreData/HCDCoreDataStackController.h>
#import "TBBuildsLoader.h"

@interface TBBuildsListViewController ()

/* UI */
@property (nonatomic, weak) IBOutlet NSTableView *tableView;

/* Data */
@property (nonatomic, strong) IBOutlet NSArrayController *buildsArrayController;
@property (nonatomic, strong) HCDCoreDataStackController *coreDataController;
@property (nonatomic, strong) TBBuildsLoader *buildsLoader;
@property (nonatomic, strong) NSArray *sortDescriptors;

@end

@implementation TBBuildsListViewController

#pragma mark - Accessors

- (HCDCoreDataStackController *)coreDataController
{
    if (!_coreDataController) {
        HCDCoreDataStack *stack = [HCDCoreDataStack sqliteStackWithName:@"TBTravisBoard"];
        _coreDataController = [HCDCoreDataStackController controllerWithStack:stack];
    }
    return _coreDataController;
}

- (TBBuildsLoader *)buildsLoader
{
    if (!_buildsLoader) {
        _buildsLoader = [TBBuildsLoader loaderWithCoreDataController:self.coreDataController];
    }
    return _buildsLoader;
}

- (NSArray *)sortDescriptors
{
    if (!_sortDescriptors) {
        _sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"buildNumber" ascending:NO]];
    }
    return _sortDescriptors;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self _loadBuilds];
}

#pragma mark - Private

- (void)_loadBuilds
{
    [self.buildsLoader loadBuilds];
}

@end
