//
//  MainCollectionViewController.h
//  TabletAssignmentObjC
//
//  Created by Yee Peng Chia on 2/19/16.
//  Copyright © 2016 Tablet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CusAnimateMenu.h"
@interface MainCollectionViewController : UICollectionViewController<CusAnimateMenuDelegate>
@property (strong, nonatomic) CusAnimateMenu * menu;


@end
