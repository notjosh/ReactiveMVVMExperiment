//
//  NTJHomeViewModel.h
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "RVMViewModel.h"

@class NTJPerson;
@class NTJPersonEditViewModel;

@interface NTJPersonViewModel : RVMViewModel

@property (nonatomic, strong, readonly) NTJPerson *person;
@property (nonatomic, readonly) NSInteger age;

- (instancetype)initWithPerson:(NTJPerson *)person;

@property (nonatomic, strong, readonly) NTJPersonEditViewModel *editingPerson;

@property (nonatomic, strong, readonly) RACCommand *editPersonCommand;

@end
