//
//  ForecastIOViewController.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/25.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "ForecastIOViewController.h"

@interface ForecastIOViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ForecastIOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://forecast.io"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
