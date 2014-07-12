//
//  NTJPersonListViewController.h
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJViewController.h"

#import "NTJPersonListViewModel.h"

@interface NTJPersonListViewController : NTJViewController

@property (nonatomic, strong, readonly) NTJPersonListViewModel *viewModel;

@end
