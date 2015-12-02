//
//  NewProjectViewController.h
//  SiliconMoon
//
//  Created by Hunter Wills on 12/1/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewProjectViewController : UIViewController
- (id) initWithUserId :(NSInteger) userId;

@property (nonatomic, retain) NSMutableData *webResopnse;
@property (nonatomic, retain) UITextField *name;
@property (nonatomic, retain) UITextView *desc;
@property (nonatomic) NSInteger userId;

@end
