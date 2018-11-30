//
//  QSSelectMenuView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSelectMenuView.h"
#import "QSSelectMenuCell.h"

#define     WIDTH_TABLEVIEW         140.0f
#define     HEIGHT_TABLEVIEW_CELL   45.0f
#define     NAVBAR_HEIGHT           44.0f
#define     STATUSBAR_HEIGHT        (IS_IPHONEX ? 44.0f : 20.0f)
#define     IS_IPHONEX              \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

@interface QSSelectMenuView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *data;

@end

@implementation QSSelectMenuView

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.tableView];
        
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:panGR];
        
        [self.tableView registerClass:[QSSelectMenuCell class] forCellReuseIdentifier:@"QSAddMenuCell"];
    }
    return self;
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    [self setNeedsDisplay];
    [self setFrame:view.bounds];
    
    if (self.delegate
        && [self.delegate respondsToSelector:@selector(dataSourceInSelectMenuView:)]) {
        self.data = [self.delegate dataSourceInSelectMenuView:self];
        [self.tableView reloadData];
        
        CGRect rect = CGRectMake(view.width - WIDTH_TABLEVIEW - 5, NAVBAR_HEIGHT + STATUSBAR_HEIGHT + 10, WIDTH_TABLEVIEW, self.data.count * HEIGHT_TABLEVIEW_CELL);
        [self.tableView setFrame:rect];
    }
}

- (BOOL)isShow
{
    return self.superview != nil;
}

- (void)dismiss
{
    [UIView animateWithDuration:0.2 animations:^{
        [self setAlpha:0.0f];
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            [self setAlpha:1.0];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

#pragma mark - Delegate -
//MARK: UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QSSelectMenuItem *item = [self.data objectAtIndex:indexPath.row];
    QSSelectMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QSAddMenuCell"];
    [cell setItem:item];
    return cell;
}

//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QSSelectMenuItem *item = [self.data objectAtIndex:indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(selectMenuView:didSelectedItem:)]) {
        [_delegate selectMenuView:self didSelectedItem:item];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self dismiss];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_TABLEVIEW_CELL;
}

#pragma mark - Private Methods -
- (void)drawRect:(CGRect)rect
{
    CGFloat startX = self.width - 30;
    CGFloat startY = STATUSBAR_HEIGHT + NAVBAR_HEIGHT + 3;
    CGFloat endY = STATUSBAR_HEIGHT + NAVBAR_HEIGHT + 10;
    CGFloat width = 6;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddLineToPoint(context, startX + width, endY);
    CGContextAddLineToPoint(context, startX - width, endY);
    CGContextClosePath(context);
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark - Getter -
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        [_tableView setScrollEnabled:NO];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBackgroundColor:[UIColor whiteColor]];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView.layer setMasksToBounds:YES];
        [_tableView.layer setCornerRadius:3.0f];
    }
    return _tableView;
}


@end
