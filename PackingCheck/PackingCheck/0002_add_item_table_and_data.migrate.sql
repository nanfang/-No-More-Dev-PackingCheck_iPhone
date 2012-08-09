CREATE TABLE item(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE list_item(
    list_id INTEGER,
    item_id INTEGER,
    CONSTRAINT pk_list_item primary key (list_id,item_id)
);

INSERT INTO item(id, name) values (1, '钥匙');
INSERT INTO item(id, name) values (2, '现金');
INSERT INTO item(id, name) values (3, '信用卡');
INSERT INTO item(id, name) values (4, '手机');
INSERT INTO item(id, name) values (5, '钱包');
INSERT INTO item(id, name) values (6, '运动鞋');
INSERT INTO item(id, name) values (7, '篮球');
INSERT INTO item(id, name) values (8, '水');
INSERT INTO item(id, name) values (9, '帐篷');
INSERT INTO item(id, name) values (10, '睡袋');
INSERT INTO item(id, name) values (11, '防潮垫');
INSERT INTO item(id, name) values (12, '食品');
INSERT INTO item(id, name) values (13, '气罐');
INSERT INTO item(id, name) values (14, '炊具');
INSERT INTO item(id, name) values (15, '身份证');
INSERT INTO item(id, name) values (16, '机票');
INSERT INTO item(id, name) values (17, '护照');
INSERT INTO item(id, name) values (18, '红包');
INSERT INTO item(id, name) values (19, '登山鞋');
INSERT INTO item(id, name) values (20, '登山杖');
INSERT INTO item(id, name) values (21, '护膝');
INSERT INTO item(id, name) values (22, '指南针');
INSERT INTO item(id, name) values (23, '药品');
INSERT INTO item(id, name) values (24, '公交卡');
INSERT INTO item(id, name) values (25, '手台');
INSERT INTO item(id, name) values (26, '头灯');
INSERT INTO item(id, name) values (27, '足球');
INSERT INTO item(id, name) values (28, '足球鞋');
INSERT INTO item(id, name) values (29, '护踝');
INSERT INTO item(id, name) values (30, '球拍');
INSERT INTO item(id, name) values (31, '羽毛球');
INSERT INTO item(id, name) values (32, '购物袋');
INSERT INTO item(id, name) values (33, '泳衣');
INSERT INTO item(id, name) values (34, '泳镜');
INSERT INTO item(id, name) values (35, '防晒霜');
INSERT INTO item(id, name) values (36, '车锁');
INSERT INTO item(id, name) values (37, '鱼竿');
INSERT INTO item(id, name) values (38, '鱼饵');
INSERT INTO item(id, name) values (39, '鱼线');
INSERT INTO item(id, name) values (40, '鱼篓');
INSERT INTO item(id, name) values (41, '折叠板凳');

INSERT INTO list_item(list_id, item_id) values (1,1);
INSERT INTO list_item(list_id, item_id) values (1,2);
INSERT INTO list_item(list_id, item_id) values (1,4);
INSERT INTO list_item(list_id, item_id) values (1,8);
INSERT INTO list_item(list_id, item_id) values (1,12);
INSERT INTO list_item(list_id, item_id) values (1,19);
INSERT INTO list_item(list_id, item_id) values (1,20);
INSERT INTO list_item(list_id, item_id) values (1,21);
INSERT INTO list_item(list_id, item_id) values (1,22);
INSERT INTO list_item(list_id, item_id) values (1,25);
INSERT INTO list_item(list_id, item_id) values (1,26);

INSERT INTO list_item(list_id, item_id) values (2,1);
INSERT INTO list_item(list_id, item_id) values (2,2);
INSERT INTO list_item(list_id, item_id) values (2,4);
INSERT INTO list_item(list_id, item_id) values (2,8);
INSERT INTO list_item(list_id, item_id) values (2,9);
INSERT INTO list_item(list_id, item_id) values (2,10);
INSERT INTO list_item(list_id, item_id) values (2,11);
INSERT INTO list_item(list_id, item_id) values (2,12);
INSERT INTO list_item(list_id, item_id) values (2,13);
INSERT INTO list_item(list_id, item_id) values (2,14);
INSERT INTO list_item(list_id, item_id) values (2,22);
INSERT INTO list_item(list_id, item_id) values (2,23);
INSERT INTO list_item(list_id, item_id) values (2,25);

