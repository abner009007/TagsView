//
//  ABDemandTagView.h
//  108APP
//
//  Created by 云中科技 on 2018/6/4.
//  Copyright © 2018年 乐天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABDemandTagView : UIView



@property(nonatomic,copy)void(^chooseTagsOver)(NSArray * tags);

@property(nonatomic,copy)void(^chooseTagOver)(NSInteger index);

@property(nonatomic,copy)void(^closeTagViewOver)(void);


-(void)showTagsView;

-(void)reloadTagsViewName:(NSString *)name titles:(NSArray *)tags;

@end
