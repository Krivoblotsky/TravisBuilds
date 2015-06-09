//
//  TBBuildsListRowView.h
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/1/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TBHexToColorTransformer.h"
#import "TBBackgroundColorView.h"

@interface TBBuildsListRowView : NSTableCellView

@property (weak, nonatomic) IBOutlet NSTextField *buildColorLabel;
@property (weak, nonatomic) IBOutlet TBBackgroundColorView *backgroundColorView;
@property (weak, nonatomic) IBOutlet NSImageView *contributorImageView;

@end
