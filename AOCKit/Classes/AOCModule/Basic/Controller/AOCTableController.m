//
//  AOCTableController.m
//  AOCKit
//
//  Created by ssbm on 2021/4/26.
//

#import "AOCTableController.h"
#import "AOCDefineSize.h"
#import "AOCDefineColor.h"

@interface AOCTableController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (nonatomic, strong) UITableView *tableView; // 列表视图
@end

@implementation AOCTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kTableCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"kTableCell"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - Getter

// 列表视图
- (UITableView *)tableView {
    if (_tableView) return _tableView;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = kCOLOR_VIEW_BG;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    return _tableView;
}

@end
