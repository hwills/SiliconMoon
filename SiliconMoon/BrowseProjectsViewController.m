//
//  BrowseProjectsViewController.m
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import "BrowseProjectsViewController.h"

@implementation BrowseProjectsViewController
@synthesize content;

-(id) init
{
    self= [super init];
    content = [[NSMutableArray alloc]initWithObjects:
              @"Data 1 in array",@"Data 2 in array",@"Data 3 in array",
              @"Data 4 in array",@"Data 5 in array",@"Data 5 in array",
              @"Data 6 in array",@"Data 7 in array",@"Data 8 in array",
              @"Data 9 in array", nil];
    [self setTitle:@"Projects"];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 400, 400)
                                                           style:UITableViewStylePlain];
    
    table.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    table.delegate = self;
    table.dataSource = self;
    [table reloadData];
    
    [self.view addSubview: table];
    return self;
    
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
    cell.textLabel.text = [content objectAtIndex:indexPath.row];
    return cell;
}

@end