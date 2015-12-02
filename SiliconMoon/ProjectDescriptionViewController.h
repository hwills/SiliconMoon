//
//  ProjectDescriptionViewController.h
//  
//
//  Created by Alex Tran on 11/15/15.
//
//

#import <UIKit/UIKit.h>

@interface ProjectDescriptionViewController : UITabBarController

-(id) initWithProjectNameDescriptionRequestIdAndUserId: (NSString *) name projectDesctiption: (NSString *) desc projectRequest: (NSInteger) req projectId: (NSInteger) pid userId: (NSInteger) uid;

@property (nonatomic, retain) NSMutableData *webResopnse;
@property NSString *projectName, *projectDescription;
@property bool isRequested;
@property NSInteger projectId;
@property NSInteger userId;
@end
