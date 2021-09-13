CREATE TABLE `goods`  (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) ON UPDATE CURRENT_TIMESTAMP(-2147483648) COMMENT '修改时间',
  `is_del` int(11) NULL COMMENT '删除标识',
  `version` int(11) NULL DEFAULT 0 COMMENT '版本号',
  `name` varchar(255) NULL COMMENT '商品名称',
  `description` varchar(5000) NULL COMMENT '商品描述',
  `body` text NULL COMMENT '商品详情',
  `spec_id` varchar(32) NULL COMMENT '默认规格ID',
  `spec_name` varchar(255) NULL COMMENT '规格名称',
  `image_url` varchar(255) NULL COMMENT '产品图片封面',
  `image_url_more` varchar(5000) NULL COMMENT '产品图片多图',
  `price` decimal(8, 2) NULL COMMENT '产品单价',
  `article_number` varchar(255) NULL COMMENT '货号',
  `is_show` int(11) NULL DEFAULT 1 COMMENT '是否展示',
  `keywords` varchar(255) NULL COMMENT '关键字',
  PRIMARY KEY (`id`)
) COMMENT = '产品';

CREATE TABLE `goods_spec`  (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) ON UPDATE CURRENT_TIMESTAMP(-2147483648) COMMENT '修改时间',
  `is_del` int(11) NULL COMMENT '删除标识',
  `version` int(11) NULL DEFAULT 0 COMMENT '版本号',
  `goods_id` varchar(32) NULL COMMENT '产品ID',
  `spec_name` varchar(255) NULL COMMENT '规格名称',
  `spec_price` decimal(8, 2) NULL COMMENT '规格单价',
  `spec_stroage` int(11) NULL COMMENT '产品库存',
  `sales_num` int(11) NULL COMMENT '售出数量',
  `spec_image_url` varchar(255) NULL COMMENT '规格图片',
  PRIMARY KEY (`id`)
) COMMENT = '规格表';

CREATE TABLE `order`  (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) ON UPDATE CURRENT_TIMESTAMP(-2147483648) COMMENT '修改时间',
  `is_del` int(11) NULL COMMENT '删除标识',
  `version` int(11) NULL DEFAULT 0 COMMENT '版本号',
  `order_no` varchar(50) NULL COMMENT '订单号',
  `user_id` varchar(32) NULL COMMENT '用户ID',
  `user_name` varchar(255) NULL COMMENT '用户名',
  `user_address_id` varchar(32) NULL COMMENT '用户地址ID',
  `order_type` int(11) NULL DEFAULT 1 COMMENT '订单类型 ：1.普通订单  2.团购',
  `payment_id` varchar(32) NULL COMMENT '支付渠道ID',
  `payment_name` varchar(32) NULL COMMENT '支付渠道名称',
  `payment_code` varchar(32) NULL COMMENT '名称代码',
  `payment_branch` varchar(255) NULL COMMENT '支付分支(如网页，APP,小程序等)',
  `pay_status` int(11) NULL COMMENT '支付状态 1待支付 2已支付',
  `order_status` int(11) NULL COMMENT '订单状态：\r\n0:已取消\r\n10:待付款\r\n20:待发货\r\n30:待收货\r\n40:交易完成',
  `total_price` decimal(8, 2) NULL COMMENT '商品总价',
  `discount` decimal(8, 2) NULL COMMENT '优惠金额',
  `amount` decimal(8, 2) NULL COMMENT '实付金额',
  `out_trade_no` varchar(255) NULL COMMENT '第三方单号',
  `trade_sn` varchar(255) NULL COMMENT '交易流水号',
  `refund_state` int(2) NULL COMMENT '退款状态 0:无退款 1:部分退款 2：全部退款',
  `return_state` int(2) NULL COMMENT '退货状态 0:无退货 1.部分退货 2:全部退货',
  `refund_amount` decimal(8, 2) NULL COMMENT '退款金额',
  `return_num` int(11) NULL COMMENT '退货数量',
  PRIMARY KEY (`id`)
) COMMENT = '订单表';

CREATE TABLE `order_goods`  (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) ON UPDATE CURRENT_TIMESTAMP(-2147483648) COMMENT '修改时间',
  `is_del` int(11) NULL COMMENT '删除标识',
  `version` int(11) NULL DEFAULT 0 COMMENT '版本号',
  `order_id` varchar(32) NULL COMMENT '订单号',
  `goods_id` varchar(32) NULL COMMENT '商品ID',
  `goods_spec_id` varchar(32) NULL COMMENT '规格ID',
  `goods_name` varchar(255) NULL COMMENT '商品名称',
  `goods_spec_name` varchar(255) NULL COMMENT '规格名',
  `spec_num` int(11) NULL COMMENT '数量',
  `spec_price` decimal(8, 2) NULL COMMENT '规格单价',
  `spec_amount` decimal(8, 2) NULL COMMENT '规格总价',
  `return_num` int(11) NULL COMMENT '退货数量',
  `refund_amount` decimal(8, 2) NULL COMMENT '退款金额',
  PRIMARY KEY (`id`)
) COMMENT = '订单产品关系表';

CREATE TABLE `order_log`  (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `order_id` varchar NULL COMMENT '订单ID',
  `order_info` varchar(255) NULL COMMENT '订单状态信息',
  `next_order_info` varchar(255) NULL COMMENT '下一个订单状态信息',
  `info_desc` varchar(255) NULL COMMENT '状态描述',
  `operator` varchar(255) NULL COMMENT '操作人',
  PRIMARY KEY (`id`)
) COMMENT = '订单日志表';

CREATE TABLE `order_pay`  (
  `id` varchar(32) CHARACTER SET big5 NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) ON UPDATE CURRENT_TIMESTAMP(-2147483648) COMMENT '修改时间',
  `is_del` int(11) NULL COMMENT '删除标识',
  `version` int(11) NULL DEFAULT 0 COMMENT '版本号',
  `pay_sn` varchar(255) NULL COMMENT '支付单号',
  `user_id` varchar(32) NULL COMMENT '用户ID',
  `api_pay_state` int(2) NULL DEFAULT 0 COMMENT '0未支付 1已支付',
  PRIMARY KEY (`id`)
) COMMENT = '订单支付表';

CREATE TABLE `order_refund_return`  (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) ON UPDATE CURRENT_TIMESTAMP(-2147483648) COMMENT '修改时间',
  `is_del` int(11) NULL COMMENT '删除标识',
  `version` int(11) NULL DEFAULT 0 COMMENT '版本号',
  `order_id` varchar(32) NULL COMMENT '订单id',
  `order_sn` varchar(255) NULL COMMENT '订单号',
  `refund_sn` varchar(32) NULL COMMENT '退货退款单号',
  `user_id` varchar(32) NULL COMMENT '用户ID',
  `user_name` varchar(255) NULL COMMENT '用户名',
  `goods_id` varchar(32) NULL COMMENT '产品ID',
  `goods_image_url` varchar(255) NULL COMMENT '产品图片ID',
  `order_goods_id` varchar(32) NULL COMMENT '订单产品ID',
  `goods_name` varchar(255) NULL COMMENT '产品名称',
  `goods_num` int(11) NULL COMMENT '产品数量',
  `refund_amount` decimal(8, 2) NULL COMMENT '退款金额',
  `refund_type` int(11) NULL COMMENT '类型 1 退货退款 2 退款',
  PRIMARY KEY (`id`)
) COMMENT = '退款退货表';

CREATE TABLE `order_refund_return_log`  (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `refund_return_id` varchar NULL COMMENT '订单ID',
  `order_info` varchar(255) NULL COMMENT '订单状态信息',
  `next_order_info` varchar(255) NULL COMMENT '下一个订单状态信息',
  `info_desc` varchar(255) NULL COMMENT '状态描述',
  `operator` varchar(255) NULL COMMENT '操作人',
  PRIMARY KEY (`id`)
) COMMENT = '退款退货日志';

CREATE TABLE `payment`  (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) ON UPDATE CURRENT_TIMESTAMP(-2147483648) COMMENT '修改时间',
  `is_del` int(11) NULL COMMENT '删除标识',
  `version` int(11) NULL DEFAULT 0 COMMENT '版本号',
  `payment_name` varchar(255) NULL COMMENT '支付渠道名称',
  `payment_code` varchar(255) NULL COMMENT '编码',
  `payment_config` text NULL COMMENT '支付配置',
  `payment_status` int(2) NULL DEFAULT 1 COMMENT '状态  1 启用 2 禁用',
  PRIMARY KEY (`id`)
) COMMENT = '支付渠道表';

CREATE TABLE `shipping_area`  (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) ON UPDATE CURRENT_TIMESTAMP(-2147483648) COMMENT '修改时间',
  `is_del` int(11) NULL COMMENT '删除标识',
  `version` int(11) NULL DEFAULT 0 COMMENT '版本号',
  `province_name` varchar(255) NULL COMMENT '省',
  `city_name` varchar(255) NULL COMMENT '市',
  `region_name` varchar(255) NULL COMMENT '区',
  `province_adcode` varchar(32) NULL COMMENT '省编码',
  `city_adcode` varchar(32) NULL COMMENT '市编码',
  `adcode` varchar(32) NULL COMMENT '区编码',
  `level` int(1) NOT NULL COMMENT '区域等级 1.省 2.市  3.区',
  `lat_lng` varchar(255) NULL COMMENT '经纬度',
  PRIMARY KEY (`id`)
) COMMENT = '销售地区表';

CREATE TABLE `user`  (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) ON UPDATE CURRENT_TIMESTAMP(-2147483648) COMMENT '修改时间',
  `is_del` int(11) NULL COMMENT '删除标识',
  `version` int(11) NULL DEFAULT 0 COMMENT '版本号',
  `name` varchar(255) NULL COMMENT '用户名',
  `nick_name` varchar(255) NULL COMMENT '昵称',
  `mobile` int(11) NULL COMMENT '用户手机号',
  `status` int(2) NULL COMMENT '用户状态(1 正常 2冻结)',
  `head_url` varchar(255) NULL COMMENT '用户头像',
  `password` varchar(255) NULL COMMENT '登陆密码',
  `pay_password` varchar(255) NULL COMMENT '支付密码',
  `login_time` timestamp NULL COMMENT '登陆时间',
  `login_num` int(11) NULL COMMENT '登陆次数',
  `token` varchar(255) NULL COMMENT '用户登陆token',
  `refresh_token` varchar(255) NULL COMMENT 'token刷新',
  `invitor` varchar(32) NULL COMMENT '邀请人',
  `invite_code` varchar(11) NULL COMMENT '邀请码',
  `grade_id` vachar NULL COMMENT '等级ID',
  PRIMARY KEY (`id`)
) COMMENT = '用户表';

CREATE TABLE `user_address`  (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) ON UPDATE CURRENT_TIMESTAMP(-2147483648) COMMENT '修改时间',
  `is_del` int(11) NULL COMMENT '删除标识',
  `version` int(11) NULL DEFAULT 0 COMMENT '版本号',
  `user_id` varchar(32) NULL COMMENT '用户ID',
  `true_name` varchar(255) NULL COMMENT '姓名',
  `tel` varchar(50) NULL COMMENT '电话',
  `province_id` varchar(32) NULL COMMENT '省',
  `city_id` varchar(32) NULL COMMENT '市',
  `area_id` varchar(32) NULL COMMENT '区',
  `address` varchar(500) NOT NULL COMMENT '详细地址',
  `zip_code` varchar(255) NULL COMMENT '邮编',
  PRIMARY KEY (`id`)
) COMMENT = '用户地址表';

CREATE TABLE `user_grade`  (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP(-2147483648) ON UPDATE CURRENT_TIMESTAMP(-2147483648) COMMENT '修改时间',
  `is_del` int(11) NULL COMMENT '删除标识',
  `version` int(11) NULL DEFAULT 0 COMMENT '版本号',
  `name` varchar(255) NULL COMMENT '等级名称',
  `grade_image_url` varchar(255) NULL COMMENT '等级对应图片',
  `preferential` int(11) NULL COMMENT '优惠百分比',
  `is_default` int(11) NULL DEFAULT 0 COMMENT '是否默认',
  PRIMARY KEY (`id`)
) COMMENT = '用户等级表';

