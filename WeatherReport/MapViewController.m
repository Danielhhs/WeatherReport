//
//  MapViewController.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/24.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "MapViewController.h"
#import <Aeris/Aeris.h>
#import <AerisUI/AerisUI.h>
#import <AerisMap/AerisMap.h>
#import "ContainerViewControllerHelper.h"
@interface MapViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AerisEngine engineWithKey:@"YedWM9BFlFGbmWFUvr261" secret:@"81szJaHg7hvHYJ8vKS75jmS6Z8kAfNQqsZjbVxcs"];
    AWFWeatherMapConfig *mapConfig = [AWFWeatherMapConfig config];
    AWFWeatherMapViewController *weatherMapController = [[AWFWeatherMapViewController alloc] initWithNibName:nil bundle:nil];
    weatherMapController.weatherMapType = AWFWeatherMapTypeApple;
    weatherMapController.config = mapConfig;
    [ContainerViewControllerHelper addChildViewController:weatherMapController toParentViewController:self inContainerView:self.containerView contentArea:self.containerView.bounds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
