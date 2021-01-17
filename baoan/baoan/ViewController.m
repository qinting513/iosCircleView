//
//  ViewController.m
//  baoan
//
//  Created by qt on 2021/1/15.
//

#import "ViewController.h"
#import "UIButton+layout.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScaleWidth(width)   ((width)*(kScreenWidth/375.f))

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}











-(void)setupCircleView {
    /*
     https://www.jianshu.com/p/0fbd3725ac87?utm_campaign
     主要是在于对layer的理解。view的底层是layer。所以控制位置的其实是layer。
     用layer的anchorPoint可以做出一个绕中心轴旋转的效果
     */
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
//    bgView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:bgView];
    NSLog(@"中心: %f -- %f", bgView.center.x, bgView.center.y);
    NSInteger count = 10;
    NSArray *lines = @[@"icon_line0.png",@"icon_line1.png",@"icon_line2.png",
                       @"icon_line3.png",@"icon_line4.png"];
    
    NSArray *companyImgs =  @[@"icon_b0.png",@"icon_b1.png",@"icon_b2.png",
                              @"icon_b3.png",@"icon_b4.png",@"icon_b5.png",
                              @"icon_b6.png",@"icon_b7.png",@"icon_b8.png",
                              @"icon_b9.png"];
    NSArray *companyTitles = @[@"制造业",@"建筑业",@"批发零售业",@"住宿餐饮业",@"文体旅游业",
                               @"教育服务业",@"医护保健业",@"商务服务业",@"农业牧鱼业",@"其他服务业"];
    
    NSArray *itemBgColors = @[[UIColor colorWithRed:28/255.0 green:134/255.0 blue:250/255.0 alpha:1.0],
                              [UIColor colorWithRed:251/255.0 green:179/255.0 blue:37/255.0 alpha:1.0],
                              [UIColor colorWithRed:20/255.0 green:158/255.0 blue:236/255.0 alpha:1.0],
                              [UIColor colorWithRed:252/255.0 green:92/255.0 blue:97/255.0 alpha:1.0],
                              [UIColor colorWithRed:69/255.0 green:159/255.0 blue:60/255.0 alpha:1.0],];
    int btnWH = kScaleWidth(70);
    for (int i = 0; i < count; i++) {
        UIView *itemView = [[UIView alloc]init];
        [bgView addSubview:itemView];
        //利用anchorPoint来控制view的位置
        itemView.bounds = CGRectMake(0, 0, kScaleWidth(20), kScaleWidth(150));
        itemView.layer.anchorPoint = CGPointMake(0.5,1.25);
        itemView.center = bgView.center;
        CGFloat radion = (360/count * i) / 180.0 * M_PI;
        itemView.transform = CGAffineTransformMakeRotation(radion);
        
       // 环外的按钮
        UIButton *itemBtn = [self createVerticalButtonWithTitle:companyTitles[i] imageName:companyImgs[i] bgColor:itemBgColors[i % 5] btnWH:btnWH tag:i];
        // +35往内收半径的距离 + 10x轴往右移动一点 刚好居中
        itemBtn.center = CGPointMake(itemView.bounds.origin.x + 10,  itemView.bounds.origin.y + btnWH/2.0);
        itemBtn.transform = CGAffineTransformMakeRotation(-radion);
        [itemView addSubview:itemBtn];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, btnWH, kScaleWidth(20), kScaleWidth(150)-btnWH)];
        line.image = [UIImage imageNamed:lines[i%5]];
        [itemView addSubview:line];
    }
    bgView.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    
    // 中间部分
    UIButton *companyBtn = [self createVerticalButtonWithTitle:@"企业办事" imageName:@"icon_qybs" bgColor:[UIColor whiteColor] btnWH:btnWH tag: -1];
    [self.view addSubview:companyBtn];
    [companyBtn setTitleColor:[UIColor colorWithRed:28/255.0 green:134/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
    companyBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    companyBtn.userInteractionEnabled = NO;
    companyBtn.center = bgView.center;
}
-(UIButton *)createVerticalButtonWithTitle:(NSString *)title imageName:(NSString *)imageName bgColor:(UIColor *)bgColor btnWH:(CGFloat)btnWH  tag:(NSInteger)tag {
//    button  https://www.cnblogs.com/demodashi/p/8509253.html
    UIButton *itemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnWH, btnWH)];
    itemBtn.backgroundColor = bgColor;
    itemBtn.layer.cornerRadius = btnWH/2.0;
    itemBtn.layer.masksToBounds = YES;
    itemBtn.tag = tag;
    if(tag != -1) {
      [itemBtn addTarget:self action:@selector(tapItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    [itemBtn setTitle:title forState:UIControlStateNormal];
    [itemBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    itemBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    itemBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [itemBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop imageTitleSpace: kScaleWidth(6)];
    return itemBtn;
}

-(void)tapItem:(UIButton *)btn {
    NSLog(@"%ld", btn.tag);
}

@end
