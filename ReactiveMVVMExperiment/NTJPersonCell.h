//
//  NTJPersonCellTableViewCell.h
//  ReactiveMVVMExperiment
//
//  Created by joshua may on 11/07/2014.
//  Copyright (c) 2014 nojo inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NTJPersonViewModel;

@interface NTJPersonCell : UITableViewCell

@property (nonatomic, strong) NTJPersonViewModel *viewModel;

@end
