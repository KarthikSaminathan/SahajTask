//
//  ViewController.h
//  sahajTask
//
//  Created by Karthik Saminathan on 29/07/16.
//  Copyright © 2016 Karthik Saminathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "displayImageCustomCollectionviewCell.h"
#import "UIViewController+commonMethods.h"
#import "Macros.h"
#import "ApiCall.h"
@interface DisplayImageVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    displayImageCustomCollectionviewCell *displayCell;
    ApiCall *apicall;
}
@property (strong, nonatomic) IBOutlet UICollectionView *gridView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property(nonatomic,strong)NSMutableArray *response;
@property(nonatomic,strong)NSArray *colorsArray;
@property(nonatomic,weak)NSMutableArray *imageDownloadStatus;

@end

