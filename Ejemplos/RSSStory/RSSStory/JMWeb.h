//
//  JMWeb.h
//  RSSStory
//
//  Created by Jorge Maroto Garcia on 16/2/13.
//  Copyright (c) 2013 Tactilapp.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMWeb : UIViewController
    @property (weak, nonatomic) IBOutlet UIWebView *web;
    @property (nonatomic, strong) NSString *url;
@end