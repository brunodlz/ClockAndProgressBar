//
//  ViewController.m
//  ClockAndProgressBar
//
//  Created by Bruno on 10/20/14.
//  Copyright (c) 2014 Bruno. All rights reserved.
//

#import "ViewController.h"

#define CARACTER                @"."
#define NUMERIC                 @"1234567890"

int countTimer = 0;
static double timerInterval = 1.0f;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.outletPeriod.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initWithTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}

- (IBAction)actionStart:(id)sender {
    
    if ([self validateHour]) {
        [self.outletStart setAlpha:0.5];
        [self.outletStart setEnabled:NO];
        [self.outletPeriod setEnabled:NO];
        
        [self initWithTimer];
    }
    
}

-(void)updateProgress
{
    countTimer++;
    NSString *strTimer = [self formatDuration:countTimer];
    self.outletTimeLeft.text = strTimer;
    
    [self calculateProgress];
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
    float minute = 5;
    
    float metadeMinuto = ( minute / 2 ) * 60;
    
    float restante = ( minute * ( 90.0 / 100.0 ) ) * 60;
    
    if (countTimer >= restante)
    {
        self.outletProgress.tintColor = [UIColor redColor];
    }
    else if (countTimer >= metadeMinuto && metadeMinuto < restante)
    {
        self.outletProgress.tintColor = [UIColor orangeColor];
    }
 
    //update progress
    float fullTime = minute * 60;
    float step = 1.0/countTimer;
    float differenceOfTime = fullTime - countTimer;
    
    float currentTime = ((fullTime - differenceOfTime) + step)/fullTime;
    self.outletProgress.progress = currentTime;
    
}

-(BOOL)validateHour{
    NSString *hourRegex = @"([01]?[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]";
    NSPredicate *hourTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", hourRegex];
    
    BOOL teste = [hourTest evaluateWithObject:self.outletPeriod.text];
    
    return teste;
}

@end
