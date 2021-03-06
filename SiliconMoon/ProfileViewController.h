//
//  ProfileViewController.h
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

- (id) initWithUserId :(NSInteger) userId;
- (id) initWithUserIdFromUserId :(NSInteger) userIdFor crntUsersId: (NSInteger) userIdFrom;
@property (nonatomic, retain) NSMutableData *webResopnse;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *descLabel;
@property (nonatomic, retain) UILabel *sumLabel;
@property (nonatomic, retain) UILabel *conLabel;
@property (nonatomic, strong) NSMutableArray *projects;
@property (nonatomic, strong) NSMutableArray *projectdescs;
@property (nonatomic, strong) NSMutableArray *projectids;
@property (nonatomic, strong) NSMutableArray *projectrequests;
@property (nonatomic, strong) UIPickerView * projectz;
@property (nonatomic) NSInteger userId;
@property (nonatomic) NSInteger userIdFor;
@property (nonatomic) NSInteger userIdFrom;

@end
