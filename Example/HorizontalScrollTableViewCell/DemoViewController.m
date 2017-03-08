//
//  DemoViewController.m
//  DemoHorizontalScrollTableView
//
//  Created by roger on 2017/3/3.
//  Copyright © 2017年 roger. All rights reserved.
//

#import "DemoViewController.h"
#import "CollectionViewCell.h"
#import "CollectionViewItem.h"
#import "Type2Item.h"
@interface DemoViewController ()<UITableViewDelegate,UITableViewDataSource,CollectionViewCellDelegate>
{
    
    __weak IBOutlet UITableView *_tableV;
    CollectionViewCell * _1CollecitonViewCell;
    CollectionViewCell * _2CollecitonViewCell;
}
@end

@implementation DemoViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"start");
    [_tableV registerClass:[CollectionViewCell class] forCellReuseIdentifier:@"CollectionViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return [CollectionViewCell getXibFrameHeightWithItemClassname:@"CollectionViewItem" TopOffset:10];
    }
    else{
        return [CollectionViewCell getXibFrameHeightWithItemClassname:@"Type2Item" TopOffset:10];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * className = @"CollectionViewCell";
    
    
    if (indexPath.row == 0) {
        if (_1CollecitonViewCell == nil) {
            _1CollecitonViewCell = [[CollectionViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
            [_1CollecitonViewCell configureCollectionViewCellDelegate:self tableViewIndexPath:indexPath rows:10 itemClassName:@"CollectionViewItem" topOffset:10];
        }
        
        return _1CollecitonViewCell;
    }
    else{
        if (_2CollecitonViewCell == nil) {
            _2CollecitonViewCell = [[CollectionViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
            [_2CollecitonViewCell configureCollectionViewCellDelegate:self tableViewIndexPath:indexPath rows:10 itemClassName:@"Type2Item" topOffset:10];
        }
        
        return _2CollecitonViewCell;
    }
}

#pragma mark - create random color
- (UIColor *)getRandomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

#pragma mark - collectionViewCell Delegate
- (UICollectionViewCell *)collectionViewCell:(CollectionViewCell *)collectionViewCell cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger tableViewIndexPathOfRow = [collectionViewCell getTableViewIndexPath].row;
    if (tableViewIndexPathOfRow == 0) {
        CollectionViewItem * cell = [[collectionViewCell getCollectionView] dequeueReusableCellWithReuseIdentifier:[collectionViewCell getItemClassName] forIndexPath:indexPath];
        cell.randomColorLabel.textColor = [self getRandomColor];
        return cell;
    }
    else if (tableViewIndexPathOfRow == 1){
        Type2Item * cell = [[collectionViewCell getCollectionView] dequeueReusableCellWithReuseIdentifier:[collectionViewCell getItemClassName] forIndexPath:indexPath];
        cell.backgroundColor = [self getRandomColor];
        
        return cell;
        
    }
    else{
        UICollectionViewCell * cell = [[collectionViewCell getCollectionView] dequeueReusableCellWithReuseIdentifier:[collectionViewCell getItemClassName] forIndexPath:indexPath];
        return cell;
    }
}

- (void)collectionViewCell:(CollectionViewCell *)CollectionViewCell didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *message = [NSString stringWithFormat:@"tableViewRow:%ld, numberOfItem:%ld",(long)[CollectionViewCell getTableViewIndexPath].row, (long)indexPath.row];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

@end
