//
//  ProfileViewController.m
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProjectTabBarController.h"

@implementation ProfileViewController
@synthesize projects;

- (id) initWithUserId :(NSInteger) userId
{
    self = [super init];
    
    self.projects = [[NSMutableArray alloc] init];
    self.projectdescs = [[NSMutableArray alloc] init];
    self.projectids = [[NSMutableArray alloc] init];
    self.projectrequests = [[NSMutableArray alloc] init];
    self.userId = userId;
    self.userIdFor = userId;
    self.userIdFrom = userId;
    
    UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://i.ytimg.com/vi/o0LOJCvMWwM/hqdefault.jpg"]]];
    self.imageView = [[UIImageView alloc] initWithImage:img];
    self.imageView.frame = CGRectMake(20.0, 100.0, 100.0, 100.0);
    self.imageView.backgroundColor = [[UIColor alloc] initWithPatternImage:img];
    [self.view addSubview:self.imageView];
    //TODO: make image work
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setText:@"hwills"];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.titleLabel setFont:[UIFont fontWithName:@"Times" size:36.0]];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.frame = CGRectMake(self.imageView.frame.origin.x + self.imageView.frame.size.width + 10, 100.0, 200.0, 100.0);
    [self.view addSubview:self.titleLabel];
    
    self.descLabel = [[UILabel alloc] init];
    [self.descLabel setText:@"I am a pacman looking for his pellet."];
    [self.descLabel setTextAlignment:NSTextAlignmentLeft];
    [self.descLabel setFont:[UIFont fontWithName:@"Times" size:12.0]];
    [self.descLabel setTextColor:[UIColor blackColor]];
    self.descLabel.numberOfLines = 2;
    self.descLabel.frame = CGRectMake(30.0, 200.0, 180.0, 100.0);
    [self.view addSubview:self.descLabel];
    
//    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [editBtn addTarget:self action:@selector(editButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
//    editBtn.frame = CGRectMake(self.descLabel.frame.origin.x + self.descLabel.frame.size.width, self.descLabel.frame.origin.y, 120.0, 30.0);
//    editBtn.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:editBtn];
    
    NSString *post = [NSString stringWithFormat:@"id=%ld",(long)userId];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL *jsonFileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", @"http://ec2-54-148-70-188.us-west-2.compute.amazonaws.com/~hwills/getProfile.php"]];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setURL:jsonFileUrl];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    return self;
}

- (id) initWithUserIdFromUserId :(NSInteger) userIdFor crntUsersId: (NSInteger) userIdFrom
{
    self = [super init];
    
    self.projects = [[NSMutableArray alloc] init];
    self.projectdescs = [[NSMutableArray alloc] init];
    self.projectids = [[NSMutableArray alloc] init];
    self.projectrequests = [[NSMutableArray alloc] init];
    self.userIdFor = userIdFor;
    self.userIdFrom = userIdFrom;
    
    UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://i.ytimg.com/vi/o0LOJCvMWwM/hqdefault.jpg"]]];
    self.imageView = [[UIImageView alloc] initWithImage:img];
    self.imageView.frame = CGRectMake(20.0, 100.0, 100.0, 100.0);
    self.imageView.backgroundColor = [[UIColor alloc] initWithPatternImage:img];
    [self.view addSubview:self.imageView];
    //TODO: make image work
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setText:@"hwills"];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.titleLabel setFont:[UIFont fontWithName:@"Times" size:36.0]];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.frame = CGRectMake(self.imageView.frame.origin.x + self.imageView.frame.size.width + 10, 100.0, 200.0, 100.0);
    [self.view addSubview:self.titleLabel];
    
    self.descLabel = [[UILabel alloc] init];
    [self.descLabel setText:@"I am a pacman looking for his pellet."];
    [self.descLabel setTextAlignment:NSTextAlignmentLeft];
    [self.descLabel setFont:[UIFont fontWithName:@"Times" size:12.0]];
    [self.descLabel setTextColor:[UIColor blackColor]];
    self.descLabel.numberOfLines = 2;
    self.descLabel.frame = CGRectMake(30.0, 200.0, 180.0, 100.0);
    [self.view addSubview:self.descLabel];
    
    self.conLabel = [[UILabel alloc] init];
    [self.conLabel setText:@"Not connected With LinkedIN"];
    [self.conLabel setTextAlignment:NSTextAlignmentLeft];
    [self.conLabel setFont:[UIFont fontWithName:@"Times" size:12.0]];
    [self.conLabel setTextColor:[UIColor blackColor]];
    self.conLabel.numberOfLines = 2;
    self.conLabel.frame = CGRectMake(30.0, 230.0, 180.0, 100.0);
    [self.view addSubview:self.conLabel];
    
    self.sumLabel = [[UILabel alloc] init];
    [self.sumLabel setText:@"This user is not registered with LinkedIN"];
    [self.sumLabel setTextAlignment:NSTextAlignmentLeft];
    [self.sumLabel setFont:[UIFont fontWithName:@"Times" size:12.0]];
    [self.sumLabel setTextColor:[UIColor blackColor]];
    self.sumLabel.numberOfLines = 2;
    self.sumLabel.frame = CGRectMake(30.0, 250.0, 180.0, 100.0);
    [self.view addSubview:self.sumLabel];
    
    /*UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editBtn addTarget:self action:@selector(editButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    editBtn.frame = CGRectMake(self.descLabel.frame.origin.x + self.descLabel.frame.size.width, self.descLabel.frame.origin.y, 120.0, 30.0);
    editBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:editBtn];*/
    
    NSLog(@"ID FOR %ld",(long)self.userIdFor);
    NSString *post = [NSString stringWithFormat:@"idFor=%ld&idFrom=%ld",(long)self.userIdFor, self.userIdFrom];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL *jsonFileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", @"http://ec2-54-148-70-188.us-west-2.compute.amazonaws.com/~hwills/getProfileFromOther.php"]];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setURL:jsonFileUrl];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.webResopnse = [[NSMutableData alloc] init];
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [self.webResopnse appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *responseString = [[NSString alloc] initWithData:self.webResopnse encoding:NSUTF8StringEncoding];
    NSLog(@"Response: %@", responseString);
    NSError *e = nil;
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Success?: %@", JSON[@"success"]);
    if ([JSON[@"ignore"] isEqual: @"true"]) {
        UIAlertView * requestedAlert = [[UIAlertView alloc] initWithTitle:@"User requested!" message:@"This user has been requested to join you on your project." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Great!", nil];
        [requestedAlert show];
        return;
    }
    if ([JSON[@"success"] isEqual: @"false"]) {
        NSLog(@"%@",JSON[@"message"]);
        UIAlertView * errorOccuredAlert = [[UIAlertView alloc] initWithTitle:@"An error occured!" message:@"An error occured while retreiving your profile information. Please try again later." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Understood", nil];
        [errorOccuredAlert show];
        return;
    }
    UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:JSON[@"url"]]]];
    self.imageView.image = img;
    [self.titleLabel setText:JSON[@"user"]];
    [self.descLabel setText:JSON[@"desc"]];
    if (![JSON[@"sum"] isEqual:@"none"]) {
        [self.sumLabel setText:JSON[@"sum"]];
    }
    if (![JSON[@"con"] isEqual:@"none"]) {
        [self.conLabel setText:JSON[@"con"]];
    }
    NSArray *names = [JSON[@"projectnames"] componentsSeparatedByString:@", "];
    NSArray *pids = [JSON[@"projectids"] componentsSeparatedByString:@", "];
    NSArray *descs = [JSON[@"projectdescs"] componentsSeparatedByString:@", "];
    NSArray *reqs = [JSON[@"projectreqs"] componentsSeparatedByString:@", "];
//    NSLog(@"%@", names);
    [self.projects addObjectsFromArray:names];
    [self.projectdescs addObjectsFromArray:descs];
    [self.projectids addObjectsFromArray:pids];
    [self.projectrequests addObjectsFromArray:reqs];
    NSLog(@"PROJECTS %@",self.projects);
    
    self.projectz = [[UIPickerView alloc] init];
    self.projectz.delegate = self;
    self.projectz.dataSource = self;
    self.projectz.showsSelectionIndicator = YES;
    self.projectz.frame = CGRectMake(20.0, 250.0, 180.0, 162.0);
    [self.projectz reloadAllComponents];
    [self.view addSubview:self.projectz];
    
    if(self.userIdFrom == self.userIdFor) {
        UIButton *projectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [projectBtn addTarget:self action:@selector(projectButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
        [projectBtn setTitle:@"See this project" forState:UIControlStateNormal];
        projectBtn.frame = CGRectMake(self.projectz.frame.origin.x + self.projectz.frame.size.width, self.projectz.frame.origin.y + 100.0, 120.0, 30.0);
        projectBtn.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:projectBtn];
    }
    else {
        UIButton *projectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [projectBtn addTarget:self action:@selector(requestButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
        [projectBtn setTitle:@"Request for project" forState:UIControlStateNormal];
        projectBtn.frame = CGRectMake(self.projectz.frame.origin.x + self.projectz.frame.size.width, self.projectz.frame.origin.y + 100.0, 120.0, 30.0);
        projectBtn.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:projectBtn];
    }
    
//    [descrics addObjectsFromArray:descs];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [projects count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [projects objectAtIndex:row];
}

- (void) editButtonWasClicked :(id) sender {
    
}

- (void) projectButtonWasClicked :(id) sender {
    NSInteger index = [self.projectz selectedRowInComponent:0];
    UITabBarController *vc = [[ProjectTabBarController alloc] initWithProjectIdNameDescriptionRequestsAndUserId:[[self.projectids objectAtIndex:index] integerValue] projectName:self.projects[index] projectDesctiption:self.projectdescs[index] projectRequest:[[self.projectrequests objectAtIndex:index] integerValue] userId:self.userId];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) requestButtonWasClicked :(id) sender {
    NSInteger index = [self.projectz selectedRowInComponent:0];
    NSString *post = [NSString stringWithFormat:@"userid=%ld&projectid=%ld",(long)self.userIdFor,(long)[[self.projectids objectAtIndex:index] integerValue]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL *jsonFileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", @"http://ec2-54-148-70-188.us-west-2.compute.amazonaws.com/~hwills/requestUser.php"]];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setURL:jsonFileUrl];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

@end
