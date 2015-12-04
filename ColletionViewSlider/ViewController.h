//
//  ViewController.h
//  ColletionViewSlider
//
//  Created by Ankur Kathiriya on 04/12/15.
//  Copyright (c) 2015 Wednesday technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (strong, nonatomic) IBOutlet UICollectionView *collectionViewHeader;


@end

