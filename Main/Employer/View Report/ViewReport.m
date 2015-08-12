//
//  ViewController.m
//  ASIHttpRequest
//
//  Created by Apple on 26/10/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "ViewReport.m"

@interface ViewReport ()

@end

@implementation ViewReport

@synthesize progressBar;
@synthesize request;
int checkAgree;


UIProgressView *theProgressView ;


int menuCheckCountViewReport=1;


- (void)viewDidLoad
{
    [super viewDidLoad];
    menuCheckCountViewReport=1;
    CGRect basketTopFrame = _sideView.frame;
    //basketTopFrame.origin.x = basketTopFrame.size.width;
    basketTopFrame.origin.x = -320;
    _sideView.frame = basketTopFrame;
    [self.view addSubview:_sideView];
    _sideView.hidden=YES;
}


-(IBAction)menuButton:(id)sender
{
    
    if (menuCheckCountViewReport==1)
    {
        
        _sideView.hidden=NO;
        
        CGRect basketTopFrame = _sideView.frame;
        //basketTopFrame.origin.x = basketTopFrame.size.width;
        basketTopFrame.origin.x = 0;
        
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _sideView.frame = basketTopFrame;
                             // basketBottom.frame = basketBottomFrame;
                         }
                         completion:^(BOOL finished)
         {
             NSLog(@"Done! AAA");
             
             
         }];
        
        CGRect basketTopFrameMenu = _VIewMenu.frame;
        //basketTopFrame.origin.x = basketTopFrame.size.width;
        basketTopFrameMenu.origin.x = 255;
        
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _VIewMenu.frame = basketTopFrameMenu;
                             // basketBottom.frame = basketBottomFrame;
                         }
                         completion:^(BOOL finished)
         {
             NSLog(@"Done! AAA");
             
             
         }];
        
        menuCheckCountViewReport=0;
        
    }
    else
    {
        
        _sideView.hidden=NO;
        
        CGRect basketTopFrame = _sideView.frame;
        //basketTopFrame.origin.x = basketTopFrame.size.width;
        basketTopFrame.origin.x = -320;
        
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _sideView.frame = basketTopFrame;
                             // basketBottom.frame = basketBottomFrame;
                         }
                         completion:^(BOOL finished)
         {
             NSLog(@"Done!");
             
             
         }];
        
        CGRect basketTopFrameMenu = _VIewMenu.frame;
        //basketTopFrame.origin.x = basketTopFrame.size.width;
        basketTopFrameMenu.origin.x = 0;
        
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _VIewMenu.frame = basketTopFrameMenu;
                             // basketBottom.frame = basketBottomFrame;
                         }
                         completion:^(BOOL finished)
         {
             NSLog(@"Done!");
             
             
         }];
        
          menuCheckCountViewReport=1;
    }
    
    
    
}


- (IBAction)clickPostjob:(id)sender {
    
    
        
        PostJob *listing=[[PostJob alloc]initWithNibName:@"PostJob" bundle:nil];
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.2;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:transition forKey:nil];
        [self presentModalViewController:listing animated:NO];
        [listing release];
    
    
}

- (IBAction)clickViewReport:(id)sender {
    
    
    ViewReport *listing=[[ViewReport alloc]initWithNibName:@"ViewReport" bundle:nil];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentModalViewController:listing animated:NO];
    [listing release];
    
    
}

- (IBAction)clickManagePostJob:(id)sender {
    
    
    ManagePostJob *listing=[[ManagePostJob alloc]initWithNibName:@"ManagePostJob" bundle:nil];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentModalViewController:listing animated:NO];
    [listing release];
    
    
    
}


- (IBAction)clickPromoteApp:(id)sender {
    
    NSString *message = @"Hello World!";
    NSString *url = @"http://www.test.com";
    
    NSArray *postItems = @[message, url];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo];
    [self presentViewController:activityVC animated:TRUE completion:nil];
        
    
}

- (IBAction)clickLogout:(id)sender {
    
    ViewControllerLogin *listing=[[ViewControllerLogin alloc]initWithNibName:@"ViewControllerLogin" bundle:nil];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentModalViewController:listing animated:NO];
    [listing release];
    
    
}
@end