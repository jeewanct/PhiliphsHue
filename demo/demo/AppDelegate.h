//
//  AppDelegate.h
//  demo
//
//  Created by JEEVAN TIWARI on 08/03/17.
//  Copyright © 2017 JEEVAN TIWARI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

