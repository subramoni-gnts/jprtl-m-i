//
//  ViewController.h
//  ASIHttpRequest
//
//  Created by Apple on 26/10/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "ASIDownloadCache.h"
#import <AddressBook/AddressBook.h>
#import <Social/Social.h>
#import "LeveyPopListView.h"

@interface ViewControllerLogin: UIViewController <LeveyPopListViewDelegate>
{
    ASIHTTPRequest *request;
    ASINetworkQueue *networkQueue;
    BOOL failed;
    NSArray *categoryArray;
}
@property (retain, nonatomic) ASIHTTPRequest *request;
@property (nonatomic, retain) IBOutlet UIDatePicker *DatePick;
@property (nonatomic, retain) IBOutlet UIView *dateView;
- (IBAction)dismissdate:(id)sender;
- (IBAction)seldate:(id)sender;
@property (nonatomic, retain) IBOutlet UIDatePicker *TimePick;
@property (nonatomic, retain) IBOutlet UIView *timeiew;
- (IBAction)dismisstime:(id)sender;
- (IBAction)seltime:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtDeliveryTime;
@property (strong, nonatomic) IBOutlet UITextField *txtDeliveryDate;
- (IBAction)deldate:(id)sender;
- (IBAction)deltime:(id)sender;

- (IBAction)login:(id)sender;
- (IBAction)Employerlogin:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)Register:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *RegisterView;
- (IBAction)CloseRegister:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *TextfieldLocation;
@property (nonatomic, retain) IBOutlet UITableView *LocationTableView;
- (IBAction)BackButton:(id)sender;
@end
