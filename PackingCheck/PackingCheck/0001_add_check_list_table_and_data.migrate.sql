CREATE TABLE check_list(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    image_name TEXT NOT NULL,
    opens INTEGER NOT NULL DEFAULT 0
);
INSERT INTO check_list(id, name, image_name) values (1,'爬山', 'icon_hiking.png');
INSERT INTO check_list(id, name, image_name) values (2,'野营', 'icon_camping.png');
INSERT INTO check_list(id, name, image_name) values (3,'上班', 'icon_gotowork.png');
INSERT INTO check_list(id, name, image_name) values (4,'踢足球', 'icon_football.png');
INSERT INTO check_list(id, name, image_name) values (5,'打篮球', 'icon_basketball.png');
INSERT INTO check_list(id, name, image_name) values (6,'打羽毛球', 'icon_badminton.png');
INSERT INTO check_list(id, name, image_name) values (7,'出差', 'icon_trip.png');
INSERT INTO check_list(id, name, image_name) values (8,'购物', 'icon_goshopping.png');
INSERT INTO check_list(id, name, image_name) values (9,'去海边', 'icon_beach.png');
INSERT INTO check_list(id, name, image_name) values (10,'游泳', 'icon_swimming.png');
INSERT INTO check_list(id, name, image_name) values (11,'参加婚礼', 'icon_wedding.png');
INSERT INTO check_list(id, name, image_name) values (12,'骑自行车', 'icon_bike.png');
INSERT INTO check_list(id, name, image_name) values (13,'约会', 'icon_dating.png');
INSERT INTO check_list(id, name, image_name) values (14,'跑步', 'icon_jogging.png');
INSERT INTO check_list(id, name, image_name) values (15,'我的旅行', 'icon_default.png');
