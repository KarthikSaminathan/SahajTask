//
//  UIViewController+commonMethods.h
//  sahajTask
//
//  Created by Karthik Saminathan on 31/07/16.
//  Copyright © 2016 Karthik Saminathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@interface UIViewController (commonMethods)

//-------------------------------------------------------------------------------------
#pragma mark - Methods related to LocalDirectory
//-------------------------------------------------------------------------------------
-(NSString *)Localpath;
-(NSString *)get_imagePath :(NSInteger)index;
-(void)clearLocalDirectory;
//-------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------
#pragma mark - Methods related to saving image, scalling image
//-------------------------------------------------------------------------------------
-(void)SaveImageLocally :(NSString *)imageUrl index:(NSInteger)index completionBlock:(void (^) (BOOL success,NSArray *Indexarr, NSString *imageLocalPath))completionBlock;
- (UIImage *)scale:(UIImage *)image toSize:(CGSize)size;
//-------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------
#pragma mark - check internet connection is available
//-------------------------------------------------------------------------------------
-(BOOL)check_network;
//-------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------
#pragma mark - alertview method
//-------------------------------------------------------------------------------------
-(void)alertView :(NSString *)Title message:(NSString *)message;
//-------------------------------------------------------------------------------------
@end
