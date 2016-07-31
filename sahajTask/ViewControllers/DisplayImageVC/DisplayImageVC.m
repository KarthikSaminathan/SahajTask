//
//  ViewController.m
//  sahajTask
//
//  Created by Karthik Saminathan on 29/07/16.
//  Copyright © 2016 Karthik Saminathan. All rights reserved.
//

#import "DisplayImageVC.h"

@interface DisplayImageVC ()

@end

@implementation DisplayImageVC

//------------------------------------------------------------------------
#pragma mark - viewDidLoad & it methods
//------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self localAllocMethod];
    [self downloadImageFromFlickr];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)localAllocMethod
{
    [_activityIndicatorView startAnimating];
     _response = [[NSMutableArray alloc] init];
    _colorsArray = [NSArray arrayWithObjects:PINK,RED,PURPLE,LIGHTBLUE,CYAN,TEAL,LIGHTGREEN,SANDLE,DEEPORANGE, nil];
    [self clearLocalDirectory];
}

-(void)downloadImageFromFlickr
{
    apicall = [ApiCall sharedInstance];
    [apicall GetResponse:^(BOOL success, NSDictionary *response, NSString *error)
    {
        if (success)
        {
            NSMutableArray *arr_response = [[response objectForKey:@"photos"] objectForKey:@"photo"];
            [arr_response enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
             {
                 NSMutableDictionary *add_image_data_dic = [[NSMutableDictionary alloc] init];
                 
                 [add_image_data_dic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)idx] forKey:@"id"];
                 [add_image_data_dic setObject:[obj objectForKey:@"title"] forKey:@"title"];
                 [add_image_data_dic setObject:@"0" forKey:@"show_detail_page"];
                 [add_image_data_dic setObject:@"0" forKey:@"downloadstatus"];
                 if ([obj objectForKey:@"url_o"])
                 {
                     [add_image_data_dic setObject:[obj objectForKey:@"url_o"] forKey:@"image_url"];
                 }
                 else
                 {
                     [add_image_data_dic setObject:@"default" forKey:@"image_url"];
                 }
                 
                 [_response addObject:add_image_data_dic];
                 add_image_data_dic=nil;
             }];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^
             {
                 [_activityIndicatorView stopAnimating];
                 [_gridView reloadData];
             }];
        }
        else
        {
             [_activityIndicatorView stopAnimating];
             [self alertView:error message:nil];
        }
    }];
    
}
//------------------------------------------------------------------------

//------------------------------------------------------------------------
#pragma mark - didReceiveMemoryWarning
//------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//------------------------------------------------------------------------

//------------------------------------------------------------------------
#pragma mark - Delegate & Datasource Methods
//------------------------------------------------------------------------
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_response count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width/2)-10, 150);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    displayCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [displayCell setPlaceholderImage];
    [displayCell settitle:[[_response objectAtIndex:indexPath.row] objectForKey:@"title"]];
    [displayCell showDetailPage:[[[_response objectAtIndex:indexPath.row] objectForKey:@"show_detail_page"] intValue]];
    
    if ([self getDownloadStatus:indexPath.row] == 0)
    {
        if ([self mayDownloadImage:indexPath.row])
        {
            [self setDownloadStatus:indexPath.row value:1];
            [self SaveImageLocally:[[_response objectAtIndex:indexPath.row] objectForKey:@"image_url"] index:indexPath.row completionBlock:^(BOOL success, NSArray *Indexarr, NSString *imageLocalPath)
             {
                 if (true)
                 {
                     [self setDownloadStatus:indexPath.row value:2];
                     [self setImageUrl:indexPath.row url:imageLocalPath];
                     [_gridView reloadItemsAtIndexPaths:Indexarr];
                 }
            }];
        }
    }
    else if ([self getDownloadStatus:indexPath.row] == 2)
    {
        [displayCell setImagefromLocalDirectory:[[_response objectAtIndex:indexPath.row] objectForKey:@"image_url"]];
    }
    return displayCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    displayImageCustomCollectionviewCell *cell = (displayImageCustomCollectionviewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:1.0
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction)
                     animations:^
     {
         [UIView transitionWithView:cell.contentView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^
          {
              if ([self getshowDetailPagestatus:indexPath.row] == 0)
              {
                  [cell setRandombackgroundcolor:_colorsArray];
                  [cell showDetailPage:1];
                  [self setshowDetailPagestatus:indexPath.row value:1];
              }
              else
              {
                  [cell showDetailPage:0];
                  [self setshowDetailPagestatus:indexPath.row value:0];
              }
          }completion:NULL];
     } completion:NULL];
    cell = nil;
}
//------------------------------------------------------------------------


//-------------------------------------------------------------------------------------
#pragma mark - custom set&get methods
//-------------------------------------------------------------------------------------
-(void)setDownloadStatus :(NSInteger)index value:(int)value
{
    [[_response objectAtIndex:index] removeObjectForKey:@"downloadstatus"];
    [[_response objectAtIndex:index] setObject:[NSString stringWithFormat:@"%i",value] forKey:@"downloadstatus"];
}
-(int)getDownloadStatus :(NSInteger)index
{
    return [[[_response objectAtIndex:index] objectForKey:@"downloadstatus"] intValue];
}

-(void)setImageUrl :(NSInteger)index url:(NSString *)imageurl
{
    [[_response objectAtIndex:index] removeObjectForKey:@"image_url"];
    [[_response objectAtIndex:index] setObject:imageurl forKey:@"image_url"];
}
-(BOOL)mayDownloadImage :(NSInteger)index
{
    if (![[[_response objectAtIndex:index] objectForKey:@"image_url"] isEqualToString:@"default"])
    {
        return YES;
    }
    return NO;
}

-(void)setshowDetailPagestatus :(NSInteger)index value:(int)value
{
    [[_response objectAtIndex:index] removeObjectForKey:@"show_detail_page"];
    [[_response objectAtIndex:index] setObject:[NSString stringWithFormat:@"%i",value] forKey:@"show_detail_page"];
}
-(int)getshowDetailPagestatus :(NSInteger)index
{
    return [[[_response objectAtIndex:index] objectForKey:@"show_detail_page"] intValue];
}
//-------------------------------------------------------------------------------------
@end
