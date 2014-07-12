//
//  NTJPersonCellTableViewCell.m
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import "NTJPersonCell.h"

#import "NTJPersonViewModel.h"
#import "NTJPerson.h"

@implementation NTJPersonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        RAC(self.textLabel, text) = RACObserve(self, viewModel.person.name);
        RAC(self.detailTextLabel, text) = RACObserve(self, viewModel.age);

        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	return self;
}

@end
