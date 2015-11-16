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

@property (nonatomic, strong) NSMutableArray *members;
@end
