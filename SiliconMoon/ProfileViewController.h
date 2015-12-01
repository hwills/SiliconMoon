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
@property (nonatomic, retain) NSMutableData *webResopnse;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *descLabel;

@end
