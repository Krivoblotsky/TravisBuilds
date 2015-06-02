//
//  ZMLDataTransformer.h
//  Zoomlee
//
//  Created by Sergii Kryvoblotskyi on 1/14/15.
//  Copyright (c) 2015 Alterplay. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ZMLDataTransformer : NSManagedObject

/**
 *  Transforms given value of NSString or NSNumber into NSDate
 *
 *  @param value id
 *
 *  @return NSDate or NSNull
 */
+ (NSDate *)dateFromTimeStampValue:(id)value;

/* Reverse */
+ (NSNumber *)timestampFromDateValue:(NSDate *)value;

/**
 *  Transforms given value of NSString or NSNumber into NSNumber
 *
 *  @param value id
 *
 *  @return NSNumber or NSNull
 */
+ (NSNumber *)integerNumberFromValue:(id)value;

/**
 *  Transforms given value of NSString or NSNumber into NSNumber
 *
 *  @param value id
 *
 *  @return NSNumber or NSNull
 */
+ (NSNumber *)boolNumberFromValue:(id)value;

/**
 *  Transforms given value to indemnified json string. Returns "null" if value.lenght == 0
 *
 *  @param value NSString
 *
 *  @return NSString
 */
+ (NSString *)jsonStringFromStringValue:(NSString *)value;

@end
