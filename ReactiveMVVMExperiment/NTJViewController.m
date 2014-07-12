//
//  NTJBaseViewController.m
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJViewController.h"

@interface NTJViewController ()

@end

@implementation NTJViewController

#pragma mark Lifecycle

- (id)initWithViewModel:(RVMViewModel *)viewModel
{
	return [self initWithViewModel:viewModel nibName:nil bundle:nil];
}

- (id)initWithViewModel:(RVMViewModel *)viewModel nibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
	self = [super initWithNibName:nibName bundle:bundle];

	if (nil != self) {
        _viewModel = viewModel;

        RACSignal *presented = [[RACSignal
                                 merge:@[
                                         [[self rac_signalForSelector:@selector(viewDidAppear:)] mapReplace:@YES],
                                         [[self rac_signalForSelector:@selector(viewWillDisappear:)] mapReplace:@NO]
                                         ]]
                                setNameWithFormat:@"%@ presented", self];
        
        RACSignal *appActive = [[[RACSignal
                                  merge:@[
                                          [[NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil] mapReplace:@YES],
                                          [[NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationWillResignActiveNotification object:nil] mapReplace:@NO]
                                          ]]
                                 startWith:@YES]
                                setNameWithFormat:@"%@ appActive", self];
        
        RAC(self, viewModel.active) = [[[RACSignal
                                         combineLatest:@[ presented, appActive ]]
                                        and]
                                       setNameWithFormat:@"%@ active", self];
    }

	return self;
}

@end
