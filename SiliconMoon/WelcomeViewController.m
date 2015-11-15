//
//  WelcomeViewController.m
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import "WelcomeViewController.h"
#import "ProfileViewController.h"

@implementation WelcomeViewController

- (id) init
{
    self = [super init];
    
    int profBtnOffset = 200;
    int browseBtnOffset = 10;
    
    UILabel *label = [[UILabel alloc] init];
    
    [label setText:@"Silicon Moon"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Times" size:36.0]];
    [label setTextColor:[UIColor blackColor]];
    label.numberOfLines = 2;
    label.frame = CGRectMake(100.0, 100.0, 180.0, 100.0);
    [self.view addSubview:label];
    
    
    UIButton *profileBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [profileBtn addTarget:self action:@selector(profileButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
    [profileBtn setTitle:@"Your Profile" forState:UIControlStateNormal];
    profileBtn.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y + profBtnOffset, 120.0, 50.0);
    profileBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:profileBtn];
    
    UIButton *browseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [browseBtn addTarget:self action:@selector(browseButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
    [browseBtn setTitle:@"Browse" forState:UIControlStateNormal];
    browseBtn.frame = CGRectMake(profileBtn.frame.origin.x, profileBtn.frame.origin.y + profileBtn.frame.size.height + browseBtnOffset, 120.0, 50.0);
    browseBtn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:browseBtn];
    
    return self;
}

- (void) profileButtonWasClicked :(id) sender {
    
    UIViewController *vc = [[ProfileViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void) browseButtonWasClicked :(id) sender {
    
    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
