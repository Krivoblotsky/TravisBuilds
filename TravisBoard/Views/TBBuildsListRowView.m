//
//  TBBuildsListRowView.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/1/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBBuildsListRowView.h"
#import "TBHexToColorTransformer.h"
#import "TBBackgroundColorView.h"

@interface TBBuildsListRowView ()

@property (weak, nonatomic) IBOutlet NSTextField *buildColorLabel;
@property (weak, nonatomic) IBOutlet TBBackgroundColorView *backgroundColorView;
@property (weak, nonatomic) IBOutlet NSImageView *contributorImageView;

@end

@implementation TBBuildsListRowView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    /* Bind background color */
    [self.backgroundColorView bind:@"backgroundColor"
                          toObject:self
                       withKeyPath:@"objectValue.color"
                           options:@{NSValueTransformerBindingOption:[TBHexToColorTransformer new]}];
}


@end
