//
//  NTJPersonListViewModel.m
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJPersonListViewModel.h"

#import "NTJPerson.h"
#import "NTJPersonViewModel.h"

@interface NTJPersonListViewModel ()

@property (nonatomic, copy, readwrite) NSArray *people;

@end

@implementation NTJPersonListViewModel

- (instancetype)initWithPeople:(NSArray *)people
{
    self = [super init];

    if (self) {
        @weakify(self);

        RAC(self, people) = [[[[people.rac_sequence.signal
                               map:^(NTJPerson *person) {
                                   return [[NTJPersonViewModel alloc] initWithPerson:person];
                               }]
                              collect]
                              map:^(NSArray *people) {
                                  // FIXME: This doesn't belong here.
                                  return [people sortedArrayUsingComparator:^(NTJPersonViewModel *person1, NTJPersonViewModel *person2) {
                                      return [person1.person.name localizedCaseInsensitiveCompare:person2.person.name];
                                  }];
                              }]
                             deliverOn:RACScheduler.mainThreadScheduler];

        _presentPersonCommand = [[RACCommand alloc]
                                 initWithSignalBlock:^(NTJPerson *person) {
                                     @strongify(self);

                                     return [self.people.rac_sequence.signal
                                             filter:^(NTJPersonViewModel *personViewModel) {
                                                 return [person isEqual:personViewModel.person];
                                             }];
                                 }];

        RAC(self, presentedPerson) = [_presentPersonCommand.executionSignals switchToLatest];

        _removePersonCommand = [[RACCommand alloc]
                                 initWithSignalBlock:^(NTJPerson *person) {
                                     @strongify(self);

                                     self.people = [[self.people.rac_sequence
                                                   filter:^BOOL(NTJPersonViewModel *personViewModel) {
                                                       return ![person isEqual:personViewModel.person];
                                                   }]
                                                   array];

                                     return self.people.rac_sequence.signal;
                                 }];
    }

    return self;
}

@end
