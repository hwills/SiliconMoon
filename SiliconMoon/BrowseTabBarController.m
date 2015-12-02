//
//  BrowseTabBarController.m
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import "BrowseTabBarController.h"
#import "BrowseProjectsViewController.h"
#import "BrowseDevelopersViewController.h"
#import "BrowseMentorsViewController.h"

@implementation BrowseTabBarController

-(id) initWithUserId : (NSInteger)userId
{
    self= [super init];
    BrowseProjectsViewController *projectsVC= [[BrowseProjectsViewController alloc]initWithUserId:userId];
    BrowseDevelopersViewController *developersVC= [[BrowseDevelopersViewController alloc]init];
    BrowseMentorsViewController *mentorsVC= [[BrowseMentorsViewController alloc]init];
    self.viewControllers= [NSArray arrayWithObjects: projectsVC, developersVC, mentorsVC, nil];
    return self;
}

@end
