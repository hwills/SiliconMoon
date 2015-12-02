//
//  ProjectDescriptionViewController.h
//  
//
//  Created by Alex Tran on 11/15/15.
//
//

#import <UIKit/UIKit.h>

@interface ProjectDescriptionViewController : UITabBarController

-(id) initWithProjectNameAndDescription: (NSString *) name projectDesctiption: (NSString *) desc;

@property NSString *projectName, *projectDescription;
@property bool isRequested;
@end
