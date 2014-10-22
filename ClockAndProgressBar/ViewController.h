//
//  ViewController.h
//  ClockAndProgressBar
//
//  Created by Bruno on 10/20/14.
//  Copyright (c) 2014 Bruno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIButton *outletStart;
@property (weak, nonatomic) IBOutlet UIButton *outletStop;
@property (weak, nonatomic) IBOutlet UIButton *outletContinue;
@property (weak, nonatomic) IBOutlet UIProgressView *outletProgress;
@property (weak, nonatomic) IBOutlet UIDatePicker *outletDatePicker;


- (IBAction)actionStart:(id)sender;
- (IBAction)actionStop:(id)sender;
- (IBAction)actionContinue:(id)sender;

@end

