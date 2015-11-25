//
//  StatePickerViewController.h
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/24.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StatePickerViewControllerDelegate
- (void) statePickerDidPickState:(NSString *)state;
- (void) statePickerDidCancel;
@end
@interface StatePickerViewController : UIViewController
@property (nonatomic, weak) id<StatePickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *currentState;
@end
