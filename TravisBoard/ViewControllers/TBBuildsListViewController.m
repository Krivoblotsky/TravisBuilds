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
#import "TBBuild.h"
#import "TBGravatarLinksBuilder.h"
#import "TBArtworksProvider.h"

@interface TBBuildsListViewController () <NSTableViewDelegate>

/* UI */
@property (nonatomic, weak) IBOutlet NSTableView *tableView;

/* Data */
@property (nonatomic, strong) NSArray *sortDescriptors;
@property (nonatomic, strong) IBOutlet NSArrayController *buildsArrayController;

@property (nonatomic, strong) HCDCoreDataStackController *coreDataController;
@property (nonatomic, strong) TBBuildsLoader *buildsLoader;
@property (nonatomic, strong) TBArtworksProvider *artworksProvider;

@end

@implementation TBBuildsListViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        /* NSArrayController binding */
        _sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"buildNumber" ascending:NO]];
    }
    return self;
}

#pragma mark - Lazy Accessors

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

- (TBArtworksProvider *)artworksProvider
{
    if (!_artworksProvider) {
        _artworksProvider = [TBArtworksProvider defaultProvider];
    }
    return _artworksProvider;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* Download the travis builds */
    [self _downloadBuilds];
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    /* Grab the view from the table */
    TBBuildsListRowView *rowView = [tableView makeViewWithIdentifier:[tableColumn identifier] owner:[tableView delegate]];
    TBBuild *build = [self.buildsArrayController arrangedObjects][row];
    
    /* Setup avatar to the row */
    NSURL *gravatarURL = [TBGravatarLinksBuilder gravatarUserImageURLWithEmail:build.email];
    [self.artworksProvider provideArtworkForURL:gravatarURL withCompletion:^(NSImage *artwork, NSError *error) {
        rowView.contributorImageView.image = artwork;
    }];
    
    return rowView;
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    NSInteger selectedRow = [self.tableView selectedRow];
    if (selectedRow != -1) {
        [self.tableView deselectRow:[self.tableView selectedRow]];
    }
}

#pragma mark - Private

- (void)_downloadBuilds
{
    [self.buildsLoader loadBuilds];
}

@end
