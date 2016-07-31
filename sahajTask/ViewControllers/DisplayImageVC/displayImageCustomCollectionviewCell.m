//
//  displayImageCustomCollectionviewCell.m
//  sahajTask
//
//  Created by Karthik Saminathan on 29/07/16.
//  Copyright © 2016 Karthik Saminathan. All rights reserved.
//

#import "displayImageCustomCollectionviewCell.h"

@implementation displayImageCustomCollectionviewCell

//-------------------------------------------------------------------------------------
#pragma mark - cell custom methods
//-------------------------------------------------------------------------------------
-(void)settitle :(NSString *)title
{
    _title.text = title;
    _ImageTitle.text = title;
}
-(void)setPlaceholderImage
{
    _displayImageView.image = [UIImage imageNamed:@"placeholder"];
}

-(void)setImagefromLocalDirectory :(NSString *)path
{
    _displayImageView.image = [UIImage imageWithContentsOfFile:path];
}
-(void)showDetailPage :(int)status
{
    if (status)
    {
        _WhiteView.hidden = NO;
        _ImageTitle.hidden=NO;
        _title.hidden = YES;
    }
    else
    {
        _WhiteView.hidden = YES;
        _ImageTitle.hidden=YES;
        _title.hidden = NO;
    }
}

-(void)setRandombackgroundcolor :(NSArray *)colors
{
    u_int32_t no = (u_int32_t)[colors count];
    NSUInteger randIndex = arc4random_uniform(no);
    _WhiteView.backgroundColor = [colors objectAtIndex:randIndex];
}
//-------------------------------------------------------------------------------------
@end
