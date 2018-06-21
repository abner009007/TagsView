//
//  ViewController.m
//  SideView
//
//  Created by 云中科技 on 2018/6/21.
//  Copyright © 2018年 abner. All rights reserved.
//

#import "ViewController.h"
#import "ABDemandTagView.h"

//屏幕的高度
#define kScreenHeight                    [[UIScreen mainScreen] bounds].size.height

//屏幕的宽度
#define kScreenWidth                    [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

@property(nonatomic,strong)ABDemandTagView * chooseTagsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.chooseTagsView reloadTagsViewName:@"分类" titles:@[@"11",@"2222222222222222",@"33",@"44",@"555555",@"66",@"77",@"888888888888888",]];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.chooseTagsView showTagsView];
}



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
@end
