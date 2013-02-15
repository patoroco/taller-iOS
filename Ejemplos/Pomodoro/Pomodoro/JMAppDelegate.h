//
//  JMAppDelegate.h
//  Pomodoro
//
//  Created by Jorge Maroto Garcia on 15/2/13.
//  Copyright (c) 2013 Tactilapp.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) NSNumber *tiempo;

@end
