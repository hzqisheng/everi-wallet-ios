//
//  QSPropetyHomeSwipeView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSPropetyHomeSwipeView.h"

#define degreeTOradians(x) (M_PI * (x)/180)
//childView之间左右距离
const int LEFT_RIGHT_MARGIN = 19;
//childView之间上下距离
const int TOP_BOTTM_MARGIN = 9;

//不止一个view时 第一个view距离父view的顶部的值
#define TOP_MARGTIN  kRealValue(50)
#define Left_MARGTIN kRealValue(26)

@interface QSPropetyHomeSwipeView ()

//背景图片
@property(nonatomic, strong) UIImageView *backgroundBlurImageView;
//毛玻璃
@property(nonatomic, strong) UIVisualEffectView *visualEffectView;
//已经划动到边界外的一个view
@property(nonatomic, weak) UITableViewCell *viewRemove;
//放当前显示的子View的数组
@property(nonatomic, strong) NSMutableArray * cacheViews;
//view总共的数量
@property(nonatomic, assign) NSInteger totalNum;
//当前的下标
@property(nonatomic, assign) NSInteger nowIndex;
//触摸开始的坐标
@property(nonatomic, assign) CGPoint pointStart;
//上一次触摸的坐标
@property(nonatomic, assign) CGPoint pointLast;
//最后一次触摸的坐标
@property(nonatomic, assign) CGPoint pointEnd;
//正在显示的cell
@property(nonatomic, weak) UITableViewCell *nowCell;
//下一个cell
@property(nonatomic, weak) UITableViewCell *nextCell;
//第三个cell
@property(nonatomic, weak) UITableViewCell *thirdCell;
//自身的宽度
@property(nonatomic, assign) NSInteger viewWidth;
//自身的高度
@property(nonatomic, assign) NSInteger viewHeight;
//cell的宽度
@property(nonatomic, assign) NSInteger cellW;
@property(nonatomic, assign) NSInteger secondCellW;
@property(nonatomic, assign) NSInteger thirdCellW;
//cell的高度
@property(nonatomic, assign) NSInteger cellH;
//是否是第一次执行
@property(nonatomic, assign) BOOL isFirstLayoutSub;
//是否能执行滑动
@property (nonatomic, assign) BOOL canSwipe;
//子view的位置 reloadData后确定
@property (nonatomic, assign) CGFloat firstCellX;
@property (nonatomic, assign) CGFloat firstCellY;
@property (nonatomic, assign) CGFloat secondCellX;
@property (nonatomic, assign) CGFloat secondCellY;
@property (nonatomic, assign) CGFloat thirdCellX;
@property (nonatomic, assign) CGFloat thirdCellY;


@end

@implementation QSPropetyHomeSwipeView

//从xib中加载该类
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSelf];
}
//直接用方法初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initSelf];
    return self;
}

//进行一些自身的初始化和设置
- (void)initSelf {
    self.canSwipe = YES;
    self.clipsToBounds = YES;
    self.cacheViews = [[NSMutableArray alloc]init];
    //手势识别
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    //毛玻璃背景
    self.backgroundBlurImageView = [[UIImageView alloc] init];
    [self addSubview:self.backgroundBlurImageView];
}

//布局subview的方法
- (void)layoutSubviews {
    if(!self.isFirstLayoutSub) {
        self.isFirstLayoutSub = YES;
        self.viewWidth = self.bounds.size.width;
        self.viewHeight = self.bounds.size.height;
        self.backgroundBlurImageView.frame = self.bounds;
        [self reloadData];
    }
}

- (NSInteger)getNumberOfCellInSwipeView {
    return [self.delegate numberOfCellInSwipeView:self];
}

- (CGSize)getCellSizeInSwipeView {
    return [self.delegate sizeForPerCellInSwipeView:self];
}

- (UITableViewCell *)getCellAtIndex:(NSInteger)index {
    return [self.delegate swipeView:self CellAtIndex:index];
}

//重新加载数据方法，会再首次执行layoutSubviews的时候调用
- (void)reloadData {
    if (!self.delegate||![self.delegate respondsToSelector:@selector(swipeView:CellAtIndex:)]||![self.delegate respondsToSelector:@selector(numberOfCellInSwipeView:)] || ![self.delegate respondsToSelector:@selector(sizeForPerCellInSwipeView:)]) {
        return;
    }
    self.totalNum = [self getNumberOfCellInSwipeView];
    if (self.totalNum == 0) {return;}
    
    self.cellW = [self getCellSizeInSwipeView].width;
    self.cellH = [self getCellSizeInSwipeView].height;
    self.viewRemove = nil;
    self.nowIndex = 0;
    
    //第一个cell
    [self.nowCell removeFromSuperview];
    if (self.nextCell) {
        [self.nextCell removeFromSuperview];
    }
    if (self.thirdCell) {
        [self.thirdCell removeFromSuperview];
    }
    UITableViewCell *nowCell = [self getCellAtIndex:self.nowIndex];
    CGSize cellSize = [self getCellSizeInSwipeView];
    self.firstCellX = self.viewWidth/2 - cellSize.width/2 - 6;
    self.firstCellY = TOP_MARGTIN + kiPhoneXTabBarExtraHeight;
    CGFloat firstCellW = self.cellW;
    CGFloat firstCellH = self.cellH;
    //只有一个view的时候居中显示
    if (self.totalNum < 2) {
        self.firstCellX = self.viewWidth/2 - self.cellW/2;
        self.firstCellY = (self.viewHeight - kiPhoneXTabBarExtraHeight)/2 - self.cellH/2 + kiPhoneXTabBarExtraHeight;
    }
    nowCell.layer.anchorPoint = CGPointMake(1, 1);
    nowCell.frame = CGRectMake(self.firstCellX, self.firstCellY, firstCellW, firstCellH);
    [self addSubview:nowCell];
    self.nowCell = nowCell;
    
    //第二个cell
    if (self.totalNum < 2) { return;}
    NSInteger secondCellIndex = self.nowIndex + 1 < self.totalNum ? self.nowIndex + 1 : 0;
    UITableViewCell *nextCell = [self getCellAtIndex:secondCellIndex];
    self.secondCellX = CGRectGetMinX(nowCell.frame) + LEFT_RIGHT_MARGIN;
    self.secondCellY = CGRectGetMinY(nowCell.frame) + TOP_BOTTM_MARGIN;
    self.secondCellW = self.cellW - LEFT_RIGHT_MARGIN * 2;
    CGFloat secondCellH = self.cellH;
    nextCell.layer.anchorPoint = CGPointMake(1, 1);
    nextCell.frame = CGRectMake(self.secondCellX, self.secondCellY, self.secondCellW, secondCellH);
    [self insertSubview:nextCell belowSubview:nowCell];
    self.nextCell = nextCell;
    
    //第三个cell
    if (self.totalNum < 3) { return;}
    NSInteger thirdCellIndex = self.nowIndex + 2 < self.totalNum ? self.nowIndex + 2 : self.nowIndex + 2 - self.totalNum;
    UITableViewCell *thirdCell = [self getCellAtIndex:thirdCellIndex];
    self.thirdCellX = CGRectGetMinX(nextCell.frame) + LEFT_RIGHT_MARGIN;
    self.thirdCellY = CGRectGetMinY(nextCell.frame) + TOP_BOTTM_MARGIN;
    self.thirdCellW = self.secondCellW - 2*LEFT_RIGHT_MARGIN;
    CGFloat thirdCellH = self.cellH;
    thirdCell.layer.anchorPoint = CGPointMake(1, 1);
    thirdCell.frame = CGRectMake(self.thirdCellX, self.thirdCellY, self.thirdCellW, thirdCellH);
    [self insertSubview:thirdCell belowSubview:nextCell];
    self.thirdCell = thirdCell;
    
    if (self.isStackCard) {
        [thirdCell setAlpha:0.3f];
        [nextCell setAlpha:0.5f];
        [nowCell setAlpha:1];
    }
}

#pragma mark swipe触摸的相关手势处理
- (void)swipe:(UISwipeGestureRecognizer*)sender {
    NSLog(@"swipe");
}

- (void)pan:(UIPanGestureRecognizer*)sender {
    if (self.totalNum < 2) {return;}
    CGPoint translation = [sender translationInView: self];
    //CGPoint speed=[sender velocityInView:self];//获取速度
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"begin");
        self.pointStart = translation;
        self.pointLast = translation;
    }
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        //NSLog(@"change");
        //        CGFloat xMove=translation.x-self.pointLast.x;
        //        CGFloat yMove=translation.y-self.pointLast.y;
        //        self.pointLast=translation;
        //
        //        CGPoint center=self.nowCell.center;
        //        self.nowCell.center=CGPointMake(center.x+xMove, center.y+yMove);
        //        CGFloat xTotalMove = translation.x - self.pointStart.x;
        //        if (xTotalMove < 0) {
        //            self.nowCell.transform = CGAffineTransformMakeRotation(degreeTOradians(90*xTotalMove/self.w));
        ////            self.nextCell.transform= CGAffineTransformMakeRotation(degreeTOradians(90*xTotalMove/self.w/2));
        //        } else {
        //            self.nowCell.transform = CGAffineTransformMakeRotation(degreeTOradians(0));
        //            self.nextCell.transform= CGAffineTransformMakeRotation(degreeTOradians(0));
        //        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.canSwipe = NO;
        //NSLog(@"end");
        CGFloat xTotalMove = translation.x - self.pointStart.x;
        if (xTotalMove < 0) {
            [self swipeEnd];
        } else {
            [self swipeGoBack];
        }
    }
    //    NSLog(@"%@%f%@%f",@"x:",speed.x,@"y:",speed.y);
    //NSLog(@"%@%f%@%f",@"x:",translation.x,@"y:",translation.y);
}

/**
 *  @author StoneMover, 16-12-29 14:12:33
 *
 *  @brief 获取为显示的cell,复用机制
 *
 *  @param identifier id标志
 *
 *  @return 返回的cell,如果缓存中没有则返回空
 */
- (UITableViewCell *)dequeueReusableUIViewWithIdentifier:(NSString *)identifier {
    for (UITableViewCell * cell in self.cacheViews) {
        if ([identifier isEqualToString:cell.reuseIdentifier]) {
            [self.cacheViews removeObject:cell];
            return cell;
        }
    }
    return nil;
}

//滑动到下一个界面
- (void)swipeEnd {
    if (self.totalNum < 2) {
        self.canSwipe = YES;
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.nextCell.transform = CGAffineTransformMakeRotation(degreeTOradians(0));
    }];
    
    //self.nowCell.transform= CGAffineTransformMakeRotation(degreeTOradians(0));
    CGPoint center = self.nowCell.center;
    [UIView animateWithDuration:0.2 animations:^{
        self.nowCell.center = CGPointMake(center.x - self.viewWidth, center.y);
        self.nowCell.transform = CGAffineTransformMakeRotation(degreeTOradians(0));
    } completion:^(BOOL finished) {
        self.nowIndex++;
        self.nowIndex = self.nowIndex < self.totalNum ? self.nowIndex : 0;
        if (self.viewRemove && [self isNeedAddToCache:self.viewRemove]) {
            [self.cacheViews addObject:self.viewRemove];
            [self.viewRemove removeFromSuperview];
        }
        
        if (self.totalNum < 3) {
            //1.1和2个cell的情况 交换顺序
            self.viewRemove = self.nowCell;
            self.nowCell = self.nextCell;
            
            NSInteger secondCellIndex = self.nowIndex + 1 < self.totalNum ? (int)self.nowIndex + 1 : (int)self.nowIndex + 1 - (int)self.totalNum;
            UITableViewCell * secondCell = [self getCellAtIndex:secondCellIndex];
            if (secondCell) {
                [secondCell removeFromSuperview];
                secondCell.layer.anchorPoint = CGPointMake(1, 1);
                secondCell.frame = CGRectMake(self.secondCellX, self.secondCellY, self.secondCellW, self.cellH);
                self.nextCell = secondCell;
                [self insertSubview:secondCell belowSubview:self.nowCell];
            }
            
        } else {
            //2.大于2个的情况 交换顺序
            self.viewRemove = self.nowCell;
            self.nowCell = self.nextCell;
            self.nextCell = self.thirdCell;
            NSInteger thirdCellIndex = self.nowIndex + 2 < self.totalNum ?(int)self.nowIndex + 2 : (int)self.nowIndex + 2 - (int)self.totalNum;
            UITableViewCell * thirdCell = [self getCellAtIndex:thirdCellIndex];
            if (thirdCell) {
                [thirdCell removeFromSuperview];
                thirdCell.layer.anchorPoint = CGPointMake(1, 1);
                thirdCell.frame = CGRectMake(self.thirdCellX, self.thirdCellY, self.thirdCellW, self.cellH);
                self.thirdCell = thirdCell;
                [self insertSubview:thirdCell belowSubview:self.nextCell];
            }
        }
        
        if (self.isStackCard) {
            [self.thirdCell setAlpha:0.3f];
            [self.nextCell setAlpha:0.5f];
            [self.nowCell setAlpha:1];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            self.nowCell.transform = CGAffineTransformMakeRotation(degreeTOradians(0));
            self.nowCell.frame = CGRectMake(self.firstCellX, self.firstCellY, self.cellW, self.cellH);
            self.nextCell.frame = CGRectMake(self.secondCellX, self.secondCellY, self.secondCellW, self.cellH);
            self.canSwipe = YES;
            //滑动代理回调
            if ([self.delegate respondsToSelector:@selector(swipeView:didSwipeToIndex:)]) {
                [self.delegate swipeView:self didSwipeToIndex:self.nowIndex];
            }
        }];
    }];
}

//滑动到上一个界面
- (void)swipeGoBack {
    if (!self.viewRemove) {
        self.canSwipe = YES;
        NSLog(@"!viewRemove");
        return;
    }
    if (self.nowIndex == 0) {
        self.canSwipe = YES;
        NSLog(@"!viewRemove+index");
        return;
    }
    
    self.nowIndex--;
    //1 1和2个cell的情况
    //2 3个和三个以上cell的情况
    if (self.totalNum < 3) {
        [self.nextCell removeFromSuperview];
        self.nextCell = self.nowCell;
        self.nowCell = self.viewRemove;
    } else {
        [self.thirdCell removeFromSuperview];
        self.thirdCell = self.nextCell;
        self.nextCell = self.nowCell;
        self.nowCell = self.viewRemove;
    }
    
    if (self.nowIndex == 0) {
        self.viewRemove = nil;
    } else {
        UITableViewCell * cell = [self getCellAtIndex:self.nowIndex-1];
        [cell removeFromSuperview];
        [self insertSubview:cell aboveSubview:self.nowCell];
        cell.layer.anchorPoint = CGPointMake(1, 1);
        cell.frame = self.viewRemove.frame;
        self.viewRemove = cell;
    }
    
    if (self.isStackCard) {
        [self.thirdCell setAlpha:0.3f];
        [self.nextCell setAlpha:0.5f];
        [self.nowCell setAlpha:1];
    }
    
    [UIView animateWithDuration:.3 animations:^{
        self.nowCell.frame = CGRectMake(self.firstCellX, self.firstCellY, self.cellW, self.cellH);
        self.nowCell.transform = CGAffineTransformMakeRotation(degreeTOradians(0));
        self.nextCell.frame = CGRectMake(self.secondCellX, self.secondCellY, self.secondCellW, self.cellH);
        if (self.thirdCell) {
            self.thirdCell.frame = CGRectMake(self.thirdCellX, self.thirdCellY, self.thirdCellW, self.cellH);
        }
        self.canSwipe = YES;
        //滑动代理回调
        if ([self.delegate respondsToSelector:@selector(swipeView:didSwipeToIndex:)]) {
            [self.delegate swipeView:self didSwipeToIndex:self.nowIndex];
        }
    }];
}

//是否需要加入到缓存中去
- (BOOL)isNeedAddToCache:(UITableViewCell*)cell {
    for (UITableViewCell * cellIn in self.cacheViews) {
        if ([cellIn.reuseIdentifier isEqualToString:cell.reuseIdentifier]) {
            return NO;
        }
    }
    return YES;
}


@end
