//
//  ZMLRequestAttachment.h
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 2/25/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EasyMapping/EasyMapping.h>

@interface ZMLRequestAttachment : EKObjectModel <NSCopying>

/**
 *  Instantiates attachment with name and file url
 *
 *  @param name    NSString
 *  @param fileURL NSURL
 *
 *  @return ZMLRequestAttachment
 */
+ (instancetype)attachmentWithName:(NSString *)name fileURL:(NSURL *)fileURL;

/**
 *  Represents name
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 *  Represents file URL
 */
@property (nonatomic, copy, readonly) NSURL *fileURL;

@end
