//
//  CollectionViewCell.h
//  DemoHorizontalScrollTableView
//
//  Created by roger on 2017/3/3.
//  Copyright © 2017年 roger. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionViewCell;

@protocol CollectionViewCellDelegate
@required
- (void)collectionViewCell:(CollectionViewCell *)CollectionViewCell didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionViewCell *)collectionViewCell:(CollectionViewCell *)collectionViewCell cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CollectionViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) id<CollectionViewCellDelegate> delegate;

+ (CGFloat)getXibFrameHeightWithItemClassname:(NSString *)itemClassName TopOffset:(int) topOffset;

#pragma mark - configure

- (void)configureCollectionViewCellDelegate:(id<CollectionViewCellDelegate>)delegate
                         tableViewIndexPath:(NSIndexPath *)tableViewIndexPath
                                       rows:(int) rows
                              itemClassName:(NSString *)itemClassName
                                  topOffset:(int)topOffset;

#pragma mark - setter
- (void)setRows:(int)rows;

- (void)setSecions:(int)sections;

- (void)setCellFrame:(CGRect)frame;

- (void)setCellHeight:(CGFloat)height;

- (void)setCollectionViewAndItemClassNameWith:(NSString *) itemClassName;

- (void)setTableViewIndexPath:(NSIndexPath *)tableViewIndexPath;

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets;

#pragma mark - getter
- (NSString *)getItemClassName;

- (UICollectionView *)getCollectionView;

- (NSIndexPath *)getTableViewIndexPath;

@end
