//
//  TBBuild.h
//  TravisBoard
//
//  Created by Sergii Kryvoblotskyi on 6/2/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <EasyMapping/EasyMapping.h>

@interface TBBuild : EKManagedObjectModel

@property (nonatomic, retain) NSNumber * remoteId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * buildNumber;
@property (nonatomic, retain) NSString * color;

@end
