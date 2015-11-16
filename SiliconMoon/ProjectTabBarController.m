//
//  ProjectTabBarController.m
//  
//
//  Created by Alex Tran on 11/15/15.
//
//

#import "ProjectTabBarController.h"
#import "ProjectDescriptionViewController.h"
#import "ProjectMemberViewController.h"
#import "ProjectMessageViewController.h"

@implementation ProjectTabBarController

-(id) init
{
    self= [super init];
    ProjectDescriptionViewController *descriptionVC= [[ProjectDescriptionViewController alloc]init];
    ProjectMemberViewController *memberVC= [[ProjectMemberViewController alloc]init];
    ProjectMessageViewController *messageVC= [[ProjectMessageViewController alloc]init];
    self.viewControllers= [NSArray arrayWithObjects: descriptionVC, memberVC, messageVC, nil];
    return self;
}

@end
