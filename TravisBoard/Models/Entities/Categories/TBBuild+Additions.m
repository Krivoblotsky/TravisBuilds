//
//  TBBuild+Additions.m
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/2/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import "TBBuild+Additions.h"
#import "ZMLDataTransformer.h"

@implementation TBBuild (Additions)

+ (EKManagedObjectMapping *)objectMapping
{
    EKManagedObjectMapping *mapping = [EKManagedObjectMapping mappingForEntityName:NSStringFromClass([self class])
                                                                         withBlock:^(EKManagedObjectMapping *mapping)
                                       {
                                           [mapping mapKeyPath:@"name" toProperty:@"name"];
                                           [mapping mapKeyPath:@"remote_id" toProperty:@"remoteId" withValueBlock:^id(NSString *key, id value, NSManagedObjectContext *context) {
                                               return [ZMLDataTransformer integerNumberFromValue:value];
                                           }];
                                           [mapping mapKeyPath:@"color" toProperty:@"color"];
                                           [mapping mapKeyPath:@"email" toProperty:@"email"];
                                           [mapping mapKeyPath:@"commit_message" toProperty:@"commitMessage"];
                                           [mapping mapKeyPath:@"build_url" toProperty:@"buildUrl"];
                                           [mapping mapKeyPath:@"build_number" toProperty:@"buildNumber"];
                                       }];
    [mapping mapPropertiesFromMappingObject:[super objectMapping]];
    mapping.primaryKey = @"remoteId";
    return mapping;
}

@end
