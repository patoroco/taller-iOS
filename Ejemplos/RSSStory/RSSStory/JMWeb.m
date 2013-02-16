//
//  JMWeb.m
//  RSSStory
//
//  Created by Jorge Maroto Garcia on 16/2/13.
//  Copyright (c) 2013 Tactilapp.com. All rights reserved.
//

#import "JMWeb.h"

@implementation JMWeb
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.url = [self.url componentsSeparatedByString:@"?"][0];
    
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
@end
