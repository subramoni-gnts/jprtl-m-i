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
//#import "WhiteRaccoon.h"
#import "ASIDownloadCache.h"
#import <FacebookSDK/FacebookSDK.h>
#import <AddressBook/AddressBook.h>
#import <Social/Social.h>
#import "LeveyPopListView.h"

@interface ViewReport : UIViewController <FBLoginViewDelegate,FBFriendPickerDelegate,LeveyPopListViewDelegate>
{
    ASIHTTPRequest *request;
    ASINetworkQueue *networkQueue;
    BOOL failed;
    NSArray *categoryArray;
}

@property (strong, nonatomic) IBOutlet UIView *VIewMenu;

@property (strong, nonatomic) IBOutlet UIView *sideView;
-(IBAction)menuButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;
@property (retain, nonatomic) ASIHTTPRequest *request;


@property (strong, nonatomic) IBOutlet UILabel *cartlabel;

- (IBAction)clickPostjob:(id)sender;
- (IBAction)clickViewReport:(id)sender;
- (IBAction)clickManagePostJob:(id)sender;
- (IBAction)clickPromoteApp:(id)sender;
- (IBAction)clickLogout:(id)sender;





@end
