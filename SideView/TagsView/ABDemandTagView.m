//
//  ABDemandTagView.m
//  108APP
//
//  Created by 云中科技 on 2018/6/4.
//  Copyright © 2018年 乐天. All rights reserved.
//

#import "ABDemandTagView.h"
#import "TagsView.h"
#import "Masonry.h"


#define WEAK_SELF           __weak __typeof(self) weakSelf = self;
//屏幕的高度
#define kScreenHeight                    [[UIScreen mainScreen] bounds].size.height

//屏幕的宽度
#define kScreenWidth                    [[UIScreen mainScreen] bounds].size.width

@interface ABDemandTagView ()<TagsViewDelegate>
{
    
}
@property(nonatomic,strong)UIView * blackView;
@property(nonatomic,strong)UIView * whiteView;
@property(nonatomic,strong)TagsView * tagsView;

@property(nonatomic,strong)UIButton * closeButton;
@property(nonatomic,strong)UIButton * resetButton;
@property(nonatomic,strong)UIButton * enterButton;
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UILabel * nameLabel;

@property(nonatomic,strong)NSMutableArray * chooseTagsArray;
@property(nonatomic,strong)NSMutableArray * showTagsArray;
@property(nonatomic,assign)NSInteger tagindex;

@end

@implementation ABDemandTagView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCurrentViewSubViews];
        [self layoutCurrentViewSubView];
    }
    return self;
}
//添加子 view 到当前 view
-(void)addCurrentViewSubViews
{
    self.tagindex = 0;
    
    [self addSubview:self.blackView];
    [self addSubview:self.whiteView];
    
    [self.whiteView addSubview:self.lineView];
    [self.whiteView addSubview:self.nameLabel];
    [self.whiteView addSubview:self.closeButton];
    [self.whiteView addSubview:self.enterButton];
    [self.whiteView addSubview:self.resetButton];
    [self.whiteView addSubview:self.tagsView];
}


//布局添加的子 view
-(void)layoutCurrentViewSubView
{
    [self.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.right.top.bottom.offset(0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(2);
        make.height.offset(20);
        make.top.offset(40);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right).offset(5);
        make.centerY.equalTo(self.lineView.mas_centerY).offset(0);
        make.height.offset(20);
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.width.height.offset(20);
        make.centerY.equalTo(self.lineView.mas_centerY).offset(0);
    }];
    [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.offset(0);
        make.right.equalTo(self.whiteView.mas_centerX).offset(0);
        make.height.offset(50);
    }];
    [self.enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(0);
        make.left.equalTo(self.whiteView.mas_centerX).offset(0);
        make.height.offset(50);
    }];
    [self.tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.lineView.mas_bottom).offset(10);
        make.bottom.equalTo(self.resetButton.mas_top).offset(-10);
    }];
}
-(void)reloadTagsViewName:(NSString *)name titles:(NSArray *)tags
{
    self.nameLabel.text = name;
    
    [self.showTagsArray removeAllObjects];
    [self.showTagsArray addObjectsFromArray:tags];
    [self.tagsView reloadTagsView:tags titleFont:[UIFont systemFontOfSize:12] titleColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] singleSelection:YES currentTitle:tags[0]];
}
-(void)selectedButton:(NSString *)title index:(NSInteger)index
{
    self.tagindex = index;
}
-(void)enterButtonClick:(UIButton *)sender
{
    WEAK_SELF
    if (sender==self.enterButton)
    {
        NSArray * array = [self.tagsView getChooseTags];
        if (self.chooseTagsOver) {
            self.chooseTagsOver(array);
        }
        if (self.chooseTagOver) {
            self.chooseTagOver(weakSelf.tagindex);
        }
        [self dismissTagsView];
    }
    else if (sender==self.closeButton)
    {
        [self dismissTagsView];
    }
    else if (sender==self.resetButton)
    {
        self.tagindex = 0;
        [self.chooseTagsArray removeAllObjects];
        [self.chooseTagsArray addObject:self.showTagsArray.firstObject];
        [self.tagsView resetTagsView];
    }
}
-(void)showTagsView
{
    self.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView commitAnimations];
}
-(void)dismissTagsView
{
    if (self.closeTagViewOver) {
        self.closeTagViewOver();
    }
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView commitAnimations];
    
}
-(NSMutableArray *)chooseTagsArray
{
    if (!_chooseTagsArray) {
        _chooseTagsArray = [[NSMutableArray alloc] init];
    }
    return _chooseTagsArray;
}
-(NSMutableArray *)showTagsArray
{
    if (!_showTagsArray) {
        _showTagsArray = [[NSMutableArray alloc] init];
    }
    return _showTagsArray;
}
-(TagsView*)tagsView
{
    if (!_tagsView) {
        _tagsView = [[TagsView alloc] init];
        _tagsView.frame = CGRectMake(60, 70, kScreenWidth-60, kScreenHeight-120);
        _tagsView.delegate = self;
    }
    return _tagsView;
}
-(UIView *)blackView
{
    if (!_blackView) {
        _blackView = [[UIView alloc] init];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.7;
    }
    return _blackView;
}
-(UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.backgroundColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

-(UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"关闭叉号"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(enterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}
-(UIButton *)resetButton
{
    if (!_resetButton) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _resetButton.layer.borderWidth = 0.5;
        _resetButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _resetButton.backgroundColor = [UIColor whiteColor];
        [_resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(enterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}
-(UIButton *)enterButton
{
    if (!_enterButton) {
        _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _enterButton.layer.borderWidth = 0.5;
        _enterButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _enterButton.backgroundColor = [UIColor redColor];
        [_enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_enterButton setTitle:@"确定" forState:UIControlStateNormal];
        [_enterButton addTarget:self action:@selector(enterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterButton;
}


@end
