//
//  NTJBaseViewController.h
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RVMViewModel;

@interface NTJViewController : UIViewController

// The view model for the receiver.
@property (nonatomic, strong, readonly) RVMViewModel *viewModel;

// Initializes the receiver with a view model, and without a nib.
- (id)initWithViewModel:(RVMViewModel *)viewModel;

// Initializes the receiver with a view model, and optionally a nib and bundle.
//
// This is the designated initializer for this class.
- (id)initWithViewModel:(RVMViewModel *)viewModel nibName:(NSString *)nibName bundle:(NSBundle *)bundle;

@end
