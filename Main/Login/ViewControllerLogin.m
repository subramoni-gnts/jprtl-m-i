//
//  ViewController.m
//  ASIHttpRequest
//
//  Created by Apple on 26/10/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "ViewControllerLogin.h"
#import "ServiceDomain.h"
//#import <FacebookSDK/FacebookSDK.h>
#import "NewpayslipHome.h"

@interface ViewControllerLogin ()

@end

@implementation ViewControllerLogin
@synthesize request;
@synthesize TextfieldLocation;
@synthesize LocationTableView;
int checkAgree;

UIActivityIndicatorView *Activity;
UIAlertView *progressAlert;
NSMutableArray *mutableArrayServiceDomainLocation;
NSMutableArray *mutableArrayDataLocation;
NSMutableArray *mutableArrayFilteredLocationResult;
BOOL isSearchingLocation;

- (IBAction)dismissdate:(id)sender
{
    _dateView.hidden=YES;
    _timeiew.hidden=YES;
}

- (IBAction)dismisstime:(id)sender
{
    _dateView.hidden=YES;
    _timeiew.hidden=YES;
}

- (IBAction)seldate:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    _txtDeliveryDate.text=[formatter stringFromDate:[_DatePick date]];
}


- (IBAction)seltime:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateFormat:@"HH:mm"];
    
    _txtDeliveryTime.text=[formatter stringFromDate:[_TimePick date]];
}

- (IBAction)deldate:(id)sender {
    
     _dateView.hidden=NO;
}

- (IBAction)deltime:(id)sender {
    
     _timeiew.hidden=NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:_RegisterView];
    _RegisterView.hidden=YES;
    [self.view addSubview:LocationTableView];
    CGRect frame = LocationTableView.frame;
    frame.origin.y = 220;
    LocationTableView.frame = frame;
    LocationTableView.hidden=YES;
    
    mutableArrayServiceDomainLocation=[[NSMutableArray alloc]init];
    mutableArrayDataLocation=[[NSMutableArray alloc]init];
    mutableArrayFilteredLocationResult=[[NSMutableArray alloc]init];
}



-(void) viewDidAppear:(BOOL)animated{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *urlString=[NSString stringWithFormat:@"http://uat.gntstech.com/table-reservation/webservices/functions.php"];
    // NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:@"sign_up", @"mode", @"subramani", @"sp_firstname", @"subu", @"sp_lastname", @"subu@gnts.in", @"sp_email", @"coimbatore", @"sp_primary_city",@"12345", @"sp_password", nil];
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    
    [jsonDict setObject:@"all_location" forKey:@"mode"];
    
    
    
    [manager POST:urlString parameters:jsonDict success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error = nil;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         if (!error) {
             
             [ProgressHUD showSuccess:nil];
             
             //NSLog(@"JSON:%@",JSON);
             NSArray *headerkey=[JSON valueForKey:@"all_location"];
             
             
             for(NSDictionary *value in headerkey)
             {
                 
                 NSString *l_id=[value valueForKey:@"location_id"];
                 NSString *l_name=[value valueForKey:@"location_name"];
                 
                 ServiceDomain *serviceDomain = [ServiceDomain new];
                 serviceDomain.l_name = l_name;
                 serviceDomain.l_id = l_id;
                 [mutableArrayServiceDomainLocation addObject:serviceDomain];
                 [mutableArrayDataLocation addObject:l_name];
                 ServiceDomain *sDomain = nil;
                 sDomain=[mutableArrayServiceDomainLocation objectAtIndex:0];
                 NSLog(@"sdomain %@",sDomain.l_name);
                 NSLog(@"service %@",serviceDomain.l_id);
                 
                 
                 
             }
             [self.LocationTableView reloadData];
             
         }
         else
         {
             NSLog(@"Error serializing %@", error);
             
             [ProgressHUD showError:error.localizedDescription];
         }
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         [ProgressHUD showError:error.localizedDescription];
     }];
    
    
    
    
    
    
}

- (void)dealloc {
    
    [mutableArrayDataLocation release];
    
    [mutableArrayServiceDomainLocation release];
    
    [mutableArrayFilteredLocationResult release];
    
    [super dealloc];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView==LocationTableView){
        // Return the number of rows in the section.
        if (isSearchingLocation) {
            return [mutableArrayFilteredLocationResult count];
        }
        else {
            return [mutableArrayDataLocation count];
        }
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==LocationTableView){
        static NSString *CellIdentifier = @"LocationCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell...
        if (isSearchingLocation) {
            cell.textLabel.text = [mutableArrayFilteredLocationResult objectAtIndex:indexPath.row];
        }
        else {
            cell.textLabel.text = [mutableArrayDataLocation objectAtIndex:indexPath.row];
        }
        return cell;
    }
   
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==LocationTableView){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"Section:%d Row:%d selected and its data is %@",
              indexPath.section,indexPath.row,cell.textLabel.text);
        TextfieldLocation.text=cell.textLabel.text;
        LocationTableView.hidden=YES;
        
        
        
        NSString *keyword=cell.textLabel.text;//arrayListLocationDomain.get(position).getId();
        int selected=0;
        ServiceDomain *sd1=[ServiceDomain new];
        for(int i=0;i<mutableArrayServiceDomainLocation.count;i++){
            sd1=[mutableArrayServiceDomainLocation objectAtIndex:i];
            NSString *name=sd1.l_name;
            if([keyword isEqualToString:name]){
                selected=i;
                break;
            }
        }
        sd1=[mutableArrayServiceDomainLocation objectAtIndex:selected];
        keyword=sd1.l_id;
    }
    
}

- (void)searchTableList :(UITextField *)searchBarList {
    
    if(searchBarList==TextfieldLocation){
        NSString *searchString = TextfieldLocation.text;
        
        
        for (NSString *tempStr in mutableArrayDataLocation) {
            NSComparisonResult result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
            if (result == NSOrderedSame) {
                [mutableArrayFilteredLocationResult addObject:tempStr];
            }
        }
        
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField==TextfieldLocation){
        
        LocationTableView.hidden=NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(UITextFieldTextDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==TextfieldLocation){
        LocationTableView.hidden=YES;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:textField];
}

- (void) UITextFieldTextDidChange:(NSNotification*)notification
{
    
    UITextField * textField = (UITextField*)notification.object;
    NSString * text = textField.text;
    NSLog(@"shouldChangeCharactersInRange - %@",text);
    if(textField==TextfieldLocation){
        
        if(LocationTableView.isHidden){
            LocationTableView.hidden=NO;
        }
        
        //NSLog(@"Text change - %d",isSearchingLocation);
        NSString *searchText=TextfieldLocation.text;
        //Remove all objects first.
        [mutableArrayFilteredLocationResult removeAllObjects];
        
        if([searchText length] != 0) {
            isSearchingLocation = YES;
            [self searchTableList:textField];
        }
        else {
            isSearchingLocation = NO;
        }
        //        CGFloat height = self.locationTableView.rowHeight;
        //        height *= mutableArrayFilteredLocationResult.count;
        //
        //        CGRect tableFrame = self.locationTableView.frame;
        //        tableFrame.size.height = mutableArrayFilteredLocationResult.count*30;
        //        self.locationTableView.frame = tableFrame;
        [self.LocationTableView reloadData];
    }
}

- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    //	return 0;
    return [emailTest evaluateWithObject:candidate];
}

- (IBAction)login:(id)sender {
    
    if ([_txtUserName.text isEqualToString:@""])
    {
        UIAlertView *alertv=[[UIAlertView alloc]initWithTitle:@"JOB PORTAL" message:@"Please Enter Your User Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertv show];
    }
    else
    {
        if ([_txtPassword.text isEqualToString:@""])
        {
            UIAlertView *alertv=[[UIAlertView alloc]initWithTitle:@"JOB PORTAL" message:@"Please Enter Your Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertv show];
        }
        else
        {
            NSString *uname=_txtUserName.text;
            NSString *pass=_txtPassword.text;
            
            NSLog(@"uname: %@",uname);
            NSLog(@"pass: %@",pass);
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            //manager.responseSerializer = [AFJSONResponseSerializer serializer];
            
            NSString *urlString=[NSString stringWithFormat:CANDIDATELOGIN_URL];
            // NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:@"sign_up", @"mode", @"subramani", @"sp_firstname", @"subu", @"sp_lastname", @"subu@gnts.in", @"sp_email", @"coimbatore", @"sp_primary_city",@"12345", @"sp_password", nil];
            NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
            
            //[jsonDict setObject:@"login" forKey:@"mode"];
            [jsonDict setObject:uname forKey:@"login_email"];
            [jsonDict setObject:pass forKey:@"login_password"];
            
            [manager POST:urlString parameters:jsonDict success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 NSError *error = nil;
                 NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                 NSInteger success = [(NSNumber *) [JSON objectForKey:@"success"] integerValue];
                 if (!error) {
                     
                     //[ProgressHUD showSuccess:nil];
                     NSLog(@"JSON:%@",JSON);
                     if(success == 1)
                     {
                         NSLog(@"Login SUCCESS");
                         UIAlertView *alertv=[[UIAlertView alloc]initWithTitle:@"JOB PORTAL" message:@"LOGIN SUCCESS" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alertv show];
                         NewpayslipHome *listing=[[NewpayslipHome alloc]initWithNibName:@"NewpayslipHome" bundle:nil];
                         
                         CATransition *transition = [CATransition animation];
                         transition.duration = 0.5;
                         transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                         transition.type = kCATransitionPush;
                         transition.subtype = kCATransitionFromLeft;
                         [self.view.window.layer addAnimation:transition forKey:nil];
                         [self presentModalViewController:listing animated:NO];
                         [listing release];
                         
                     } else {
                         
                         NSString *error_msg = (NSString *) [JSON objectForKey:@"error_message"];
                         UIAlertView *alertv=[[UIAlertView alloc]initWithTitle:@"JOB PORTAL" message:@"LOGIN FAILED" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alertv show];
                     }
                     
                 }
                 else
                 {
                     NSLog(@"Error serializing %@", error);
                     //[progressAlert dismissWithClickedButtonIndex:0 animated:YES];
                     [ProgressHUD showError:error.localizedDescription];
                 }
             }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 
                 //[progressAlert dismissWithClickedButtonIndex:0 animated:YES];
                 [ProgressHUD showError:error.localizedDescription];
             }];
        }
    }
    
}

- (IBAction)Employerlogin:(id)sender {
    
    if ([_txtUserName.text isEqualToString:@""])
    {
        UIAlertView *alertv=[[UIAlertView alloc]initWithTitle:@"JOB PORTAL" message:@"Please Enter Your User Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertv show];
    }
    else
    {
        if ([_txtPassword.text isEqualToString:@""])
        {
            UIAlertView *alertv=[[UIAlertView alloc]initWithTitle:@"JOB PORTAL" message:@"Please Enter Your Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertv show];
        }
        else
        {
            NSString *uname=_txtUserName.text;
            NSString *pass=_txtPassword.text;
            
            NSLog(@"uname: %@",uname);
            NSLog(@"pass: %@",pass);
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            //manager.responseSerializer = [AFJSONResponseSerializer serializer];
            
            NSString *urlString=[NSString stringWithFormat:EMPLOYERLOGIN_URL];
            // NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:@"sign_up", @"mode", @"subramani", @"sp_firstname", @"subu", @"sp_lastname", @"subu@gnts.in", @"sp_email", @"coimbatore", @"sp_primary_city",@"12345", @"sp_password", nil];
            NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
            
            //[jsonDict setObject:@"login" forKey:@"mode"];
            [jsonDict setObject:uname forKey:@"login_email"];
            [jsonDict setObject:pass forKey:@"login_password"];
            
            [manager POST:urlString parameters:jsonDict success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 NSError *error = nil;
                 NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                 NSInteger success = [(NSNumber *) [JSON objectForKey:@"success"] integerValue];
                 if (!error) {
                     
                     //[ProgressHUD showSuccess:nil];
                     NSLog(@"JSON:%@",JSON);
                     if(success == 1)
                     {
                         NSLog(@"Login SUCCESS");
                         UIAlertView *alertv=[[UIAlertView alloc]initWithTitle:@"JOB PORTAL" message:@"LOGIN SUCCESS" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alertv show];
                         PostJob *listing=[[PostJob alloc]initWithNibName:@"PostJob" bundle:nil];
                         
                         CATransition *transition = [CATransition animation];
                         transition.duration = 0.5;
                         transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                         transition.type = kCATransitionPush;
                         transition.subtype = kCATransitionFromLeft;
                         [self.view.window.layer addAnimation:transition forKey:nil];
                         [self presentModalViewController:listing animated:NO];
                         [listing release];
                         
                     } else {
                         
                         NSString *error_msg = (NSString *) [JSON objectForKey:@"error_message"];
                         UIAlertView *alertv=[[UIAlertView alloc]initWithTitle:@"JOB PORTAL" message:@"LOGIN FAILED" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alertv show];
                     }
                     
                 }
                 else
                 {
                     NSLog(@"Error serializing %@", error);
                     //[progressAlert dismissWithClickedButtonIndex:0 animated:YES];
                     [ProgressHUD showError:error.localizedDescription];
                 }
             }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 
                 //[progressAlert dismissWithClickedButtonIndex:0 animated:YES];
                 [ProgressHUD showError:error.localizedDescription];
             }];
        }
    }
    
}

- (IBAction)Register:(id)sender {
    
    _RegisterView.hidden=NO;
    
}
- (IBAction)CloseRegister:(id)sender {
    
    _RegisterView.hidden=YES;
    LocationTableView.hidden=YES;
}

//-(BOOL)textFieldShouldReturn:(UITextField*)textField;
//{
//    
//    [textField resignFirstResponder];
//    
//    return YES;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.txtPassword) {
        [theTextField resignFirstResponder];
    } else if (theTextField == self.txtUserName) {
        [self.txtPassword becomeFirstResponder];
    }
    
    [theTextField resignFirstResponder];
    return YES;
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if(textField==_txtContactnumber)
//    {
//        
//        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"+0123456789"];
//        for (int i = 0; i < [string length]; i++)
//        {
//            unichar c = [string characterAtIndex:i];
//            if (![myCharSet characterIsMember:c])
//            {
//                return NO;
//            }
//        }
//        
//        return YES;
//    }
//    
//    return YES;
//}

-(IBAction)actionButtonClickBackground:(id)sender{
   // LocationTableView.hidden=YES;
    
}

- (IBAction)BackButton:(id)sender {
    
    LocationTableView.hidden=YES;
    
}


@end



