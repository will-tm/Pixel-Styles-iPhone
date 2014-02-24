//
//  SettingsViewController.h
//  iBeLight 2.0
//
//  Created by William Markezana on 13/08/13.
//  Copyright (c) 2013 Will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMBonjourController.h"
#import "TextStepperField/TextStepperField.h"

@interface SettingsViewController : UITableViewController

@property (nonatomic) WMService *service;
@property (nonatomic) WMServiceMode *mode;
@property (nonatomic, strong) UIImageView *livePreview;

@end
