//
//  displayImageCustomCollectionviewCell.h
//  sahajTask
//
//  Created by Karthik Saminathan on 29/07/16.
//  Copyright © 2016 Karthik Saminathan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface displayImageCustomCollectionviewCell : UICollectionViewCell

//----------
#pragma mark - cell properties
//----------
@property (strong, nonatomic) IBOutlet UIImageView *displayImageView;
@property (weak, nonatomic) IBOutlet UIView *WhiteView;
@property (weak, nonatomic) IBOutlet UILabel *ImageTitle;
@property (weak, nonatomic) IBOutlet UILabel *title;
//----------

//----------
#pragma mark - cell custom methods
//----------
-(void)settitle :(NSString *)title;
-(void)setPlaceholderImage;
-(void)setImagefromLocalDirectory :(NSString *)image;
-(void)showDetailPage :(int)status;
-(void)setRandombackgroundcolor :(NSArray *)colors;
//----------
@end
