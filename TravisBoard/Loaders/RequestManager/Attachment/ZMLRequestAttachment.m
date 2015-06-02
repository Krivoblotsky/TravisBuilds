//
//  ZMLRequestAttachment.m
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 2/25/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "ZMLRequestAttachment.h"

@interface ZMLRequestAttachment ()

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSURL *fileURL;

@end

@implementation ZMLRequestAttachment

+ (instancetype)attachmentWithName:(NSString *)name fileURL:(NSURL *)fileURL
{
    return [[self alloc] initWithName:name fileURL:fileURL];
}

- (instancetype)initWithName:(NSString *)name fileURL:(NSURL *)fileURL
{
    self = [super init];
    if (self) {
        _name = name;
        _fileURL = fileURL;
    }
    return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    ZMLRequestAttachment *copy = [[[self class] alloc] init];
    if (copy) {
        copy.fileURL = [self.fileURL copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    return copy;
}

@end
