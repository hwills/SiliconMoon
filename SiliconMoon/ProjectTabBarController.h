//
//  ProjectTabBarController.h
//  
//
//  Created by Alex Tran on 11/15/15.
//
//

#import <UIKit/UIKit.h>

@interface ProjectTabBarController : UITabBarController

-(id) initWithProjectIdNameDescriptionRequestsAndUserId: (NSInteger) projectId projectName: (NSString *) projectName projectDesctiption: (NSString *) projectDesctiption projectRequest: (NSInteger) projectRequest userId: (NSInteger) userId;

@end
