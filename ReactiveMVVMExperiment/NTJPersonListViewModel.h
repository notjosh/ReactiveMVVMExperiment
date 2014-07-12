//
//  NTJPersonListViewModel.h
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "RVMViewModel.h"

#import "NTJPersonViewModel.h"

@interface NTJPersonListViewModel : RVMViewModel

- (instancetype)initWithPeople:(NSArray *)people;

@property (nonatomic, copy, readonly) NSArray *people;
@property (nonatomic, strong, readonly) NTJPersonViewModel *presentedPerson;

@property (nonatomic, strong, readonly) RACCommand *presentPersonCommand;
@property (nonatomic, strong, readonly) RACCommand *removePersonCommand;

@end
