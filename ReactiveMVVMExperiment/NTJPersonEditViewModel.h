//
//  NTJPersonEditViewModel.h
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 12/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "RVMViewModel.h"

@class NTJPerson;

@interface NTJPersonEditViewModel : RVMViewModel

@property (nonatomic, strong, readonly) NTJPerson *person;

- (instancetype)initWithPerson:(NTJPerson *)person;

@end
