//
//  BaseNC.m
//  微品国际
//
//  Created by jia on 2017/10/25.
//  Copyright © 2017年 vpclub. All rights reserved.
//

#import "BaseNC.h"

@interface BaseNC ()

@end

@implementation BaseNC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    [[UINavigationBar appearance]setTintColor:[UIColor blackColor]];
}



-(void)backToPreviousVC{
    [self popViewControllerAnimated:YES];
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([self.viewControllers count]>=1) {
        UIImage *backImg = [UIImage imageNamed:@"common_top_back"];
        
        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithImage:backImg style:UIBarButtonItemStylePlain target:self action:@selector(backToPreviousVC)];
        viewController.navigationItem.leftBarButtonItem = backBtn;
    }
    [super pushViewController:viewController animated:animated];
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
