//
//  TBGravatarLinksBuilderTests.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/9/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "TBBaseTestCase.h"
#import "TBGravatarLinksBuilder.h"

@interface TBGravatarLinksBuilderTests : TBBaseTestCase

@end

@implementation TBGravatarLinksBuilderTests

- (void)testNilHandled
{
    NSURL *avatarURL = [TBGravatarLinksBuilder gravatarUserImageURLWithEmail:nil];
    expect(avatarURL).to.beNil();
}

- (void)testSimpleEmailHashed
{
    NSURL *avatarURL = [TBGravatarLinksBuilder gravatarUserImageURLWithEmail:@"kri.sergy@gmail.com"];
    expect(avatarURL.absoluteString).to.equal(@"http://www.gravatar.com/avatar/29708856e4b8221fb54a5389a6db2d97");
}

- (void)testWhiteSpacesTrimmed
{
    NSURL *avatarURL = [TBGravatarLinksBuilder gravatarUserImageURLWithEmail:@" kri.sergy@gmail.com "];
    expect(avatarURL.absoluteString).to.equal(@"http://www.gravatar.com/avatar/29708856e4b8221fb54a5389a6db2d97");
}

- (void)testCamelCaseHandled
{
    NSURL *avatarURL = [TBGravatarLinksBuilder gravatarUserImageURLWithEmail:@"KrI.seRgy@gMail.com "];
    expect(avatarURL.absoluteString).to.equal(@"http://www.gravatar.com/avatar/29708856e4b8221fb54a5389a6db2d97");
}

@end
