//
//  NTJPersonListViewController.m
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJPersonListViewController.h"

#import "NTJPersonViewController.h"

#import "NTJPersonViewModel.h"
#import "NTJPersonCell.h"

@interface NTJPersonListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation NTJPersonListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);

    [self.tableView registerClass:NTJPersonCell.class forCellReuseIdentifier:NSStringFromClass(NTJPersonCell.class)];

    // navigation title showing "n people"
    RAC(self, title) = [RACObserve(self.viewModel, people)
                        map:^(NSArray *people) {
                            if (1 == people.count) {
                                return @"1 person";
                            } else {
                                return [NSString stringWithFormat:@"%u people", people.count];
                            }
                        }];

    // reload table when people list changes
	[[RACObserve(self.viewModel, people)
      distinctUntilChanged]
     subscribeNext:^(id _) {
         @strongify(self);
         [self.tableView reloadData];
     }];

    // respond to row selection
    [[self rac_signalForSelector:@selector(tableView:willSelectRowAtIndexPath:)]
     subscribeNext:^(RACTuple *args) {
         @strongify(self);
         NSIndexPath *indexPath = args.second;
         NTJPersonViewModel *person = self.viewModel.people[indexPath.row];
         [self.viewModel.presentPersonCommand execute:person.person];
     }];

    // respond to the ViewModel telling us there's a person to present
    [[[[RACObserve(self.viewModel, presentedPerson)
        ignore:nil]
       map:^(NTJPersonViewModel *viewModel) {
           return [[NTJPersonViewController alloc] initWithViewModel:viewModel];
       }]
      deliverOn:[RACScheduler mainThreadScheduler]
      ]
     subscribeNext:^(NTJPersonViewController *viewController) {
         @strongify(self);
         [self.navigationController pushViewController:viewController
                                              animated:YES];
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return (NSInteger)self.viewModel.people.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NTJPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(NTJPersonCell.class) forIndexPath:indexPath];
	cell.viewModel = self.viewModel.people[indexPath.row];
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSParameterAssert(editingStyle == UITableViewCellEditingStyleDelete);
    
	NTJPersonViewModel *person = self.viewModel.people[indexPath.row];
	[self.viewModel.removePersonCommand execute:person.person];
}

#pragma mark - UITableViewDelegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
