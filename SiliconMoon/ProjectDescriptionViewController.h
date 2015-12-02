//
//  ProjectDescriptionViewController.h
//  
//
//  Created by Alex Tran on 11/15/15.
//
//

#import <UIKit/UIKit.h>

@interface ProjectDescriptionViewController : UITabBarController

-(id) initWithProjectNameDescriptionAndRequest: (NSString *) name projectDesctiption: (NSString *) desc projectRequest: (NSInteger) req;

@property NSString *projectName, *projectDescription;
@property bool isRequested;
@end
