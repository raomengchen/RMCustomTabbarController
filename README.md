# RMCustomTabbarController

CocoaPods

增加 pod 'RMCustomTabbarController'
pod install 或者 pod update.

导入 #import "RMTabBarViewController.h" 继承这个类，也可以直接使用


![image](https://github.com/raomengchen/RMCustomTabbarController/blob/master/666.gif)

使用的方法

UIStoryboard *news = [UIStoryboard storyboardWithName:@"News" bundle:nil];
WMNewsViewController *newsVC = [news instantiateViewControllerWithIdentifier:@"WMNewsViewController"];
UIViewController *newsNVC = [self setupChildViewController:newsVC navigationController:[WMNavigationViewController class] title:@"资讯" imageName:@"home_page" selectedImageName:@"home_page1" offset:NO];

UIStoryboard *chooseCar = [UIStoryboard storyboardWithName:@"ChooseCar" bundle:nil];
WMChooseCarViewController *chooseCarVC = [chooseCar instantiateViewControllerWithIdentifier:@"WMChooseCarViewController"];
UIViewController *chooseCarNVC = [self setupChildViewController:chooseCarVC navigationController:[WMNavigationViewController class] title:@"选车" imageName:@"home_page" selectedImageName:@"home_page1" offset:NO];

想要哪个按钮偏移 offset这个属性设置成yes

UIStoryboard *pricrReduce1 = [UIStoryboard storyboardWithName:@"PriceReduce" bundle:nil];
WMPriceReduceViewController *pricrReduceVC1 = [pricrReduce1 instantiateViewControllerWithIdentifier:@"WMPriceReduceViewController"];
UIViewController *pricrReduceNVC1 = [self setupChildViewController:pricrReduceVC1 navigationController:[WMNavigationViewController class] title:@"降价" imageName:@"Choose_a_car" selectedImageName:@"Choose_a_car" offset:YES];


UIStoryboard *pricrReduce = [UIStoryboard storyboardWithName:@"PriceReduce" bundle:nil];
WMPriceReduceViewController *pricrReduceVC = [pricrReduce instantiateViewControllerWithIdentifier:@"WMPriceReduceViewController"];
UIViewController *pricrReduceNVC = [self setupChildViewController:pricrReduceVC navigationController:[WMNavigationViewController class] title:@"降价" imageName:@"home_page" selectedImageName:@"home_page1" offset:NO];



UIStoryboard *usercenter = [UIStoryboard storyboardWithName:@"UserCenter" bundle:nil];
WMUserCenterViewController *usercenterVC = [usercenter instantiateViewControllerWithIdentifier:@"WMUserCenterViewController"];
UIViewController *usercenterNVC = [self setupChildViewController:usercenterVC navigationController:[WMNavigationViewController class] title:@"我的" imageName:@"home_page" selectedImageName:@"home_page1" offset:NO];


self.viewControllers = @[newsNVC,chooseCarNVC,pricrReduceNVC1,pricrReduceNVC,usercenterNVC];

![image](https://github.com/raomengchen/RMCustomTabbarController/blob/master/77.gif)

