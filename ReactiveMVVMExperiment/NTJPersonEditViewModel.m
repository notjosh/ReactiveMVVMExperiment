//
//  NTJPersonEditViewModel.m
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 12/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJPersonEditViewModel.h"

@implementation NTJPersonEditViewModel

- (instancetype)initWithPerson:(NTJPerson *)person
{
    self = [super init];
    if (self) {
        _person = person;
    }
    return self;
}

@end
