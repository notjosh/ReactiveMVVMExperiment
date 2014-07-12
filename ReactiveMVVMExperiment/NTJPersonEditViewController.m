//
//  NTJPersonEditViewController.m
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 12/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJPersonEditViewController.h"

#import "NTJPersonEditViewModel.h"
#import "NTJPerson.h"

#import "UITextField+RACKeyboardSupport.h"
#import "UIControl+RACSignalSupport.h"

@interface NTJPersonEditViewController ()

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UIDatePicker *dateOfBirthDatePicker;
@property (nonatomic, weak) IBOutlet UILabel *ageLabel;

@end

@implementation NTJPersonEditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    
    self.title = @"Edit";

    RAC(self, dateOfBirthDatePicker.date) = RACObserve(self.viewModel, person.dateOfBirth);
    RAC(self, ageLabel.text) = [RACObserve(self.viewModel, person.dateOfBirth)
                                map:^(NSDate *dateOfBirth) {
                                    NSCalendar *calendar = [NSCalendar currentCalendar];
                                    NSCalendarUnit calendarUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

                                    NSDateComponents *components = [calendar components:calendarUnits
                                                                               fromDate:dateOfBirth
                                                                                 toDate:[NSDate date]
                                                                                options:0];

                                    return [NSString stringWithFormat:@"%dy %dm %dd", components.year, components.month, components.day];
                                }];

    // bidirectional text binding
    RACChannelTerminal *textFieldTerminal = [self.nameTextField rac_newTextChannel];
    RACChannelTerminal *modelTerminal = RACChannelTo(self.viewModel, person.name);
    [modelTerminal subscribe:textFieldTerminal];
    [[textFieldTerminal skip:1] subscribe:modelTerminal];

    [[self.nameTextField rac_keyboardReturnSignal] subscribeNext:^(UITextField *textField) {
        [textField resignFirstResponder];
    }];

    [[self.dateOfBirthDatePicker rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UIDatePicker *datePicker) {
        @strongify(self);
        [self.nameTextField resignFirstResponder];
        self.viewModel.person.dateOfBirth = datePicker.date;
    }];
}

@end
