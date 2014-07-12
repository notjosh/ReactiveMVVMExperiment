//
//  NTJPersonViewController.m
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJPersonViewController.h"

#import "NTJPerson.h"

@interface NTJPersonViewController ()

@end

@implementation NTJPersonViewController

#pragma mark Properties

@dynamic viewModel;

#pragma mark Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

//    @weakify(self);
    
    RAC(self, title) = RACObserve(self.viewModel, person.name);
}

@end
