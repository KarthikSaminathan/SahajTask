//
//  UIViewController+commonMethods.m
//  sahajTask
//
//  Created by Karthik Saminathan on 31/07/16.
//  Copyright © 2016 Karthik Saminathan. All rights reserved.
//

#import "UIViewController+commonMethods.h"

@implementation UIViewController (commonMethods)


//-------------------------------------------------------------------------------------
#pragma mark - Methods related to LocalDirectory
//-------------------------------------------------------------------------------------
-(NSString *)Localpath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}
-(NSString *)get_imagePath :(NSInteger)index
{
    NSString *localFilePath = [[self Localpath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%li.jpg",(long)index]];
    return localFilePath;
}
-(void)clearLocalDirectory
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *directory = [self Localpath];
    NSError *error = nil;
    for (NSString *file in [fm contentsOfDirectoryAtPath:directory error:&error])
    {
         [fm removeItemAtPath:[NSString stringWithFormat:@"%@/%@", directory, file] error:&error];
    }
}
//-------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------
#pragma mark - Methods related to saving image, scalling image
//-------------------------------------------------------------------------------------
-(void)SaveImageLocally :(NSString *)imageUrl index:(NSInteger)index completionBlock:(void (^) (BOOL success,NSArray *Indexarr, NSString *imageLocalPath))completionBlock
{
    if ([self check_network])
    {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(queue, ^(void)
        {
            NSData *thedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            UIImage *Image = [UIImage imageWithData:thedata];
            NSString *path = [self get_imagePath:index];
            if (Image.size.width > 512 && Image.size.height > 512)
            {
                [UIImageJPEGRepresentation([self scale:Image toSize:CGSizeMake(512, 512)], 0.1f) writeToFile:path atomically:YES];
            }
            else
            {
                [UIImageJPEGRepresentation(Image, 1.0f) writeToFile:path atomically:YES];
            }
            NSIndexPath *indPath = [NSIndexPath indexPathForItem:index inSection:0];
            NSArray *arr = @[indPath];
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               completionBlock(true,arr,path);
                           });
        });
    }
    else
    {
        completionBlock(false,nil,nil);
    }
}
- (UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
//-------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------
#pragma mark - check internet connection is available
//-------------------------------------------------------------------------------------
-(BOOL)check_network /* Return yes if the network connection is available */
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable)
    {
        return YES;
    }
    return NO;
}
//-------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------
#pragma mark - alertview method
//-------------------------------------------------------------------------------------
-(void)alertView :(NSString *)Title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Title message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
//-------------------------------------------------------------------------------------
@end
