//
//  StatePickerViewController.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/24.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "StatePickerViewController.h"
#import "LocationHelper.h"
@interface StatePickerViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSString *selectedState;

@end

@implementation StatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    // Do any additional setup after loading the view.
}

#pragma mark - UIPickerViewDatasource
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[LocationHelper states] count];
}

#pragma mark - UIPickerViewDelegate
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [LocationHelper states][row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedState = [LocationHelper states][row];
}

- (IBAction)cancelTapped:(id)sender {
    [self.delegate statePickerDidCancel];
}

- (IBAction)doneTapped:(id)sender {
    [self.delegate statePickerDidPickState:self.selectedState];
}

@end
