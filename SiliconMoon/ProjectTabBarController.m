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

-(id) initWithProjectIdNameDescriptionRequestsAndUserId: (NSInteger) projectId projectName: (NSString *) projectName projectDesctiption: (NSString *) projectDesctiption projectRequest: (NSInteger) projectRequest userId: (NSInteger) userId
{
    NSLog(@"%ld %@ %@ %ld", (long)projectId, projectName, projectDesctiption, (long)projectRequest);
    self= [super init];
    ProjectDescriptionViewController *descriptionVC= [[ProjectDescriptionViewController alloc]initWithProjectNameDescriptionAndRequest:projectName projectDesctiption:projectDesctiption projectRequest:projectRequest];
    ProjectMemberViewController *memberVC= [[ProjectMemberViewController alloc]initWithProjectId:projectId];
    ProjectMessageViewController *messageVC= [[ProjectMessageViewController alloc]init];
    self.viewControllers= [NSArray arrayWithObjects: descriptionVC, memberVC, messageVC, nil];
    return self;
}

@end
