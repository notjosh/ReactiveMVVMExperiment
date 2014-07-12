//
//  NTJAppDelegate.m
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJAppDelegate.h"

#import "NTJPerson.h"
#import "NSDate+NTJAdditions.h"

#import "NTJPersonListViewController.h"
#import "NTJPersonListViewModel.h"

@implementation NTJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
	self.window.backgroundColor = UIColor.whiteColor;
    
    NSMutableArray *people = [NSMutableArray array];
    NTJPerson *person;

    person = [[NTJPerson alloc] init];
    person.name = @"Joshua May";
    person.dateOfBirth = [NSDate ntj_dateWithYear:1984 month:2 day:29];
    [people addObject:person];

    person = [[NTJPerson alloc] init];
    person.name = @"Eugenio Marletti";
    person.dateOfBirth = [NSDate ntj_dateWithYear:1985 month:3 day:18];
    [people addObject:person];

    person = [[NTJPerson alloc] init];
    person.name = @"Harry Houdini";
    person.dateOfBirth = [NSDate ntj_dateWithYear:1947 month:1 day:1];
    [people addObject:person];

	NTJPersonListViewModel *viewModel = [[NTJPersonListViewModel alloc] initWithPeople:people.copy];
	NTJPersonListViewController *listViewController = [[NTJPersonListViewController alloc] initWithViewModel:viewModel];
    
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:listViewController];
    
	self.window.rootViewController = navigationController;
	[self.window makeKeyAndVisible];
    
	return YES;
}

@end
