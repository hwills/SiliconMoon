//
//  BrowseMentorsViewController.m
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import "BrowseMentorsViewController.h"

@implementation BrowseMentorsViewController

@synthesize mentors;

-(id) init
{
    self= [super init];
    mentors = [[NSMutableArray alloc]initWithObjects:
                     @"Data 1 in array",@"Data 2 in array",@"Data 3 in array",
                     @"Data 4 in array",@"Data 5 in array",@"Data 5 in array",
                     @"Data 6 in array",@"Data 7 in array",@"Data 8 in array",
                     @"Data 91 in array", nil];
    [self setTitle:@"Mentors"];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 400, 400)
                                                      style:UITableViewStylePlain];
    
    table.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    table.delegate = self;
    table.dataSource = self;
    [table reloadData];
    
    [self addButton:@"Become Mentor" :CGRectMake(200, 50, 200, 50) :1];
    [self.view addSubview: table];
    return self;
}

- (void)buttonClicked: (UIButton*) sender
{
    switch (sender.tag) {
        case 1:
            NSLog(@"Clicked on become a mentor");
            break;
        default:
            break;
    }
}

-(void)addButton: (NSString*)buttonLabel : (CGRect)buttonFrame :(int)buttonTag{
    // This creates a round button and set its frame
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame= buttonFrame;
    
    // This sets the title of the button
    [button setTitle:buttonLabel forState:UIControlStateNormal];
    
    // This sets the tag of the button
    button.tag= buttonTag;
    
    // This add a listener to the button handled in buttonClicked function
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    // Configure the cell...
    cell.textLabel.text = [mentors objectAtIndex:indexPath.row];
    return cell;
}


@end
