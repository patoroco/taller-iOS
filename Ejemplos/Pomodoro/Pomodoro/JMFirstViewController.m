//
//  JMFirstViewController.m
//  Pomodoro
//
//  Created by Jorge Maroto Garcia on 15/2/13.
//  Copyright (c) 2013 Tactilapp.com. All rights reserved.
//

#import "JMFirstViewController.h"
#import "JMAppDelegate.h"

@interface JMFirstViewController (){
    BOOL contando;
}
@property (weak, nonatomic) IBOutlet UILabel *labelTiempo;

@end

@implementation JMFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Pomodoro";
        contando = false;
    }
    return self;
}

- (IBAction)iniciarCuentaAtras:(id)sender {
    contando = true;
    [self cuentraAtras];
}

- (IBAction)parar:(id)sender {
    JMAppDelegate *delegate = (JMAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.labelTiempo.text = [NSString stringWithFormat:@"%@ segs.", delegate.tiempo];
    contando = false;
}


-(void)cuentraAtras{
    JMAppDelegate *delegate = (JMAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (contando && delegate.tiempo.intValue > 0){
        self.labelTiempo.text = [NSString stringWithFormat:@"%@ segs.", delegate.tiempo];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(cuentraAtras) userInfo:nil repeats:NO];
        int nuevoTiempo = delegate.tiempo.intValue - 1;
        delegate.tiempo = [NSNumber numberWithInt:nuevoTiempo];
    }else if (contando && delegate.tiempo.intValue == 0){
        contando = false;
        self.labelTiempo.text = @"FIN";
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Pomodoro" message:@"Se ha acabado el tiempo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerta show];
        delegate.tiempo = @5;
    }
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
