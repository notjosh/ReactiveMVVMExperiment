//
//  NTJPersonEditViewController.h
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 12/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJViewController.h"

#import "NTJPersonEditViewModel.h"

@interface NTJPersonEditViewController : NTJViewController

@property (nonatomic, strong, readonly) NTJPersonEditViewModel *viewModel;

@end
