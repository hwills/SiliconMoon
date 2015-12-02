//
//  ProjectMemberViewController.h
//  
//
//  Created by Alex Tran on 11/15/15.
//
//

#import <UIKit/UIKit.h>

@interface ProjectMemberViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>

-(id) initWithProjectId: (NSInteger) projectId;
@property (nonatomic, retain) NSMutableData *webResopnse;
@property (nonatomic, strong) NSMutableArray *members;
@property (nonatomic, strong) NSMutableArray *imageUrls;

@end
