//
//  NTJPersonViewController.m
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJPersonViewController.h"

#import "NTJPersonEditViewController.h"

#import "NTJPerson.h"

@interface NTJPersonViewController ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateOfBirthLabel;
@property (nonatomic, weak) IBOutlet UIButton *editButton;

@end

@implementation NTJPersonViewController

#pragma mark Properties

@dynamic viewModel;

#pragma mark Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    @weakify(self);

    RAC(self, title) = RACObserve(self.viewModel, person.name);
    RAC(self, nameLabel.text) = RACObserve(self.viewModel, person.name);
    RAC(self, dateOfBirthLabel.text) = [RACObserve(self.viewModel, person.dateOfBirth)
                                 map:^(NSDate *date) {
                                     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                     formatter.dateStyle = NSDateFormatterMediumStyle;
                                     formatter.timeStyle = NSDateFormatterNoStyle;

                                     return [formatter stringFromDate:date];
                                 }];

    // respond to button tap
    self.editButton.rac_command = self.viewModel.editPersonCommand;
    
    // respond to the ViewModel telling us there's a person to present
    [[[[RACObserve(self.viewModel, editingPerson)
        ignore:nil]
       map:^(NTJPersonEditViewModel *viewModel) {
           return [[NTJPersonEditViewController alloc] initWithViewModel:viewModel];
       }]
      deliverOn:[RACScheduler mainThreadScheduler]
      ]
     subscribeNext:^(NTJPersonEditViewController *viewController) {
         @strongify(self);
         [self.navigationController pushViewController:viewController
                                              animated:YES];
     }];
}

@end
