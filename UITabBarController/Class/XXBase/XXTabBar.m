//
//  XXTabBar.m
//  UITabBarController
//
//  Created by 代星创 on 2017/3/8.
//  Copyright © 2017年 Dxc. All rights reserved.
//

#import "XXTabBar.h"
#import "UIView+Extension.h"
@interface XXTabBar ()
@property (nonatomic,strong)UIButton *publishButton;
@property (nonatomic, weak) UILabel *label;
@end
@implementation XXTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"button_write"] forState:UIControlStateNormal];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.publishButton = plusBtn;
        [self addSubview:self.publishButton];
        
//        UILabel *label = [[UILabel alloc] init];
//        label.text = @"发布";
//        label.font = [UIFont systemFontOfSize:11];
//        [label sizeToFit];
//        label.textColor = [UIColor grayColor];
//         self.label = label;
//        [self addSubview:label];
        

    
    }
    return self;
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    /****2.****/
//    self.publishButton.center.x = self.frame.size.width /2;//会报错，必须使用类扩展转换)
//    self.publishButton.center.y = self.frame.size.height /2;
    
    
    // 1.设置加号按钮的位置
    self.publishButton.centerX = self.width/2;
    self.publishButton.centerY = self.height/2 ;//-8;
    
    self.label.centerX = self.publishButton.centerX;
    self.label.centerY = CGRectGetMaxY(self.publishButton.frame) ;//+ 5;


    //2.设置其他tabbarButton的位置和尺寸
    CGFloat tabBarButtonW  = self.width / 5;//每一个按钮的宽度==tabbar的五分之一
    CGFloat tabbarButtonIndex = 0;
    
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
    
            // 设置x
            child.x = tabbarButtonIndex * tabBarButtonW;
            // 设置宽度
            child.width = tabBarButtonW;
            // 增加索引
            tabbarButtonIndex++;
            if (tabbarButtonIndex == 2) {
                //索引=2时跳过
            
                tabbarButtonIndex++;
            }

        }
    }
  
    

}

- (void)plusBtnClick

{
    NSLog(@"%s",__func__);
    // 通知代理
    if ( self.delegate && [self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
