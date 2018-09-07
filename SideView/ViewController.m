//
//  ViewController.m
//  SideView
//
//  Created by 云中科技 on 2018/6/21.
//  Copyright © 2018年 abner. All rights reserved.
//

#import "ViewController.h"
#import "ABDemandTagView.h"
#import "TagsView.h"

//屏幕的高度
#define kScreenHeight                    [[UIScreen mainScreen] bounds].size.height

//屏幕的宽度
#define kScreenWidth                    [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<TagsViewDelegate>

@property(nonatomic,strong)ABDemandTagView * chooseTagsView;
@property(nonatomic,strong)TagsView * tagsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.chooseTagsView reloadTagsViewName:@"分类" titles:@[@"11",@"2222222222222222",@"33",@"44",@"555555",@"66",@"77",@"888888888888888",]];
    
    
    
    
    //    [self.tagsView reloadTagsView:@[@"11",@"2222222222222222",@"33",@"44",@"555555",@"66",@"77",@"888888888888888",] titleFont:[UIFont systemFontOfSize:12] titleColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] singleSelection:YES currentTitle:@"11"];
    
    
    [self.tagsView reloadTagsView:@[@"11",@"22222",@"33",@"44",@"55",@"66",@"77",@"8888"] titleFont:[UIFont systemFontOfSize:12] titleColor:[UIColor blackColor] titleSelectedColor:[UIColor whiteColor] backgroundColor:[UIColor groupTableViewBackgroundColor] backgroundSelectedColor:[UIColor redColor] singleSelection:NO currentTitle:@""];
    
    [self.view addSubview:self.tagsView];
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.chooseTagsView showTagsView];
//}



-(ABDemandTagView *)chooseTagsView
{
    if (!_chooseTagsView) {
        _chooseTagsView = [[ABDemandTagView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _chooseTagsView.chooseTagOver = ^(NSInteger index) {
            NSLog(@"-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=%ld",index);
        };
    }
    return _chooseTagsView;
}

-(TagsView*)tagsView
{
    if (!_tagsView) {
        _tagsView = [[TagsView alloc] init];
        _tagsView.frame = CGRectMake(0, 100, kScreenWidth, 300);
        _tagsView.delegate = self;
        _tagsView.backgroundColor = [UIColor blackColor];
    }
    return _tagsView;
}
@end
