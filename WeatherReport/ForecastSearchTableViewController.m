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
#import "StatePickerViewController.h"
#import "ContainerViewControllerHelper.h"
#import "ForecastIOViewController.h"
#import "AboutViewController.h"

@interface ForecastSearchTableViewController ()<UITextFieldDelegate, StatePickerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *degreeSegment;
@property (weak, nonatomic) IBOutlet UIButton *stateButton;

@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic) WeatherSearchMode searchMode;
@property (nonatomic, strong) NSString *state;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *clearButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (nonatomic, strong) StatePickerViewController *statePicker;
@property (nonatomic, strong) NSData *weatherData;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation ForecastSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.streetTextField.delegate = self;
    self.cityTextField.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeAllTextFieldsResignFirstResponder)];
    [self.view addGestureRecognizer:tap];
    
    UIButton *forecastIcon = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 167 - 20, 400, 167, 50)];
    [forecastIcon setImage:[UIImage imageNamed:@"forecast_logo.png"] forState:UIControlStateNormal];
    [forecastIcon addTarget:self action:@selector(goToForecastWebsite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forecastIcon];
    
    UIButton *aboutButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, 50, 30)];
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"ABOUT" attributes:@{NSFontAttributeName : [UIFont fontWithName:@"ChalkboardSE-Regular" size:20]}];
    [aboutButton setAttributedTitle:title forState:UIControlStateNormal];
    [aboutButton sizeToFit];
    [aboutButton addTarget:self action:@selector(goToAboutPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aboutButton];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

- (IBAction)degreeChanged:(id)sender {
    self.searchMode = self.degreeSegment.selectedSegmentIndex;
    [LocationHelper setSearchMode:self.searchMode];
}

- (IBAction)handleClear:(id)sender {
    self.streetTextField.text = @"";
    self.cityTextField.text = @"";
    [self.streetTextField resignFirstResponder];
    [self.cityTextField resignFirstResponder];
    self.degreeSegment.selectedSegmentIndex = 0;
    self.street = @"";
    self.city = @"";
    self.state = @"";
    [self.stateButton setTitle:@"Select" forState:UIControlStateNormal];
    self.searchMode = WeatherSearchModeFahrenheit;
}

- (IBAction)handleSearch:(id)sender {
    [self makeAllTextFieldsResignFirstResponder];
    if (![self validateFormValues]) {
        return ;
    }
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

- (BOOL) validateFormValues
{
    if ([self isEmptyString:[self.streetTextField text]]) {
        [self showAlertWithErrorMessage: @"Street value should not be empty."];
        return NO;
    } else if ([self isEmptyString:[self.cityTextField text]]) {
        [self showAlertWithErrorMessage:@"City value should not be empty."];
        return NO;
    } else if ([[self.stateButton currentTitle] isEqualToString:@"Select"]) {
        [self showAlertWithErrorMessage:@"State value should not be empty."];
        return NO;
    }
    return YES;
}

- (BOOL) isEmptyString:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [string length] == 0;
}

- (void) showAlertWithErrorMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) goToForecastWebsite
{
    ForecastIOViewController *forecastIOViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ForecastIOViewController"];
    [self.navigationController pushViewController:forecastIOViewController animated:YES];
}

- (void) goToAboutPage
{
    AboutViewController *aboutViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutViewController"];
    [self.navigationController pushViewController:aboutViewController animated:YES];
}

- (void) makeAllTextFieldsResignFirstResponder
{
    [self.streetTextField resignFirstResponder];
    [self.cityTextField resignFirstResponder];
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

#pragma mark - StatePickerViewController
- (UIView *) maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor colorWithWhite:0.382 alpha:0.618];
        _maskView.alpha = 0;
    }
    return _maskView;
}

- (IBAction)selectState:(id)sender {
    [self makeAllTextFieldsResignFirstResponder];
    self.clearButton.enabled = NO;
    self.searchButton.enabled = NO;
    self.statePicker.currentState = [self.stateButton currentTitle];
    [self.view addSubview:self.maskView];
    [ContainerViewControllerHelper addChildViewController:self.statePicker toParentViewController:self inContainerView:self.view contentArea:CGRectMake(0, self.view.bounds.size.height - 300, self.view.bounds.size.width, 300)];
    self.statePicker.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 300);
    [UIView animateWithDuration:0.382 animations:^{
        self.maskView.alpha = 1.f;
        self.statePicker.view.transform = CGAffineTransformIdentity;
    }];
}

- (StatePickerViewController *) statePicker
{
    if (!_statePicker) {
        _statePicker = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"StatePickerViewController"];
        _statePicker.delegate = self;
    }
    return _statePicker;
}

- (void) statePickerDidPickState:(NSString *)state
{
    self.state = state;
    [self.stateButton setTitle:state forState:UIControlStateNormal];
    [self hideStatePicker];
}

- (void) statePickerDidCancel
{
    [self hideStatePicker];
}

- (void) hideStatePicker
{
    [UIView animateWithDuration:0.382 animations:^{
        self.maskView.alpha = 0.f;
        self.statePicker.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 256);
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [ContainerViewControllerHelper removeChildViewController:self.statePicker];
        self.statePicker.view.transform = CGAffineTransformIdentity;
        self.clearButton.enabled = YES;
        self.searchButton.enabled = YES;
    }];
}
@end
