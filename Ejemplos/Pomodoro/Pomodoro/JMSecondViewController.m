//
//  JMSecondViewController.m
//  Pomodoro
//
//  Created by Jorge Maroto Garcia on 15/2/13.
//  Copyright (c) 2013 Tactilapp.com. All rights reserved.
//

#import "JMSecondViewController.h"
#import "JMAppDelegate.h"

@interface JMSecondViewController ()

@end

@implementation JMSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Configuración";
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settearTiempo:(UIButton *)sender {
    JMAppDelegate *delegate = (JMAppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.tiempo = [NSNumber numberWithInt:sender.tag];
}


@end
