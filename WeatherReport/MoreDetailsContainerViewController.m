//
//  MoreDetailsContainerViewController.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/23.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "MoreDetailsContainerViewController.h"

@interface MoreDetailsContainerViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *detailLevelSegment;

@end

@implementation MoreDetailsContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)detailLevelChanged:(id)sender {
}

@end
