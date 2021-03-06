//
//  BrowseDevelopersViewController.h
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseDevelopersViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>

- (id) initWithUserId :(NSInteger) userId;
@property (nonatomic, retain) NSMutableData *webResopnse;
@property (nonatomic, strong) NSMutableArray *developers;
@property (nonatomic, strong) NSMutableArray *imageUrls;
@property (nonatomic, strong) NSMutableArray *userIds;
@property (nonatomic) NSInteger userId;

@end
