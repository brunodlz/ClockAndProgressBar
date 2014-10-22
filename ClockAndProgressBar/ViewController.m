//
//  ViewController.m
//  ClockAndProgressBar
//
//  Created by Bruno on 10/20/14.
//  Copyright (c) 2014 Bruno. All rights reserved.
//

#import "ViewController.h"

int hour = 0;
int minute = 0;

float halfTime = 0;
float rest = 0;

int countTimer = 0;
static double timerInterval = 1.0f;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initWithTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(update) userInfo:nil repeats:YES];
}

- (IBAction)actionStart:(id)sender {
    
    [self.outletStart setAlpha:0.5];
    [self.outletStart setEnabled:NO];
    
    [self getDate];
    
    [self calculateProgress];
    
    [self initWithTimer];
    
}

-(void)update
{
    countTimer++;
//    NSString *strTimer = [self formatDuration:countTimer];
    
    [self progress];
}

- (IBAction)actionStop:(id)sender {
    [self.timer invalidate];
    [self.outletStop setAlpha:0.5];
    [self.outletStop setEnabled:NO];
    [self.outletStart setHidden:YES];
    [self.outletContinue setHidden:NO];
}

- (IBAction)actionContinue:(id)sender {
    [self initWithTimer];
    [self.outletStop setAlpha:1.0];
    [self.outletStop setEnabled:YES];
    [self.outletStart setHidden:NO];
    [self.outletContinue setHidden:YES];
}

- (NSString*)formatDuration:(int)duration
{
    int seconds = duration % 60;
    int minutes = (duration / 60) % 60;
    int hours = duration / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

-(void)calculateProgress
{
    if (hour != 0 && minute != 0)
    {
        halfTime = ( (hour * 3600) / 2 ) + ( ( minute / 2 ) * 60);
        
        rest = ( ( hour * ( 90.0 / 100.0 ) ) * 3600 ) + ( ( minute * ( 90.0 / 100.0 ) ) * 60 );
    }
    else if (hour != 0)
    {
        halfTime = (hour * 3600) / 2;
        
        rest = ( hour * ( 90.0 / 100.0 ) ) * 3600;
    }
    else
    {
        halfTime = ( minute / 2 ) * 60;
        
        rest = ( minute * ( 90.0 / 100.0 ) ) * 60;
    }
}

-(void)validateProgress
{
    if (countTimer >= rest)
    {
        self.outletProgress.tintColor = [UIColor redColor];
    }
    else if (countTimer >= halfTime && halfTime < rest)
    {
        self.outletProgress.tintColor = [UIColor orangeColor];
    }
 
    [self updateProgress];
}

-(void)updateProgress
{
    float fullTime = ( minute * 60 ) + ( hour * 3600 );
    float step = 1.0/countTimer;
    float differenceOfTime = fullTime - countTimer;
    
    float currentTime = ((fullTime - differenceOfTime) + step)/fullTime;
    self.outletProgress.progress = currentTime;
}

-(void)progress
{
    [self validateProgress];
    [self updateProgress];
}

-(void)getDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH"];
    NSString *hourString = [outputFormatter stringFromDate:self.outletDatePicker.date];
    
    hour = [hourString intValue];
    
    [outputFormatter setDateFormat:@"mm"];
    NSString *minuteString = [outputFormatter stringFromDate:self.outletDatePicker.date];
    
    minute = [minuteString intValue];
}

@end
