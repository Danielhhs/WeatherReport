//
//  ForecastSearchTableViewController.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/20.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "ForecastSearchTableViewController.h"
#import "LocationHelper.h"
#import "SessionManager.h"
#import "WeatherDetailViewControllerTableViewController.h"
#import "Enums.h"
#import "ActivityMaskView.h"
@interface ForecastSearchTableViewController ()<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *degreeSegment;

@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic) WeatherSearchMode searchMode;
@property (nonatomic, strong) NSString *state;

@property (nonatomic, strong) NSData *weatherData;
@end

@implementation ForecastSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.streetTextField.delegate = self;
    self.cityTextField.delegate = self;
    self.statePicker.dataSource = self;
    self.statePicker.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeAllTextFieldsResignFirstResponder)];
    [self.view addGestureRecognizer:tap];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

- (IBAction)degreeChanged:(id)sender {
    self.searchMode = self.degreeSegment.selectedSegmentIndex;
}

- (IBAction)handleClear:(id)sender {
    self.streetTextField.text = @"";
    self.cityTextField.text = @"";
    [self.streetTextField resignFirstResponder];
    [self.cityTextField resignFirstResponder];
    [self.statePicker selectRow:0 inComponent:0 animated:YES];
    self.degreeSegment.selectedSegmentIndex = 0;
    self.street = @"";
    self.city = @"";
    self.state = [LocationHelper states][0];
    self.searchMode = WeatherSearchModeFahrenheit;
}

- (IBAction)handleSearch:(id)sender {
    [self makeAllTextFieldsResignFirstResponder];
    [ActivityMaskView showActivityIndicatorInViewController:self];
    [[SessionManager sharedManager] searchWeatherForAddress:self.street
                                                       city:self.city
                                                      state:self.state
                                                 searchMode:self.searchMode
     success:^(NSData *weatherData) {
         dispatch_async(dispatch_get_main_queue(), ^{
             [ActivityMaskView hideAcitivityIndicator];
             self.weatherData = weatherData;
             [self performSegueWithIdentifier:@"WeatherDetail" sender:self];
         });
     } failure:^(NSString *errorMessage) {
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
         [self presentViewController:alert animated:YES completion:nil];
     }];
}

- (void) makeAllTextFieldsResignFirstResponder
{
    [self.streetTextField resignFirstResponder];
    [self.cityTextField resignFirstResponder];
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
    self.state = [LocationHelper states][row];
}

#pragma mark - UITextFieldDelegate
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    self.city = self.cityTextField.text;
    self.street = self.streetTextField.text;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"WeatherDetail"]) {
        if ([segue.destinationViewController isKindOfClass:[WeatherDetailViewControllerTableViewController class]]) {
            WeatherDetailViewControllerTableViewController *weatherDetail = (WeatherDetailViewControllerTableViewController *)segue.destinationViewController;
            weatherDetail.searchMode = self.searchMode;
            weatherDetail.city = self.city;
            weatherDetail.state = self.state;
            weatherDetail.weatherData = self.weatherData;
        }
    }
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self makeAllTextFieldsResignFirstResponder];
}
@end
