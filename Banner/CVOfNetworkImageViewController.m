
//
//  CVOfNetworkImageViewController.m
//  Banner
//
//  Created by 郑文明 on 16/1/4.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "CVOfNetworkImageViewController.h"
#import "CollectionViewCell.h"
#import "WMBannerView.h"
@interface CVOfNetworkImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    UICollectionView *cv;
    NSMutableArray *dataSource;
    WMBannerView *wmView;
    
}

@end

@implementation CVOfNetworkImageViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        dataSource = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    /*
     网络图片测试
     */
    NSArray *URLArray = @[@"http://farm2.staticflickr.com/1474/23556559423_daa83f9fa0_m.jpg",
                          @"http://farm2.staticflickr.com/1654/24076046592_bfed33b5db_m.jpg",
                          @"http://farm2.staticflickr.com/1537/24157216466_4683f30f39_m.jpg"];
    
    wmView = [[WMBannerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*3/4) withURLArrayOrImagesArray:URLArray];
    wmView.pageControlAlignment = WMPageContolAlignmentCenter;
    wmView.placeHoldImage = [UIImage imageNamed:@"placeholderImage"];
    wmView.animationDuration = 1.0;
    [wmView startWithTapActionBlock:^(NSInteger index) {
        NSLog(@"点击了第%@张",@(index));
    }];
    [self initCollectionView];
}
-(void)initCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setHeaderReferenceSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.width*3/4)];
    
    cv = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    cv.delegate = self;
    cv.dataSource = self;
    cv.backgroundColor = [UIColor whiteColor];
    [cv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"WMBannerView"];
    [cv registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:cv];
    
}
#pragma mark
#pragma mark collectionDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 21;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.centerLabel.text = [NSString stringWithFormat:@"第%ld个cell",indexPath.row];
    cell.backgroundColor = [UIColor magentaColor];
    
    return cell;
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WMBannerView" forIndexPath:indexPath];
        [headerView addSubview:wmView];
        return headerView;
        
    }
    else{
        return nil;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.view.frame.size.width-5*6)/3, (self.view.frame.size.width-5*4)/3);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *index = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
