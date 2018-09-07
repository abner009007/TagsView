//
//  PW_VideoTagsView.m
//  ThreeDimensional
//
//  Created by DFSJ on 17/2/28.
//  Copyright © 2017年 DFSJ. All rights reserved.
//

#import "TagsView.h"


@interface TagsView ()
{
    BOOL isSingleSelection;
    UIButton * currentButton;
    NSArray * tagsArray;
}
@property(nonatomic,strong)NSMutableArray * chooseTagsArray;
@end

@implementation TagsView













-(void)reloadTagsView:(NSArray *)array titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor titleSelectedColor:(UIColor *)titleSelectedColor backgroundColor:(UIColor *)backgroundColor backgroundSelectedColor:(UIColor *)backgroundSelectedColor singleSelection:(BOOL)singleSelection currentTitle:(NSString *)currentTitle
{
    tagsArray = array;
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    isSingleSelection = singleSelection;
    
    for (int i = 0; i < array.count; i ++)
    {
        NSString *name = array[i];
        
        static UIButton *recordBtn =nil;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = titleFont;
        CGRect rect = [name boundingRectWithSize:CGSizeMake(self.frame.size.width -20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
        
        CGFloat BtnW = rect.size.width + 20;
        CGFloat BtnH = rect.size.height + 10;
        
        BtnW = BtnW >= 80 ? BtnW : 80;
        BtnH = BtnH >= 30 ? BtnH : 30;
        
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 6;
        btn.layer.borderWidth = 1.0f;
        
        if (i == 0)
        {
            btn.frame =CGRectMake(10, 10 , BtnW, BtnH);
        }
        else
        {
            
            CGFloat yuWidth = self.frame.size.width - 20 - recordBtn.frame.origin.x -recordBtn.frame.size.width;
            if (yuWidth >= rect.size.width)
            {
                btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + 10, recordBtn.frame.origin.y, BtnW, BtnH);
            }
            else
            {
                btn.frame =CGRectMake(10, recordBtn.frame.origin.y+recordBtn.frame.size.height+10, BtnW, BtnH);
            }
            
        }
        [btn setTitle:name forState:UIControlStateNormal];
        
        [self addSubview:btn];
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width,CGRectGetMaxY(btn.frame)+10);
        
        recordBtn = btn;
        
        
        btn.tag = i;
        
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setTitleColor:titleSelectedColor forState:UIControlStateSelected];
        [btn setBackgroundImage:[self createImageWithColor:backgroundColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self createImageWithColor:backgroundSelectedColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (currentTitle.length>0)
        {
            if ([name isEqualToString:currentTitle])
            {
                btn.selected = YES;
                currentButton = btn;
            }
        }
        else
        {
            if (i == 0)
            {
                btn.selected = YES;
                currentButton = btn;
            }
        }
    }
}














////-----------------------------------

-(void)reloadTagsView:(NSArray *)array titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor selectedColor:(UIColor *)selectedColor singleSelection:(BOOL)singleSelection currentTitle:(NSString *)currentTitle
{
    tagsArray = array;
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    isSingleSelection = singleSelection;
    
    for (int i = 0; i < array.count; i ++)
    {
        NSString *name = array[i];
        
        static UIButton *recordBtn =nil;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = titleFont;
        CGRect rect = [name boundingRectWithSize:CGSizeMake(self.frame.size.width -20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
        
        CGFloat BtnW = rect.size.width + 20;
        CGFloat BtnH = rect.size.height + 10;
        
        
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = BtnH/2;
        //        btn.layer.borderWidth = 1.0f;
        //        btn.layer.borderColor = titleColor.CGColor;
        
        if (i == 0)
        {
            btn.frame =CGRectMake(10, 10 , BtnW, BtnH);
        }
        else
        {
            
            CGFloat yuWidth = self.frame.size.width - 20 -recordBtn.frame.origin.x -recordBtn.frame.size.width;
            if (yuWidth >= rect.size.width)
            {
                btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + 10, recordBtn.frame.origin.y, BtnW, BtnH);
            }
            else
            {
                btn.frame =CGRectMake(10, recordBtn.frame.origin.y+recordBtn.frame.size.height+10, BtnW, BtnH);
            }
            
        }
        [btn setTitle:name forState:UIControlStateNormal];
        
        [self addSubview:btn];
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width,CGRectGetMaxY(btn.frame)+10);
        
        recordBtn = btn;
        
        
        btn.tag = i;
        
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
        [btn setBackgroundImage:[self createImageWithColor:[UIColor groupTableViewBackgroundColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self createImageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (currentTitle.length>0)
        {
            if ([name isEqualToString:currentTitle])
            {
                btn.selected = YES;
                currentButton = btn;
            }
        }
        else
        {
            if (i == 0)
            {
                btn.selected = YES;
                currentButton = btn;
            }
        }
    }
}
-(void)buttonClick:(UIButton *)button{
    
    if (isSingleSelection == YES)
    {
        currentButton.selected = !currentButton.selected;
        button.selected = !button.selected;
        currentButton = button;
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(selectedButton:index:)]) {
            [self.delegate selectedButton:button.titleLabel.text index:button.tag];
        }
    }
    else
    {
        button.selected = !button.selected;
        if ([self.chooseTagsArray containsObject:tagsArray[button.tag]])
        {
            [self.chooseTagsArray removeObject:tagsArray[button.tag]];
        }
        else
        {
            [self.chooseTagsArray addObject:tagsArray[button.tag]];
        }
    }
}
-(void)resetTagsView
{
    [self.chooseTagsArray removeAllObjects];
    
    for (UIView * view in self.subviews) {
        UIButton * button = (UIButton *)view;
        if (button.tag==0)
        {
            button.selected = YES;
            currentButton = button;
            [self.chooseTagsArray addObject:tagsArray[button.tag]];
        }
        else
        {
            button.selected = NO;
        }
    }
}
-(NSArray *)getChooseTags
{
    return self.chooseTagsArray;
}
-(NSMutableArray *)chooseTagsArray
{
    if (!_chooseTagsArray) {
        _chooseTagsArray = [[NSMutableArray alloc] init];
    }
    return _chooseTagsArray;
}
- (UIImage *)createImageWithColor:(UIColor *)color
{
    return [self createImageWithColor:color width:1.0f height:1.0f];
}

- (UIImage *)createImageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height
{
    CGRect rect=CGRectMake(0.0f, 0.0f, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
