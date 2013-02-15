//
//  JMFirstViewController.m
//  Pomodoro
//
//  Created by Jorge Maroto Garcia on 15/2/13.
//  Copyright (c) 2013 Tactilapp.com. All rights reserved.
//

#import "JMFirstViewController.h"

@interface JMFirstViewController ()

@end

@implementation JMFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
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

@end
