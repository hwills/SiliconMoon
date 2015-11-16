//
//  ProfileViewController.m
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import "ProfileViewController.h"

@implementation ProfileViewController

- (id) initWithUserId :(NSInteger) userId
{
    self = [super init];
    
    UIImage * img = [[UIImage alloc] init];
    //TODO: make image work
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:@"ME PLACEHOLDER"];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    [titleLabel setFont:[UIFont fontWithName:@"Times" size:36.0]];
    [titleLabel setTextColor:[UIColor blackColor]];
    titleLabel.numberOfLines = 1;
    titleLabel.frame = CGRectMake(100.0, 100.0, 180.0, 100.0);
    [self.view addSubview:titleLabel];
    
    UILabel *descLabel = [[UILabel alloc] init];
    [descLabel setText:@"DESCRIPTION PLACEHOLDER"];
    [descLabel setTextAlignment:NSTextAlignmentLeft];
    [descLabel setFont:[UIFont fontWithName:@"Times" size:12.0]];
    [descLabel setTextColor:[UIColor blackColor]];
    descLabel.numberOfLines = 2;
    descLabel.frame = CGRectMake(100.0, 200.0, 180.0, 100.0);
    [self.view addSubview:descLabel];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editBtn addTarget:self action:@selector(editButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    editBtn.frame = CGRectMake(descLabel.frame.origin.x + descLabel.frame.size.width, descLabel.frame.origin.y, 120.0, 50.0);
    editBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:editBtn];
    
    UIPickerView *projects = [[UIPickerView alloc] init];
    projects.delegate = self;
    projects.dataSource = self;
    projects.showsSelectionIndicator = YES;
    projects.frame = CGRectMake(50.0, 300.0, 180.0, 162.0);
    [self.view addSubview:projects];
    
    UIButton *projectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [projectBtn addTarget:self action:@selector(projectButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
    [projectBtn setTitle:@"See this project" forState:UIControlStateNormal];
    projectBtn.frame = CGRectMake(projects.frame.origin.x + projects.frame.size.width, projects.frame.origin.y, 120.0, 50.0);
    projectBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:projectBtn];

    
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * title = nil;
    switch(row) {
        case 0:
            title = @"Project 1";
            break;
        case 1:
            title = @"Project 2";
            break;
        case 2:
            title = @"Project 3";
            break;
    }
    return title;
}

- (void) editButtonWasClicked :(id) sender {
    
}

- (void) projectButtonWasClicked :(id) sender {
    
}

@end
