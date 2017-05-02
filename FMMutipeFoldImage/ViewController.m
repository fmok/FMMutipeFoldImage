//
//  ViewController.m
//  FMMutipeFoldImage
//
//  Created by fm on 2017/5/2.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ViewController.h"
#import "FMMutipeFoldImageView.h"
#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define W_img 300.f
#define H_img 200.f

@interface ViewController ()

@property (nonatomic, strong) FMMutipeFoldImageView *imgView;
@property (nonatomic, strong) UIButton *foldBtn;
@property (nonatomic, strong) UIButton *resetBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.foldBtn];
    [self.view addSubview:self.resetBtn];
}

- (void)updateViewConstraints
{
    WS(weakSelf);
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(100.f);
        make.size.mas_equalTo(CGSizeMake(W_img, H_img));
    }];
    
    [self.foldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imgView.mas_bottom).offset(50.f);
        make.left.equalTo(weakSelf.imgView.mas_left).offset(50.f);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.foldBtn);
        make.right.equalTo(weakSelf.imgView.mas_right).offset(-50.f);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Events
- (void)flodAction:(UIButton *)sender
{
    [self.imgView foldImage];
}

- (void)resetAction:(UIButton *)sender
{
    [self.imgView resetImage];
}

#pragma mark - getter & setter
- (FMMutipeFoldImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[FMMutipeFoldImageView alloc] initWithFrame:CGRectMake(0, 0, W_img, H_img)];
        [_imgView setFoldImage:[UIImage imageNamed:@"Kiluya.jpg"]];
    }
    return _imgView;
}

- (UIButton *)foldBtn
{
    if (!_foldBtn) {
        _foldBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_foldBtn setTitle:@"fold" forState:UIControlStateNormal];
        [_foldBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_foldBtn addTarget:self action:@selector(flodAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _foldBtn;
}

- (UIButton *)resetBtn
{
    if (!_resetBtn) {
        _resetBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_resetBtn setTitle:@"reset" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_resetBtn addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
