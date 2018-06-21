//
//  PW_VideoTagsView.h
//  ThreeDimensional
//
//  Created by DFSJ on 17/2/28.
//  Copyright © 2017年 DFSJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TagsViewDelegate <NSObject>



-(void)selectedButton:(NSString *)title index:(NSInteger)index;


@end

@interface TagsView : UIView

@property(nonatomic,assign)id<TagsViewDelegate>delegate;



-(void)reloadTagsView:(NSArray *)array titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor selectedColor:(UIColor *)selectedColor singleSelection:(BOOL)singleSelection currentTitle:(NSString *)currentTitle;
-(NSArray *)getChooseTags;
-(void)resetTagsView;

@end
