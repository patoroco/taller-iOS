//
//  JMViewController.m
//  Twitter
//
//  Created by Jorge Maroto Garcia on 15/2/13.
//  Copyright (c) 2013 Tactilapp.com. All rights reserved.
//

#import "JMViewController.h"
#import <Social/Social.h>
#import "JMDetalleViewController.h"

@interface JMViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tabla;
    @property (nonatomic, strong) NSArray *twits;
@end

@implementation JMViewController


-(void)getTimeLine {
    NSURL *requestURL = [NSURL URLWithString:@"http://search.twitter.com/search.json"];

    NSDictionary *parameters = @{@"q":@"cylicon_valley"};

    SLRequest *postRequest = [SLRequest
                           requestForServiceType:SLServiceTypeTwitter
                           requestMethod:SLRequestMethodGET
                           URL:requestURL parameters:parameters];
    [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSDictionary *respuesta = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
        self.twits = respuesta[@"results"];
        if (self.twits.count != 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
              [self.tabla reloadData];
            });
        }
    }];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self getTimeLine];
}

#pragma mark - Table Delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.twits.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
    
    NSDictionary *tweet = self.twits[indexPath.row];
    cell.textLabel.text = tweet[@"from_user"];
    cell.detailTextLabel.text = tweet[@"text"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *tweet = self.twits[indexPath.row];
    
    JMDetalleViewController *controlador = [[JMDetalleViewController alloc] init];
    [self.navigationController pushViewController:controlador animated:YES];
    
    controlador.usuario.text = tweet[@"from_user"];
    controlador.twit.text = tweet[@"text"];
}
@end
