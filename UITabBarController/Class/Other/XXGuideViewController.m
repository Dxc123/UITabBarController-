//
//  XXGuideViewController.m
//  UITabBarController
//
//  Created by Dxc_iOS on 2017/4/4.
//  Copyright © 2017年 Dxc. All rights reserved.
//

#import "XXGuideViewController.h"
#import "UIView+Extension.h"
#import "XXTabBarViewController.h"
#define imageCount 4
// RGB颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define RandomColor RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface XXGuideViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;


@end

@implementation XXGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.创建scrollView
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
   
     // 2.添加图片到scrollView中
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    for (NSInteger i = 0; i < imageCount; i++) {
        UIImageView *imgeView = [[UIImageView alloc]initWithFrame:CGRectMake(i * imageW, 0, imageW, imageH)];
        NSString *name = [NSString stringWithFormat:@"new_feature_%ld",i+1];
        imgeView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imgeView];
        if (i == imageCount - 1) {//设置最后一张图片
            [self setupLastImageView:imgeView];
        }
        
    }
    // 3.设置scrollView属性
    scrollView.contentSize = CGSizeMake(imageCount * imageW, 0);
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.bounces=NO;
    scrollView.delegate=self;
    scrollView.pagingEnabled=YES;
    
    // 4.添加pageControl，用于分页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = imageCount;
    pageControl.currentPageIndicatorTintColor =RGBColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = RGBColor(189, 189, 189);
    pageControl.centerX = imageW /2;
    pageControl.centerY = imageH -50;
    [self.view addSubview:pageControl];
    self.pageControl=pageControl;

    

}
- (void)setupLastImageView:(UIImageView *)imageView{
    imageView.userInteractionEnabled=YES;
    
    // 1.分享给大家
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.size = CGSizeMake(200, 30);
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];

    // 2.开始微博
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];

    
}
- (void)shareClick:(UIButton *)shareBtn
{
    // 状态取反
    shareBtn.selected = !shareBtn.isSelected;
}
- (void)startClick
{
    
    // 切换到MainViewController，NewfeatureViewController会被销毁
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[XXTabBarViewController alloc] init];
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    
    // 四舍五入计算出页码(强转为整数)
    self.pageControl.currentPage = (int)page + 0.5;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
