//
//  InfoVC.m
//  sahajTask
//
//  Created by Karthik Saminathan on 31/07/16.
//  Copyright © 2016 Karthik Saminathan. All rights reserved.
//

#import "InfoVC.h"

@interface InfoVC ()

@end

@implementation InfoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self animation];
}
-(void)animation
{
    CGRect pinkframe1, pinkframe2, orangeframe1, orangeframe2, cyanframe1, cyanframe2, sandleframe1, sandleframe2;
    
    pinkframe1 = _pinkView.frame;
    pinkframe2 = _pinkView.frame;
    
    orangeframe1 = _Orangeview.frame;
    orangeframe2 = _Orangeview.frame;
    
    cyanframe1 = _cyanView.frame;
    cyanframe2 = _cyanView.frame;
    
    sandleframe1 = _sandleView.frame;
    sandleframe2 = _sandleView.frame;
    
    pinkframe1.origin.y = self.view.frame.size.height;
   _pinkView.frame = pinkframe1;
    
    orangeframe1.origin.y = self.view.frame.size.height + pinkframe1.size.height;
   _Orangeview.frame = orangeframe1;
    
    cyanframe1.origin.y = self.view.frame.size.height + orangeframe1.size.height;
    _cyanView.frame = pinkframe1;
    
    sandleframe1.origin.y = self.view.frame.size.height + cyanframe1.size.height;
    _sandleView.frame = sandleframe1;
    
    [UIView animateWithDuration:0.5 animations:^
    {
         _pinkView.frame = pinkframe2;
        _Orangeview.frame = orangeframe2;
        _cyanView.frame = pinkframe2;
         _sandleView.frame = sandleframe2;
    } completion:^(BOOL finished) {
    }];
    
    //_pinkView.clipsToBounds
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)PinkAction:(id)sender
{
    [self performSegueWithIdentifier:@"segue" sender:nil];
}

@end
