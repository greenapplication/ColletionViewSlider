//
//  ViewController.m
//  ColletionViewSlider
//
//  Created by Ankur Kathiriya on 04/12/15.
//  Copyright (c) 2015 Wednesday technology. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "CollectionViewCell.h"

@interface ViewController ()
{
    NSMutableArray *json;
    NSInteger pageNumber;
}
@end

@implementation ViewController
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(self.collectionViewHeader.frame.size.width, self.collectionViewHeader.frame.size.height)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.minimumLineSpacing = 0.0;
    [self.collectionViewHeader setCollectionViewLayout:flowLayout];
    self.collectionViewHeader.bounces = YES;
    self.collectionViewHeader.pagingEnabled = true;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    pageNumber=1;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self getData];
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(aTime) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma CollectionView Method
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [json count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell=(CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[[json objectAtIndex:indexPath.row] valueForKey:@"picture_url"]]
                  placeholderImage:[UIImage imageNamed:@""]
                         completed:nil];
    return cell;
}


-(void)aTime
{
    if (pageNumber ==json.count) {
        pageNumber=0;
    }
    CGFloat pageWidth = self.collectionViewHeader.frame.size.width;
    CGPoint scrollTo = CGPointMake(pageWidth * pageNumber, 0);
    [self.collectionViewHeader setContentOffset:scrollTo animated:YES];
    
    pageNumber=pageNumber+1;
    
}

-(void)getData{
    json=[[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    operationManager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [operationManager GET:@"http://alignments.pk/mobile/getbanner.php" parameters:nil                  success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSLog(@"%@",text);
         NSError *error ;
         NSLog(@"%@",responseObject);
         
         
         NSMutableArray * ary=[NSJSONSerialization JSONObjectWithData:responseObject  options:kNilOptions error:&error];
         json = [ary valueForKey:@"banner_array"];
         
         
         [self.collectionViewHeader reloadData];
         [self.view setNeedsDisplay];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
