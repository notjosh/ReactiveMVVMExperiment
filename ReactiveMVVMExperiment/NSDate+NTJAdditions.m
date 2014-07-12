//
//  NSDate+NTJAdditions.m
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 12/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NSDate+NTJAdditions.h"

@implementation NSDate (NTJAdditions)

+ (NSDate *)ntj_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [calendar dateFromComponents:components];
}

@end
