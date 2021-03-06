//
//  LDDTableViewCell1.m
//  OCDemo_01
//
//  Created by 0dodo on 2018/9/7.
//  Copyright © 2018年 My. All rights reserved.
//

#import "LDDTableViewCell1.h"
#import <Masonry.h>

@interface LDDTableViewCell1()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIView  *bottomLine;

@end

@implementation LDDTableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setViews];
        [self setLayout];
    }
    return self;
}

- (void)setContent:(NSString *)content {
    self.contentLabel.text = content;
}

- (void)setViews {
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.imageView1];
//    [self.contentView addSubview:self.bottomLine];
}

- (void)setLayout {
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(10);
    }];
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(20);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
        make.bottom.equalTo(@-10); //最重要的一句代码
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Lazy load

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = [UIColor darkGrayColor];
    }
    return _bottomLine;
}

- (UIImageView *)imageView1 {
    if (!_imageView1) {
        _imageView1 = [UIImageView new];
        _imageView1.backgroundColor = [UIColor orangeColor];
    }
    return _imageView1;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textColor = [UIColor darkGrayColor];
        _contentLabel.backgroundColor = [UIColor yellowColor];
    }
    return _contentLabel;
}

@end
