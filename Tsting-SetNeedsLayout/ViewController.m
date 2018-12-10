//
//  ViewController.m
//  Tsting-SetNeedsLayout
//
//  Created by 隋老大 on 2018/12/6.
//  Copyright © 2018 dasui. All rights reserved.
//

#import "ViewController.h"
#import "Masonry/Masonry.h"
#import "TstingCustomView.h"

@interface ViewController ()
/** finishConversationView */
@property (nonatomic, strong) TstingCustomView *finishConversationView;
/** constriant */
//@property (nonatomic, strong) MASConstraint *mutableConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor lightGrayColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // button
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setTitle:@"Show" forState:UIControlStateNormal];
    [btn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn0.backgroundColor = [UIColor yellowColor];
    
    [btn0 addTarget:self action:@selector(actionShow) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn0];
    [btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 36));
    }];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"Hidden" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor yellowColor];
    
    [btn1 addTarget:self action:@selector(actionHidden) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn0.mas_bottom).offset(30);
        make.leading.equalTo(btn0);
        make.size.mas_equalTo(CGSizeMake(100, 36));
    }];
}

// FIXME: - test
- (void)addFinishView
{
    if (!_finishConversationView) {
        _finishConversationView = [[TstingCustomView alloc] initWithFrame:CGRectZero type:MarlServiceChatingFinishConversationViewTypeInputPhone];
    }
    
    [self.view addSubview:self.finishConversationView];
    // 藏于屏幕底部
    [self.finishConversationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom);
//        make.bottom.equalTo(self.view).offset(-34.f);
    }];
    
    NSLog(@"before layout's frame: %@", NSStringFromCGRect(self.finishConversationView.frame));
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    NSLog(@"after layout's frame: %@", NSStringFromCGRect(self.finishConversationView.frame));
    
    
    // 延迟唤起键盘, 不然通知不响应.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.05f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.finishConversationView.phoneTextField becomeFirstResponder];
    });
    // 复位到目标位置
    /** animation by layout */
//    [UIView animateWithDuration:0.25f animations:^{
//        [self.finishConversationView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view.mas_bottom).offset(-(CGRectGetHeight(self.finishConversationView.frame) + 34.f));
//        }];
//        [self.view layoutIfNeeded];
//    } completion:^(BOOL finished) {
//        if (finished) {
////            [self.finishConversationView.phoneTextField becomeFirstResponder];
//        }
//    }];
    
    __weak typeof(self)weakSelf = self;
    self.finishConversationView.positionYChangedHandler = ^(NSNotification *notify, BOOL isShowing) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGRect endFrame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        [UIView animateWithDuration:duration
                              delay:0.f
                            options:[notify.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]
                         animations:^{
                             [strongSelf.finishConversationView mas_updateConstraints:^(MASConstraintMaker *make) {
                                 if (isShowing) {
                                     make.top.equalTo(strongSelf.view.mas_bottom).offset(-(endFrame.size.height + CGRectGetHeight(strongSelf.finishConversationView.frame)));
                                 }else {
                                     make.top.equalTo(strongSelf.view.mas_bottom).offset(-(CGRectGetHeight(strongSelf.finishConversationView.frame) + 34.f));
                                 }
                             }];
//                             [strongSelf.view setNeedsLayout];
                             [strongSelf.view layoutIfNeeded];
                         }
                         completion:nil];
    };
}

// MARK: - handler
- (void)actionHidden
{
    [self.finishConversationView.phoneTextField endEditing:YES];
    
    [self.finishConversationView removeFromSuperview];
}

- (void)actionShow
{
    [self addFinishView];
}


@end
