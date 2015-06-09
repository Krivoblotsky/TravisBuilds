//
//  TBBuildsListRowView.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/1/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBBuildsListRowView.h"

@interface TBBuildsListRowView ()

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
