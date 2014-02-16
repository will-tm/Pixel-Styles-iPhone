//
//  TouchViewController.m
//  iBeLight 2.0
//
//  Created by William Markezana on 15/08/13.
//  Copyright (c) 2013 Will. All rights reserved.
//

#import "TouchViewController.h"

@interface TouchViewController ()

@end

@implementation TouchViewController

- (void)setServices:(NSArray *)services
{
    _services = services;
    if (services != nil && services.count) {
        _service = services[0];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdateLivePreview:) name:@"didUpdateLivePreview" object:nil];
}

- (void)setMode:(WMServiceMode *)mode
{
    _mode = mode;
    [self.tableView reloadData];
}

- (void)didUpdateLivePreview:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    _livePreview.image = [userInfo objectForKey:@"image"];
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _livePreview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10.0)];
    return _livePreview;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TouchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
    UIView *contentView = [cell viewWithTag:40];
    SpectrumView *view = (SpectrumView*)[contentView viewWithTag:50];
    [view becomeFirstResponder];
    [view setDelegate:self];
    
    return cell;
}

- (void)spectrumViewGotColorStringReady:(NSString*)colorString
{
    for (WMService *service in _services) {
        if (service.connected) {
            for (WMServiceMode *mode in service.modes) {
                if ([mode.name isEqualToString: _mode.name]) {
                    [mode sendTouchEvent:colorString];
                }
            }
        }
    }
    //[_mode sendTouchEvent:colorString];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end