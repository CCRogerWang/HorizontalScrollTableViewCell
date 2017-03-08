//
//  CollectionViewCell.m
//  DemoHorizontalScrollTableView
//
//  Created by roger on 2017/3/3.
//  Copyright © 2017年 roger. All rights reserved.
//
#import "CollectionViewCell.h"


@implementation CollectionViewCell 
{
    Class cellClass;
    UICollectionView * _collectionView;
    NSString * _itemClassName;
    int _sections;
    int _rows;
    UIEdgeInsets _edgeInsets;
    NSIndexPath *_tableViewIndexPath;
    int _topOffest;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (CGFloat)getXibFrameHeightWithItemClassname:(NSString *)itemClassName TopOffset:(int) topOffset{
    NSArray * array = [[NSBundle mainBundle] loadNibNamed:itemClassName owner:self options:nil];
//    NSLog(@"cell height = %f",ceil([[array firstObject]frame].size.height + padding));
    return ceil([[array firstObject]frame].size.height + topOffset) + 1;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _sections = 1;
        _rows = 1;
        _edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        
    }
    return self;
}

- (void)removeCellSubViews{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark - configure
- (void)configureCollectionViewCellDelegate:(id<CollectionViewCellDelegate>)delegate
                         tableViewIndexPath:(NSIndexPath *)tableViewIndexPath
                                       rows:(int) rows
                              itemClassName:(NSString *)itemClassName
                                  topOffset:(int)topOffset{
    [self removeCellSubViews];
    self.delegate = delegate;
    _tableViewIndexPath = tableViewIndexPath;
    _rows = rows;
    _topOffest = topOffset;
    [self setCollectionViewAndItemClassNameWith:itemClassName];
    [self setCellFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [CollectionViewCell getXibFrameHeightWithItemClassname:_itemClassName TopOffset:topOffset])];
    
}

#pragma mark - setter
- (void)setRows:(int)rows{
    _rows = rows;
}

- (void)setSecions:(int)sections{
    _sections = sections;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    _edgeInsets = edgeInsets;
}

- (void)setCellFrame:(CGRect)frame{
    self.frame = frame;
}

- (void)setCellHeight:(CGFloat)height{
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
}


- (void)setCollectionViewAndItemClassNameWith:(NSString *) itemClassName{
    
    UICollectionViewFlowLayout *horizontalCellLayout = [UICollectionViewFlowLayout new];
    horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    horizontalCellLayout.sectionInset = _edgeInsets;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:horizontalCellLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView setShowsHorizontalScrollIndicator:NO];
    [self.contentView addSubview:_collectionView];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0  metrics:nil views:@{@"_collectionView":_collectionView}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[_collectionView]|",_topOffest] options:0  metrics:nil views:@{@"_collectionView":_collectionView}]];
    
    _itemClassName = itemClassName;
    cellClass = NSClassFromString(_itemClassName);
    [_collectionView registerNib:[UINib nibWithNibName:_itemClassName bundle:nil] forCellWithReuseIdentifier:_itemClassName];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

- (void)setTableViewIndexPath:(NSIndexPath *)tableViewIndexPath{
    _tableViewIndexPath = tableViewIndexPath;
}

#pragma mark - getter
- (NSString *)getItemClassName{
    return _itemClassName;
}

- (UICollectionView *)getCollectionView{
    return _collectionView;
}

- (NSIndexPath *)getTableViewIndexPath{
    return _tableViewIndexPath;
}

#pragma mark - collection view datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _sections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _rows;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* item = [[[UINib nibWithNibName:_itemClassName bundle:nil] instantiateWithOwner:self options:nil] lastObject];
    return item.frame.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =[self.delegate collectionViewCell:self cellForItemAtIndexPath:indexPath];
    return cell;
}



#pragma mark - collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate collectionViewCell:self didSelectItemAtIndexPath:indexPath];
}

@end
