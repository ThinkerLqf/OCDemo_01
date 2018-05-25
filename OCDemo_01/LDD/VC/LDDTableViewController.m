//
//  LDDTableViewController.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/5/18.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDTableViewController.h"
#import "BaseViewController.h"
#import "MyMacro.h"
#import "AppDelegate.h"
#import "NotificationVC.h"
#import "IQKeyboardVC.h"
#import "LDDVC1.h"

@interface LDDTableViewController ()

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@end

@implementation LDDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationItem.leftBarButtonItem setTitle:@"返回"];
    
    self.title = @"LDD";
    self.titles = [NSMutableArray arrayWithCapacity:0];
    self.classNames = [NSMutableArray arrayWithCapacity:0];
    //1
    [self addCell:@"IQKeyboardManager" class:@"IQKeyboardVC"];
    //2
    [self addCell:@"通知:点击使Appdelegate发通知" class:@"1"];
    //3
    [self addCell:@"通知:模拟通知造成的内存泄漏" class:@"2"];
    //4
    [self addCell:@"通知:再次发送通知" class:@"3"];
    //5
    [self addCell:@"全屏侧滑返回" class:@"4"];
    //6
    [self addCell:@"几种按钮" class:@"IQKeyboardVC"];
    //7
    [self addCell:@"Masonary:约束条件先后顺序影响" class:@"IQKeyboardVC"];
    //8
    [self addCell:@"Masonary:并列的view通过间隔计算宽度" class:@"IQKeyboardVC"];
    //9
    [self addCell:@"Masonary:Label的一些自适应" class:@"IQKeyboardVC"];
    //10
    [self addCell:@"RAC:RAC宏" class:@"IQKeyboardVC"];
    //11
    [self addCell:@"RAC:RACSignal对象调subscribeNext方法" class:@"IQKeyboardVC"];
    //12
    [self addCell:@"RAC:RACSubject" class:@"5"];
    //13
    [self addCell:@"RAC:RACCommand" class:@"6"];
    //14
    [self addCell:@"RAC:RACCommand与RACSubject套用" class:@"IQKeyboardVC"];
    //15
    [self addCell:@"UIDatePicker" class:@"IQKeyboardVC"];
    //16
    [self addCell:@"PGDatePicker" class:@"IQKeyboardVC"];
    //17
    [self addCell:@"UICollectionView" class:@"LDDVC1"];
    
    [k_NotificationCenter addObserver:self selector:@selector(changeCellText:) name:@"changeCellText" object:nil];
    
    [self.tableView reloadData];
}

- (void)changeCellText:(NSNotification *)noti {
    for (NSInteger i = 0; i < self.classNames.count; i++) {
        NSString *className = self.classNames[i];
        if ([className isEqualToString:@"1"]) {
            self.titles[i] = noti.object;
            [self.tableView reloadData];
            return;
        }
    }
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.tag = indexPath.row;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row+1,self.titles[indexPath.row]];
//    NSLog(@"cell tag:%ld",cell.tag);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        BaseViewController *vc = [class new];
        vc.index = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        if ([className isEqualToString:@"1"]) {
            [k_Appdelegate postNotification];
        }
        else if ([className isEqualToString:@"2"]) {
            NotificationVC *vc1 = [[NotificationVC alloc] init];
            [vc1 addLeakObserver];
            
            NotificationVC *vc2 = [[NotificationVC alloc] init];
            [vc2 postNotification];
        }
        else if ([className isEqualToString:@"3"]) {
            NotificationVC *vc2 = [[NotificationVC alloc] init];
            [vc2 postNotification];
        }
        else if ([className isEqualToString:@"5"]) {
            IQKeyboardVC *vc = [IQKeyboardVC new];
            vc.index = indexPath.row;
            
            // RACSubject既可以发送信号，也可以订阅信号
            // 此处为订阅信号
            [vc.subject subscribeNext:^(id  _Nullable x) {
                weakSelf.titles[indexPath.row] = [NSString stringWithFormat:@"RACSubject接收到----->%@",x];
                [weakSelf.tableView reloadData];
            }];
            
            vc.sendMessageBlock = ^(NSString *message) {
                weakSelf.titles[indexPath.row] = [NSString stringWithFormat:@"Block接收到----->%@",message];
                [weakSelf.tableView reloadData];
            };
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([className isEqualToString:@"6"]) {
            IQKeyboardVC *vc = [IQKeyboardVC new];
            vc.index = indexPath.row;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
