//
//  BrowseProjectsViewController.h
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseProjectsViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>
- (id) initWithUserId :(NSInteger) userId;

@property (nonatomic, retain) NSMutableData *webResopnse;
@property (nonatomic, strong) NSMutableArray *projects;
@property (nonatomic, strong) NSMutableArray *descrics;
@property (nonatomic) NSInteger userId;

@end
