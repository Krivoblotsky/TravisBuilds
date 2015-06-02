//
//  ZMLRequestAttachment+Additions.m
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 2/26/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "ZMLRequestAttachment+Additions.h"

@implementation ZMLRequestAttachment (Additions)

+ (EKObjectMapping *)objectMapping
{
    EKObjectMapping *mapping = [EKObjectMapping mappingForClass:[self class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapKeyPath:@"name" toProperty:@"name"];
        [mapping mapKeyPath:@"fileURL" toProperty:@"fileURL" withValueBlock:^id(NSString *key, id value) {
           
            if (![value isKindOfClass:[NSString class]]) {
                return nil;
            }
            return [NSURL URLWithString:value];
            
        } reverseBlock:^id(id value) {
            return [value absoluteString];
        }];
    }];
    return mapping;
}

@end
