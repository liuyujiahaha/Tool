//
//  MainTabBarController.m
//  微品国际
//
//  Created by jia on 2017/10/25.
//  Copyright © 2017年 vpclub. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeVC.h"
#import "ShopVC.h"
#import "ShoppingCartVC.h"
#import "MineVC.h"
#import "BaseNC.h"
#import "LoginVC.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong)NSMutableArray *navMutArr;
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = hexStringToColor(@"F8F8F8");
    self.selectedIndex = 0;
    self.tabBar.userInteractionEnabled = YES;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    HomeVC *homeVC = [[HomeVC alloc]init];
    ShopVC *shopVC = [[ShopVC alloc]init];
    ShoppingCartVC *cartVC = [[ShoppingCartVC alloc]init];
    MineVC *mineVC = [[MineVC alloc]init];
    
    self.delegate = self;
    self.navMutArr = [[NSMutableArray alloc]init];
    
    [self addChildViewController:homeVC title:@"首页" imageName:@"common_home_nor" selectedImageName:@"common_home_press"];
    [self addChildViewController:shopVC title:@"市场" imageName:@"common_market_nor" selectedImageName:@"common_market_press"];
    [self addChildViewController:cartVC title:@"购物车" imageName:@"common_shopping_cart_nor" selectedImageName:@"common_shopping_cart_press"];
    [self addChildViewController:mineVC title:@"我的" imageName:@"common_my_nor" selectedImageName:@"common_my_press"];
    
    self.viewControllers = self.navMutArr;
}

-(void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:hexStringToColor(@"9823FD")} forState:UIControlStateSelected];

    BaseNC *baseNC = [[BaseNC alloc]initWithRootViewController:childController];
    [self.navMutArr addObject:baseNC];
}

#pragma mark - UITabBarControllerDelegate

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if (self.navMutArr[3] == viewController || self.navMutArr[2] == viewController) {
        NSString *isLogin = [[NSUserDefaults standardUserDefaults]stringForKey:@"IsLogin"];
        if ([isLogin isEqualToString:@"0"]) {
            BaseNC *LoginNav = [[BaseNC alloc]initWithRootViewController:[[LoginVC alloc]init]];
            [self presentViewController:LoginNav animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
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
