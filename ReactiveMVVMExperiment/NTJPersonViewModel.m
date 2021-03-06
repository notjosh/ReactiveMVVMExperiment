//
//  NTJHomeViewModel.m
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJPersonViewModel.h"

#import "NTJPersonEditViewModel.h"

#import "NTJPerson.h"

@implementation NTJPersonViewModel

- (instancetype)initWithPerson:(NTJPerson *)person
{
    self = [super init];

    if (self) {
        _person = person;

        @weakify(self)

        // TODO: observe UIApplicationSignificantTimeChangeNotification in case their birthday ticks to 12:00 while the screen is open!
        RACSignal *dateOfBirth = RACObserve(self.person, dateOfBirth);
        RAC(self, age) = [dateOfBirth
                          map:^(NSDate *dateOfBirth) {
                              NSCalendar *calendar = [NSCalendar currentCalendar];
                              NSCalendarUnit calendarUnits = NSCalendarUnitYear;

                              NSDateComponents *components = [calendar components:calendarUnits
                                                                       fromDate:dateOfBirth
                                                                         toDate:[NSDate date]
                                                                        options:0];

                              return @(components.year);
                          }];

        _editPersonCommand = [[RACCommand alloc]
                                 initWithSignalBlock:^(id _) {
                                     @strongify(self);

                                     id viewModel = [[NTJPersonEditViewModel alloc] initWithPerson:self.person];
                                     return [RACSignal return:viewModel];
                                 }];
        
        RAC(self, editingPerson) = [_editPersonCommand.executionSignals switchToLatest];
    }

    return self;
}

@end
