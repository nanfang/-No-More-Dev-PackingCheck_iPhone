CREATE TABLE check_list(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    image_name TEXT NOT NULL,
    opens INTEGER NOT NULL DEFAULT 0
);
INSERT INTO check_list(id, name, image_name) values (1,'爬山', 'hiking.png');
INSERT INTO check_list(id, name, image_name) values (2,'野营', 'camping.png');
INSERT INTO check_list(id, name, image_name) values (3,'上班', 'go-work.png');
INSERT INTO check_list(id, name, image_name) values (4,'踢足球', 'football.png');
INSERT INTO check_list(id, name, image_name) values (5,'打篮球', 'basketball.png');
INSERT INTO check_list(id, name, image_name) values (6,'打羽毛球', 'batminton.png');
INSERT INTO check_list(id, name, image_name) values (7,'出差', 'business-trip.png');
INSERT INTO check_list(id, name, image_name) values (8,'逛超市', 'supermarket.png');
INSERT INTO check_list(id, name, image_name) values (9,'看病', 'hospital.png');
INSERT INTO check_list(id, name, image_name) values (10,'云南之旅', 'shopping.png');