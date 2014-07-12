//
//  NTJPerson.m
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJPerson.h"

@implementation NTJPerson

#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@ dateOfBirth:%@", self.name, self.dateOfBirth];
}

- (NSUInteger)hash
{
	return self.name.hash;
}

- (BOOL)isEqual:(NTJPerson *)person
{
	if (self == person) {
        return YES;
    }

	if (![person isKindOfClass:NTJPerson.class]) {
        return NO;
    }
    
	return NSOrderedSame == [self.name caseInsensitiveCompare:person.name];
}

@end
