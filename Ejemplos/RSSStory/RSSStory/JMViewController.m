//
//  JMViewController.m
//  RSSStory
//
//  Created by Jorge Maroto Garcia on 16/2/13.
//  Copyright (c) 2013 Tactilapp.com. All rights reserved.
//

#import "JMViewController.h"
#import "AFNetworking.h"
#import "JMWeb.h"

@interface JMViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tabla;
@property (nonatomic, strong) NSString *currentElement;
@property (nonatomic, strong) NSMutableString *contenido;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableDictionary *currentItem;
@end

@implementation JMViewController

- (void)viewDidLoad{
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"http://www.cyliconvalley.es/feed/"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self parseData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
    [operation start];
}

-(void)parseData:(NSData *)data{
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
    [xmlParser setDelegate:self];
    [xmlParser parse];
}


#pragma mark - Table Delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *infoCell = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = infoCell[@"title"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"cargarNoticia" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"cargarNoticia"]){
        JMWeb *web = (JMWeb *)segue.destinationViewController;

        NSDictionary *infoCell = [self.items objectAtIndex:self.tabla.indexPathForSelectedRow.row];
        NSString *link = infoCell[@"link"];

        web.url = link;        
    }
}

#pragma mark - NSXMLDelegate
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    self.items = [NSMutableArray array];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"item"]){
        self.currentItem = [NSMutableDictionary dictionary];
    }
    
    self.currentElement = elementName;
    self.contenido = [NSMutableString string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"item"]){
        [self.items addObject:self.currentItem];
    }else if ([elementName isEqualToString:@"title"]){
        [self.currentItem setValue:self.contenido forKey:@"title"];
    }else if ([elementName isEqualToString:@"link"]){
        [self.currentItem setValue:self.contenido forKey:@"link"];
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [self.contenido appendString:string];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    [self.tabla reloadData];
}
@end