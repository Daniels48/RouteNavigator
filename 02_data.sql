--
-- PostgreSQL database dump
--

\restrict VE4HoNJq5kCMUrNpMa6Ht7ygXdp7yASVM3eW3lIVGpv7bldHXUvnsuelTZwRQPY

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: example
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.alembic_version DISABLE TRIGGER ALL;

INSERT INTO public.alembic_version VALUES ('3a17464f1cf1');


ALTER TABLE public.alembic_version ENABLE TRIGGER ALL;

--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: example
--

ALTER TABLE public.schedules DISABLE TRIGGER ALL;

INSERT INTO public.schedules VALUES (1, 15, '08:00:00', '22:00:00');


ALTER TABLE public.schedules ENABLE TRIGGER ALL;

--
-- Data for Name: buses; Type: TABLE DATA; Schema: public; Owner: example
--

ALTER TABLE public.buses DISABLE TRIGGER ALL;

INSERT INTO public.buses VALUES (13, 'Маршрутка 3', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (11, 'Маршрутка 1', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (22, 'Маршрутка 11', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (23, 'Маршрутка 12', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (24, 'Автобус 12', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (1, 'Автобус 1', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (2, 'Автобус 2', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (3, 'Автобус 3', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (4, 'Автобус 4', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (5, 'Автобус 5', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (6, 'Автобус 6', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (7, 'Автобус 7', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (8, 'Автобус 8', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (9, 'Автобус 9', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (10, 'Автобус 10', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (21, 'Автобус 11', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (15, 'Маршрутка 5', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (16, 'Маршрутка 6', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (17, 'Маршрутка 7', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (18, 'Маршрутка 8', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (19, 'Маршрутка 9', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (20, 'Маршрутка 10', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (14, 'Маршрутка 4', 18, '00:00:30', 1, '00:15:00');
INSERT INTO public.buses VALUES (12, 'Маршрутка 2', 18, '00:00:30', 1, '00:15:00');


ALTER TABLE public.buses ENABLE TRIGGER ALL;

--
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: example
--

ALTER TABLE public.routes DISABLE TRIGGER ALL;

INSERT INTO public.routes VALUES (1, 'Маршрут 1', 'туда', 1);
INSERT INTO public.routes VALUES (2, 'Маршрут 1', 'туда', 2);
INSERT INTO public.routes VALUES (3, 'Маршрут 1', 'туда', 3);
INSERT INTO public.routes VALUES (4, 'Маршрут 1', 'туда', 4);
INSERT INTO public.routes VALUES (5, 'Маршрут 1', 'туда', 5);
INSERT INTO public.routes VALUES (6, 'Маршрут 1', 'туда', 6);
INSERT INTO public.routes VALUES (7, 'Маршрут 1', 'туда', 7);
INSERT INTO public.routes VALUES (8, 'Маршрут 1', 'туда', 8);
INSERT INTO public.routes VALUES (9, 'Маршрут 1', 'туда', 9);
INSERT INTO public.routes VALUES (10, 'Маршрут 1', 'туда', 10);
INSERT INTO public.routes VALUES (11, 'Маршрут 1', 'туда', 11);
INSERT INTO public.routes VALUES (12, 'Маршрут 1', 'туда', 12);
INSERT INTO public.routes VALUES (13, 'Маршрут 1', 'туда', 13);
INSERT INTO public.routes VALUES (14, 'Маршрут 1', 'туда', 14);
INSERT INTO public.routes VALUES (15, 'Маршрут 1', 'туда', 15);
INSERT INTO public.routes VALUES (16, 'Маршрут 1', 'туда', 16);
INSERT INTO public.routes VALUES (17, 'Маршрут 1', 'туда', 17);
INSERT INTO public.routes VALUES (18, 'Маршрут 1', 'туда', 18);
INSERT INTO public.routes VALUES (19, 'Маршрут 1', 'туда', 19);
INSERT INTO public.routes VALUES (20, 'Маршрут 1', 'туда', 20);
INSERT INTO public.routes VALUES (21, 'Маршрут 1', 'туда', 21);
INSERT INTO public.routes VALUES (22, 'Маршрут 1', 'туда', 22);
INSERT INTO public.routes VALUES (23, 'Маршрут 1', 'туда', 23);
INSERT INTO public.routes VALUES (24, 'Маршрут 1', 'туда', 24);


ALTER TABLE public.routes ENABLE TRIGGER ALL;

--
-- Data for Name: stops; Type: TABLE DATA; Schema: public; Owner: example
--

ALTER TABLE public.stops DISABLE TRIGGER ALL;

INSERT INTO public.stops VALUES (1, 'Памятник Славы', 51.702555, 39.180025);
INSERT INTO public.stops VALUES (2, 'Бульвар Победы', 51.709728, 39.180581);
INSERT INTO public.stops VALUES (3, 'ТРЦ Московский проспект', 51.716778, 39.179725);
INSERT INTO public.stops VALUES (4, 'Военный Городок', 51.723073, 39.178967);
INSERT INTO public.stops VALUES (5, 'Торговое училище', 51.727909, 39.179033);
INSERT INTO public.stops VALUES (6, 'Гостиница Спутник', 51.73128, 39.179547);
INSERT INTO public.stops VALUES (7, 'Областная больница', 51.739793, 39.18246);
INSERT INTO public.stops VALUES (8, 'Олимпик', 51.755059, 39.187751);
INSERT INTO public.stops VALUES (9, 'х. Ветряк', 51.772689, 39.193756);
INSERT INTO public.stops VALUES (10, 'ТРК Сити-парк Град', 51.787398, 39.198927);
INSERT INTO public.stops VALUES (11, 'Хользунова', 51.702409, 39.176625);
INSERT INTO public.stops VALUES (12, 'Беспаловой', 51.702042, 39.168066);
INSERT INTO public.stops VALUES (13, '60 Армии', 51.701767, 39.161635);
INSERT INTO public.stops VALUES (14, 'Подгоренская', 51.701474, 39.154823);
INSERT INTO public.stops VALUES (15, 'Новгородская', 51.700966, 39.149024);
INSERT INTO public.stops VALUES (16, 'Генерала Лизюкова', 51.706647, 39.173343);
INSERT INTO public.stops VALUES (17, 'Школа', 51.706365, 39.168635);
INSERT INTO public.stops VALUES (18, 'Парк Победы', 51.708317, 39.162923);
INSERT INTO public.stops VALUES (19, '60 лет ВЛКСМ', 51.711984, 39.157226);
INSERT INTO public.stops VALUES (20, '17-й квартал', 51.71229, 39.16802);
INSERT INTO public.stops VALUES (21, 'Жукова', 51.712818, 39.172483);
INSERT INTO public.stops VALUES (22, '45 Стрелковой Дивизии', 51.696427, 39.182534);
INSERT INTO public.stops VALUES (23, 'Центральный автовокзал', 51.692762, 39.18298);
INSERT INTO public.stops VALUES (24, 'Рабочий проспект', 51.689114, 39.183741);
INSERT INTO public.stops VALUES (25, 'Политехнический институт', 51.685139, 39.183909);
INSERT INTO public.stops VALUES (26, 'Проспект Труда', 51.680188, 39.184512);
INSERT INTO public.stops VALUES (27, 'пл. Застава', 51.673152, 39.185899);
INSERT INTO public.stops VALUES (28, 'Кольцовская', 51.669151, 39.190793);
INSERT INTO public.stops VALUES (29, 'Никитинская', 51.66602, 39.194623);
INSERT INTO public.stops VALUES (30, 'Гостиница Брно', 51.662987, 39.198333);
INSERT INTO public.stops VALUES (31, 'ТЮЗ', 51.659495, 39.202858);
INSERT INTO public.stops VALUES (32, 'ВГУ', 51.65754, 39.205128);
INSERT INTO public.stops VALUES (33, 'Куцыгина', 51.658909, 39.1944);
INSERT INTO public.stops VALUES (34, 'Кирова', 51.656306, 39.188274);
INSERT INTO public.stops VALUES (35, 'Ворошилова', 51.657301, 39.184184);
INSERT INTO public.stops VALUES (36, 'Бахметьева (ул. Ворошилова)', 51.65498, 39.177344);
INSERT INTO public.stops VALUES (37, 'Механический завод', 51.652671, 39.171058);
INSERT INTO public.stops VALUES (38, 'Космонавтов', 51.651529, 39.162897);
INSERT INTO public.stops VALUES (39, 'Техникум', 51.654426, 39.159944);
INSERT INTO public.stops VALUES (40, 'Пирогова', 51.657267, 39.156876);
INSERT INTO public.stops VALUES (41, 'Керамический завод', 51.660137, 39.15412);
INSERT INTO public.stops VALUES (42, 'Дорожная', 51.664265, 39.150303);
INSERT INTO public.stops VALUES (43, 'Машиностроителей', 51.671953, 39.154248);
INSERT INTO public.stops VALUES (44, 'Торпедо', 51.673658, 39.149815);
INSERT INTO public.stops VALUES (45, 'Газовая', 51.676144, 39.141058);
INSERT INTO public.stops VALUES (46, 'Жемчужная', 51.678829, 39.133809);
INSERT INTO public.stops VALUES (47, 'Аптека', 51.671005, 39.16194);
INSERT INTO public.stops VALUES (48, 'Красных Зорь', 51.672644, 39.164587);
INSERT INTO public.stops VALUES (49, 'Станкостроительный завод', 51.67658, 39.170942);
INSERT INTO public.stops VALUES (50, 'Текстильщиков', 51.678736, 39.174423);
INSERT INTO public.stops VALUES (51, 'Электроагрегат', 51.681402, 39.165952);
INSERT INTO public.stops VALUES (52, 'Электросигнальная', 51.687076, 39.165277);
INSERT INTO public.stops VALUES (53, 'Солнечная', 51.69728, 39.163139);
INSERT INTO public.stops VALUES (54, 'ЖК Острова', 51.703058, 39.189418);
INSERT INTO public.stops VALUES (56, 'Хользунова2', 51.703274, 39.194664);
INSERT INTO public.stops VALUES (57, 'Ботанический сад', 51.711522, 39.194842);
INSERT INTO public.stops VALUES (58, 'Микрорайон Дубрава', 51.713355, 39.190476);
INSERT INTO public.stops VALUES (59, 'Школа №106', 51.713358, 39.199137);
INSERT INTO public.stops VALUES (60, 'Лобачевского', 51.704355, 39.229202);
INSERT INTO public.stops VALUES (61, 'Берёзовая Роща', 51.699812, 39.232402);
INSERT INTO public.stops VALUES (62, 'Центральный парк', 51.691079, 39.224844);
INSERT INTO public.stops VALUES (63, 'Воронежский педагогический университет', 51.687099, 39.217955);
INSERT INTO public.stops VALUES (64, 'Фабрика Работница', 51.683375, 39.215908);
INSERT INTO public.stops VALUES (65, 'Урицкого', 51.682635, 39.206132);
INSERT INTO public.stops VALUES (66, 'Стоматологическая поликлиника №6', 51.684071, 39.196421);
INSERT INTO public.stops VALUES (67, 'Карпинского', 51.682843, 39.190451);
INSERT INTO public.stops VALUES (68, 'Ж/д поликлиника', 51.68106, 39.215602);
INSERT INTO public.stops VALUES (69, 'Коммунаров', 51.678586, 39.213951);
INSERT INTO public.stops VALUES (70, 'Ж/д вокзал Воронеж-1', 51.67871, 39.205362);
INSERT INTO public.stops VALUES (71, 'Комиссаржевской', 51.673286, 39.199986);
INSERT INTO public.stops VALUES (72, 'Кольцовский Сквер', 51.662093, 39.201263);
INSERT INTO public.stops VALUES (73, 'Театр кукол', 51.666062, 39.205576);
INSERT INTO public.stops VALUES (74, 'Петровский Сквер', 51.674045, 39.210903);
INSERT INTO public.stops VALUES (75, 'Манежная', 51.673911, 39.216082);
INSERT INTO public.stops VALUES (76, 'Чернавский Мост', 51.668618, 39.220413);
INSERT INTO public.stops VALUES (77, 'Ильича', 51.664922, 39.246774);
INSERT INTO public.stops VALUES (78, 'Усманский пер.', 51.665485, 39.268022);
INSERT INTO public.stops VALUES (79, 'Базовая', 51.657198, 39.286093);
INSERT INTO public.stops VALUES (80, 'Остужева', 51.686016, 39.262208);
INSERT INTO public.stops VALUES (81, 'ТЦ Метро (по требованию)', 51.680056, 39.285216);
INSERT INTO public.stops VALUES (82, 'Стадион Динамо', 51.692121, 39.225318);
INSERT INTO public.stops VALUES (83, 'Леваневского', 51.692246, 39.207998);
INSERT INTO public.stops VALUES (84, 'Железнодорожная больница', 51.693241, 39.203342);
INSERT INTO public.stops VALUES (85, 'Областная детская больница №2', 51.69535, 39.198196);
INSERT INTO public.stops VALUES (86, 'Песчаный Лог', 51.638097, 39.165801);
INSERT INTO public.stops VALUES (87, 'Кривошеина', 51.644333, 39.154193);
INSERT INTO public.stops VALUES (88, 'Героев Сибиряков', 51.644383, 39.146779);
INSERT INTO public.stops VALUES (89, 'Грамши', 51.634969, 39.188979);
INSERT INTO public.stops VALUES (90, 'Краснознамённая', 51.636773, 39.172793);
INSERT INTO public.stops VALUES (91, 'Маршала Неделина', 51.639977, 39.175833);
INSERT INTO public.stops VALUES (92, 'Колесниченко', 51.642292, 39.178235);
INSERT INTO public.stops VALUES (93, 'Чапаева', 51.646146, 39.183333);
INSERT INTO public.stops VALUES (94, '5 Декабря', 51.649867, 39.185819);


ALTER TABLE public.stops ENABLE TRIGGER ALL;

--
-- Data for Name: bus_routes; Type: TABLE DATA; Schema: public; Owner: example
--

ALTER TABLE public.bus_routes DISABLE TRIGGER ALL;

INSERT INTO public.bus_routes VALUES (491, 81, 1, 19, 0);
INSERT INTO public.bus_routes VALUES (23, 10, 1, 2, 0);
INSERT INTO public.bus_routes VALUES (40, 79, 1, 3, 0);
INSERT INTO public.bus_routes VALUES (63, 46, 1, 4, 0);
INSERT INTO public.bus_routes VALUES (85, 15, 1, 5, 0);
INSERT INTO public.bus_routes VALUES (113, 88, 1, 6, 0);
INSERT INTO public.bus_routes VALUES (130, 19, 1, 7, 0);
INSERT INTO public.bus_routes VALUES (265, 46, 1, 12, 0);
INSERT INTO public.bus_routes VALUES (291, 19, 1, 13, 0);
INSERT INTO public.bus_routes VALUES (195, 88, 1, 9, 0);
INSERT INTO public.bus_routes VALUES (221, 19, 1, 10, 0);
INSERT INTO public.bus_routes VALUES (232, 81, 1, 11, 0);
INSERT INTO public.bus_routes VALUES (330, 81, 1, 14, 0);
INSERT INTO public.bus_routes VALUES (368, 88, 1, 15, 0);
INSERT INTO public.bus_routes VALUES (2, 9, 2, 1, 365);
INSERT INTO public.bus_routes VALUES (3, 8, 3, 1, 430);
INSERT INTO public.bus_routes VALUES (4, 7, 4, 1, 377);
INSERT INTO public.bus_routes VALUES (5, 6, 5, 1, 223);
INSERT INTO public.bus_routes VALUES (6, 5, 6, 1, 105);
INSERT INTO public.bus_routes VALUES (7, 4, 7, 1, 137);
INSERT INTO public.bus_routes VALUES (8, 3, 8, 1, 170);
INSERT INTO public.bus_routes VALUES (9, 2, 9, 1, 187);
INSERT INTO public.bus_routes VALUES (10, 1, 10, 1, 189);
INSERT INTO public.bus_routes VALUES (11, 22, 11, 1, 170);
INSERT INTO public.bus_routes VALUES (12, 23, 12, 1, 111);
INSERT INTO public.bus_routes VALUES (13, 24, 13, 1, 111);
INSERT INTO public.bus_routes VALUES (14, 25, 14, 1, 118);
INSERT INTO public.bus_routes VALUES (15, 26, 15, 1, 140);
INSERT INTO public.bus_routes VALUES (16, 27, 16, 1, 187);
INSERT INTO public.bus_routes VALUES (17, 28, 17, 1, 141);
INSERT INTO public.bus_routes VALUES (18, 35, 18, 1, 309);
INSERT INTO public.bus_routes VALUES (19, 36, 19, 1, 137);
INSERT INTO public.bus_routes VALUES (20, 37, 20, 1, 131);
INSERT INTO public.bus_routes VALUES (21, 87, 21, 1, 328);
INSERT INTO public.bus_routes VALUES (22, 88, 22, 1, 132);
INSERT INTO public.bus_routes VALUES (24, 9, 2, 2, 365);
INSERT INTO public.bus_routes VALUES (25, 8, 3, 2, 430);
INSERT INTO public.bus_routes VALUES (26, 7, 4, 2, 377);
INSERT INTO public.bus_routes VALUES (27, 6, 5, 2, 223);
INSERT INTO public.bus_routes VALUES (28, 5, 6, 2, 105);
INSERT INTO public.bus_routes VALUES (29, 4, 7, 2, 137);
INSERT INTO public.bus_routes VALUES (30, 3, 8, 2, 170);
INSERT INTO public.bus_routes VALUES (31, 2, 9, 2, 187);
INSERT INTO public.bus_routes VALUES (32, 58, 10, 2, 188);
INSERT INTO public.bus_routes VALUES (33, 57, 11, 2, 102);
INSERT INTO public.bus_routes VALUES (56, 86, 17, 3, 131);
INSERT INTO public.bus_routes VALUES (57, 87, 18, 3, 242);
INSERT INTO public.bus_routes VALUES (58, 38, 19, 3, 230);
INSERT INTO public.bus_routes VALUES (59, 39, 20, 3, 106);
INSERT INTO public.bus_routes VALUES (60, 40, 21, 3, 106);
INSERT INTO public.bus_routes VALUES (61, 41, 22, 3, 104);
INSERT INTO public.bus_routes VALUES (62, 42, 23, 3, 135);
INSERT INTO public.bus_routes VALUES (64, 45, 2, 4, 146);
INSERT INTO public.bus_routes VALUES (65, 44, 3, 4, 163);
INSERT INTO public.bus_routes VALUES (66, 43, 4, 4, 102);
INSERT INTO public.bus_routes VALUES (67, 47, 5, 4, 138);
INSERT INTO public.bus_routes VALUES (68, 48, 6, 4, 81);
INSERT INTO public.bus_routes VALUES (69, 49, 7, 4, 154);
INSERT INTO public.bus_routes VALUES (70, 51, 8, 4, 157);
INSERT INTO public.bus_routes VALUES (71, 52, 9, 4, 156);
INSERT INTO public.bus_routes VALUES (72, 53, 10, 4, 258);
INSERT INTO public.bus_routes VALUES (73, 13, 11, 4, 131);
INSERT INTO public.bus_routes VALUES (74, 18, 12, 4, 176);
INSERT INTO public.bus_routes VALUES (75, 19, 13, 4, 143);
INSERT INTO public.bus_routes VALUES (76, 20, 14, 4, 179);
INSERT INTO public.bus_routes VALUES (77, 21, 15, 4, 92);
INSERT INTO public.bus_routes VALUES (78, 58, 16, 4, 279);
INSERT INTO public.bus_routes VALUES (79, 57, 17, 4, 102);
INSERT INTO public.bus_routes VALUES (80, 59, 18, 4, 102);
INSERT INTO public.bus_routes VALUES (81, 60, 19, 4, 491);
INSERT INTO public.bus_routes VALUES (82, 61, 20, 4, 140);
INSERT INTO public.bus_routes VALUES (83, 80, 21, 4, 543);
INSERT INTO public.bus_routes VALUES (84, 81, 22, 4, 374);
INSERT INTO public.bus_routes VALUES (86, 14, 2, 5, 110);
INSERT INTO public.bus_routes VALUES (87, 13, 3, 5, 124);
INSERT INTO public.bus_routes VALUES (88, 12, 4, 5, 119);
INSERT INTO public.bus_routes VALUES (89, 11, 5, 5, 148);
INSERT INTO public.bus_routes VALUES (90, 1, 6, 5, 77);
INSERT INTO public.bus_routes VALUES (91, 22, 7, 5, 170);
INSERT INTO public.bus_routes VALUES (92, 23, 8, 5, 111);
INSERT INTO public.bus_routes VALUES (93, 24, 9, 5, 111);
INSERT INTO public.bus_routes VALUES (94, 25, 10, 5, 118);
INSERT INTO public.bus_routes VALUES (95, 26, 11, 5, 140);
INSERT INTO public.bus_routes VALUES (96, 67, 12, 5, 131);
INSERT INTO public.bus_routes VALUES (97, 66, 13, 5, 116);
INSERT INTO public.bus_routes VALUES (98, 65, 14, 5, 168);
INSERT INTO public.bus_routes VALUES (99, 64, 15, 5, 166);
INSERT INTO public.bus_routes VALUES (100, 68, 16, 5, 81);
INSERT INTO public.bus_routes VALUES (101, 69, 17, 5, 89);
INSERT INTO public.bus_routes VALUES (102, 70, 18, 5, 148);
INSERT INTO public.bus_routes VALUES (103, 71, 19, 5, 171);
INSERT INTO public.bus_routes VALUES (104, 28, 20, 5, 186);
INSERT INTO public.bus_routes VALUES (105, 35, 21, 5, 309);
INSERT INTO public.bus_routes VALUES (106, 36, 22, 5, 137);
INSERT INTO public.bus_routes VALUES (107, 37, 23, 5, 131);
INSERT INTO public.bus_routes VALUES (108, 38, 24, 5, 145);
INSERT INTO public.bus_routes VALUES (109, 39, 25, 5, 106);
INSERT INTO public.bus_routes VALUES (110, 40, 26, 5, 106);
INSERT INTO public.bus_routes VALUES (111, 41, 27, 5, 104);
INSERT INTO public.bus_routes VALUES (112, 42, 28, 5, 135);
INSERT INTO public.bus_routes VALUES (114, 87, 2, 6, 132);
INSERT INTO public.bus_routes VALUES (115, 86, 3, 6, 242);
INSERT INTO public.bus_routes VALUES (116, 90, 4, 6, 131);
INSERT INTO public.bus_routes VALUES (117, 89, 5, 6, 257);
INSERT INTO public.bus_routes VALUES (118, 93, 6, 6, 290);
INSERT INTO public.bus_routes VALUES (119, 94, 7, 6, 119);
INSERT INTO public.bus_routes VALUES (1, 10, 1, 1, 0);
INSERT INTO public.bus_routes VALUES (394, 79, 1, 16, 0);
INSERT INTO public.bus_routes VALUES (426, 15, 1, 17, 0);
INSERT INTO public.bus_routes VALUES (474, 32, 1, 18, 0);
INSERT INTO public.bus_routes VALUES (120, 34, 8, 6, 177);
INSERT INTO public.bus_routes VALUES (121, 33, 9, 6, 132);
INSERT INTO public.bus_routes VALUES (168, 88, 1, 8, 0);
INSERT INTO public.bus_routes VALUES (122, 72, 10, 6, 148);
INSERT INTO public.bus_routes VALUES (123, 73, 11, 6, 136);
INSERT INTO public.bus_routes VALUES (124, 74, 12, 6, 222);
INSERT INTO public.bus_routes VALUES (125, 75, 13, 6, 101);
INSERT INTO public.bus_routes VALUES (126, 76, 14, 6, 162);
INSERT INTO public.bus_routes VALUES (127, 77, 15, 6, 403);
INSERT INTO public.bus_routes VALUES (128, 78, 16, 6, 324);
INSERT INTO public.bus_routes VALUES (129, 79, 17, 6, 340);
INSERT INTO public.bus_routes VALUES (131, 20, 2, 7, 179);
INSERT INTO public.bus_routes VALUES (132, 21, 3, 7, 92);
INSERT INTO public.bus_routes VALUES (133, 2, 4, 7, 161);
INSERT INTO public.bus_routes VALUES (134, 1, 5, 7, 189);
INSERT INTO public.bus_routes VALUES (135, 54, 6, 7, 160);
INSERT INTO public.bus_routes VALUES (136, 56, 7, 7, 102);
INSERT INTO public.bus_routes VALUES (137, 85, 8, 7, 212);
INSERT INTO public.bus_routes VALUES (138, 23, 9, 7, 248);
INSERT INTO public.bus_routes VALUES (139, 24, 10, 7, 111);
INSERT INTO public.bus_routes VALUES (140, 25, 11, 7, 118);
INSERT INTO public.bus_routes VALUES (141, 26, 12, 7, 140);
INSERT INTO public.bus_routes VALUES (142, 50, 13, 7, 173);
INSERT INTO public.bus_routes VALUES (143, 49, 14, 7, 97);
INSERT INTO public.bus_routes VALUES (144, 48, 15, 7, 154);
INSERT INTO public.bus_routes VALUES (145, 47, 16, 7, 81);
INSERT INTO public.bus_routes VALUES (146, 43, 17, 7, 138);
INSERT INTO public.bus_routes VALUES (147, 42, 18, 7, 209);
INSERT INTO public.bus_routes VALUES (148, 41, 19, 7, 135);
INSERT INTO public.bus_routes VALUES (149, 40, 20, 7, 104);
INSERT INTO public.bus_routes VALUES (150, 39, 21, 7, 106);
INSERT INTO public.bus_routes VALUES (151, 38, 22, 7, 106);
INSERT INTO public.bus_routes VALUES (152, 37, 23, 7, 145);
INSERT INTO public.bus_routes VALUES (153, 36, 24, 7, 131);
INSERT INTO public.bus_routes VALUES (154, 35, 25, 7, 137);
INSERT INTO public.bus_routes VALUES (155, 34, 26, 7, 90);
INSERT INTO public.bus_routes VALUES (156, 33, 27, 7, 132);
INSERT INTO public.bus_routes VALUES (157, 72, 28, 7, 148);
INSERT INTO public.bus_routes VALUES (158, 73, 29, 7, 136);
INSERT INTO public.bus_routes VALUES (159, 74, 30, 7, 222);
INSERT INTO public.bus_routes VALUES (160, 69, 31, 7, 139);
INSERT INTO public.bus_routes VALUES (161, 68, 32, 7, 89);
INSERT INTO public.bus_routes VALUES (162, 64, 33, 7, 81);
INSERT INTO public.bus_routes VALUES (163, 63, 34, 7, 117);
INSERT INTO public.bus_routes VALUES (164, 62, 35, 7, 160);
INSERT INTO public.bus_routes VALUES (165, 82, 36, 7, 54);
INSERT INTO public.bus_routes VALUES (166, 61, 37, 7, 227);
INSERT INTO public.bus_routes VALUES (167, 60, 38, 7, 140);
INSERT INTO public.bus_routes VALUES (169, 87, 2, 8, 132);
INSERT INTO public.bus_routes VALUES (170, 38, 3, 8, 230);
INSERT INTO public.bus_routes VALUES (171, 37, 4, 8, 145);
INSERT INTO public.bus_routes VALUES (172, 36, 5, 8, 131);
INSERT INTO public.bus_routes VALUES (173, 35, 6, 8, 137);
INSERT INTO public.bus_routes VALUES (174, 34, 7, 8, 90);
INSERT INTO public.bus_routes VALUES (175, 33, 8, 8, 132);
INSERT INTO public.bus_routes VALUES (176, 32, 9, 8, 181);
INSERT INTO public.bus_routes VALUES (177, 31, 10, 8, 83);
INSERT INTO public.bus_routes VALUES (178, 30, 11, 8, 129);
INSERT INTO public.bus_routes VALUES (179, 29, 12, 8, 114);
INSERT INTO public.bus_routes VALUES (180, 28, 13, 8, 117);
INSERT INTO public.bus_routes VALUES (181, 27, 14, 8, 141);
INSERT INTO public.bus_routes VALUES (182, 26, 15, 8, 187);
INSERT INTO public.bus_routes VALUES (183, 25, 16, 8, 140);
INSERT INTO public.bus_routes VALUES (184, 24, 17, 8, 118);
INSERT INTO public.bus_routes VALUES (185, 23, 18, 8, 111);
INSERT INTO public.bus_routes VALUES (186, 22, 19, 8, 111);
INSERT INTO public.bus_routes VALUES (187, 1, 20, 8, 170);
INSERT INTO public.bus_routes VALUES (196, 87, 2, 9, 132);
INSERT INTO public.bus_routes VALUES (197, 86, 3, 9, 242);
INSERT INTO public.bus_routes VALUES (198, 90, 4, 9, 131);
INSERT INTO public.bus_routes VALUES (199, 89, 5, 9, 257);
INSERT INTO public.bus_routes VALUES (200, 93, 6, 9, 290);
INSERT INTO public.bus_routes VALUES (201, 94, 7, 9, 119);
INSERT INTO public.bus_routes VALUES (233, 80, 2, 11, 374);
INSERT INTO public.bus_routes VALUES (234, 61, 3, 11, 543);
INSERT INTO public.bus_routes VALUES (235, 60, 4, 11, 140);
INSERT INTO public.bus_routes VALUES (236, 59, 5, 11, 491);
INSERT INTO public.bus_routes VALUES (237, 57, 6, 11, 102);
INSERT INTO public.bus_routes VALUES (238, 56, 7, 11, 213);
INSERT INTO public.bus_routes VALUES (239, 54, 8, 11, 102);
INSERT INTO public.bus_routes VALUES (240, 1, 9, 11, 160);
INSERT INTO public.bus_routes VALUES (241, 22, 10, 11, 170);
INSERT INTO public.bus_routes VALUES (242, 23, 11, 11, 111);
INSERT INTO public.bus_routes VALUES (243, 24, 12, 11, 111);
INSERT INTO public.bus_routes VALUES (244, 25, 13, 11, 118);
INSERT INTO public.bus_routes VALUES (245, 26, 14, 11, 140);
INSERT INTO public.bus_routes VALUES (246, 67, 15, 11, 131);
INSERT INTO public.bus_routes VALUES (247, 66, 16, 11, 116);
INSERT INTO public.bus_routes VALUES (248, 65, 17, 11, 168);
INSERT INTO public.bus_routes VALUES (249, 64, 18, 11, 166);
INSERT INTO public.bus_routes VALUES (250, 68, 19, 11, 81);
INSERT INTO public.bus_routes VALUES (251, 69, 20, 11, 89);
INSERT INTO public.bus_routes VALUES (252, 70, 21, 11, 148);
INSERT INTO public.bus_routes VALUES (253, 71, 22, 11, 171);
INSERT INTO public.bus_routes VALUES (254, 28, 23, 11, 186);
INSERT INTO public.bus_routes VALUES (255, 29, 24, 11, 117);
INSERT INTO public.bus_routes VALUES (256, 30, 25, 11, 114);
INSERT INTO public.bus_routes VALUES (257, 72, 26, 11, 75);
INSERT INTO public.bus_routes VALUES (258, 73, 27, 11, 136);
INSERT INTO public.bus_routes VALUES (259, 74, 28, 11, 222);
INSERT INTO public.bus_routes VALUES (260, 75, 29, 11, 101);
INSERT INTO public.bus_routes VALUES (261, 76, 30, 11, 162);
INSERT INTO public.bus_routes VALUES (262, 77, 31, 11, 403);
INSERT INTO public.bus_routes VALUES (263, 78, 32, 11, 324);
INSERT INTO public.bus_routes VALUES (264, 79, 33, 11, 340);
INSERT INTO public.bus_routes VALUES (266, 45, 2, 12, 146);
INSERT INTO public.bus_routes VALUES (267, 44, 3, 12, 163);
INSERT INTO public.bus_routes VALUES (268, 43, 4, 12, 102);
INSERT INTO public.bus_routes VALUES (269, 47, 5, 12, 138);
INSERT INTO public.bus_routes VALUES (270, 48, 6, 12, 81);
INSERT INTO public.bus_routes VALUES (271, 49, 7, 12, 154);
INSERT INTO public.bus_routes VALUES (272, 50, 8, 12, 97);
INSERT INTO public.bus_routes VALUES (273, 26, 9, 12, 173);
INSERT INTO public.bus_routes VALUES (274, 25, 10, 12, 140);
INSERT INTO public.bus_routes VALUES (275, 24, 11, 12, 118);
INSERT INTO public.bus_routes VALUES (276, 23, 12, 12, 111);
INSERT INTO public.bus_routes VALUES (524, 19, 1, 20, 0);
INSERT INTO public.bus_routes VALUES (277, 85, 13, 12, 248);
INSERT INTO public.bus_routes VALUES (278, 84, 14, 12, 115);
INSERT INTO public.bus_routes VALUES (279, 83, 15, 12, 98);
INSERT INTO public.bus_routes VALUES (280, 61, 16, 12, 407);
INSERT INTO public.bus_routes VALUES (281, 60, 17, 12, 140);
INSERT INTO public.bus_routes VALUES (282, 59, 18, 12, 491);
INSERT INTO public.bus_routes VALUES (283, 57, 19, 12, 102);
INSERT INTO public.bus_routes VALUES (284, 58, 20, 12, 102);
INSERT INTO public.bus_routes VALUES (285, 21, 21, 12, 279);
INSERT INTO public.bus_routes VALUES (286, 20, 22, 12, 92);
INSERT INTO public.bus_routes VALUES (287, 18, 23, 12, 143);
INSERT INTO public.bus_routes VALUES (288, 13, 24, 12, 176);
INSERT INTO public.bus_routes VALUES (289, 14, 25, 12, 124);
INSERT INTO public.bus_routes VALUES (290, 15, 26, 12, 110);
INSERT INTO public.bus_routes VALUES (292, 18, 2, 13, 143);
INSERT INTO public.bus_routes VALUES (293, 13, 3, 13, 176);
INSERT INTO public.bus_routes VALUES (545, 19, 1, 21, 0);
INSERT INTO public.bus_routes VALUES (567, 51, 1, 22, 0);
INSERT INTO public.bus_routes VALUES (34, 56, 12, 2, 213);
INSERT INTO public.bus_routes VALUES (35, 85, 13, 2, 212);
INSERT INTO public.bus_routes VALUES (36, 84, 14, 2, 115);
INSERT INTO public.bus_routes VALUES (37, 83, 15, 2, 98);
INSERT INTO public.bus_routes VALUES (38, 80, 16, 2, 792);
INSERT INTO public.bus_routes VALUES (39, 81, 17, 2, 374);
INSERT INTO public.bus_routes VALUES (41, 78, 2, 3, 340);
INSERT INTO public.bus_routes VALUES (42, 77, 3, 3, 324);
INSERT INTO public.bus_routes VALUES (43, 76, 4, 3, 403);
INSERT INTO public.bus_routes VALUES (44, 75, 5, 3, 162);
INSERT INTO public.bus_routes VALUES (45, 74, 6, 3, 101);
INSERT INTO public.bus_routes VALUES (46, 73, 7, 3, 222);
INSERT INTO public.bus_routes VALUES (47, 72, 8, 3, 136);
INSERT INTO public.bus_routes VALUES (48, 31, 9, 3, 91);
INSERT INTO public.bus_routes VALUES (49, 32, 10, 3, 83);
INSERT INTO public.bus_routes VALUES (50, 33, 11, 3, 181);
INSERT INTO public.bus_routes VALUES (51, 34, 12, 3, 132);
INSERT INTO public.bus_routes VALUES (52, 94, 13, 3, 177);
INSERT INTO public.bus_routes VALUES (53, 93, 14, 3, 119);
INSERT INTO public.bus_routes VALUES (54, 89, 15, 3, 290);
INSERT INTO public.bus_routes VALUES (55, 90, 16, 3, 257);
INSERT INTO public.bus_routes VALUES (188, 54, 21, 8, 160);
INSERT INTO public.bus_routes VALUES (189, 56, 22, 8, 102);
INSERT INTO public.bus_routes VALUES (190, 57, 23, 8, 213);
INSERT INTO public.bus_routes VALUES (191, 58, 24, 8, 102);
INSERT INTO public.bus_routes VALUES (192, 21, 25, 8, 279);
INSERT INTO public.bus_routes VALUES (193, 20, 26, 8, 92);
INSERT INTO public.bus_routes VALUES (194, 19, 27, 8, 179);
INSERT INTO public.bus_routes VALUES (202, 34, 8, 9, 177);
INSERT INTO public.bus_routes VALUES (203, 35, 9, 9, 90);
INSERT INTO public.bus_routes VALUES (204, 36, 10, 9, 137);
INSERT INTO public.bus_routes VALUES (205, 37, 11, 9, 131);
INSERT INTO public.bus_routes VALUES (206, 38, 12, 9, 145);
INSERT INTO public.bus_routes VALUES (207, 39, 13, 9, 106);
INSERT INTO public.bus_routes VALUES (208, 40, 14, 9, 106);
INSERT INTO public.bus_routes VALUES (209, 41, 15, 9, 104);
INSERT INTO public.bus_routes VALUES (210, 42, 16, 9, 135);
INSERT INTO public.bus_routes VALUES (211, 43, 17, 9, 209);
INSERT INTO public.bus_routes VALUES (212, 47, 18, 9, 138);
INSERT INTO public.bus_routes VALUES (213, 48, 19, 9, 81);
INSERT INTO public.bus_routes VALUES (214, 49, 20, 9, 154);
INSERT INTO public.bus_routes VALUES (215, 51, 21, 9, 157);
INSERT INTO public.bus_routes VALUES (216, 52, 22, 9, 156);
INSERT INTO public.bus_routes VALUES (217, 53, 23, 9, 258);
INSERT INTO public.bus_routes VALUES (218, 13, 24, 9, 131);
INSERT INTO public.bus_routes VALUES (219, 14, 25, 9, 124);
INSERT INTO public.bus_routes VALUES (220, 15, 26, 9, 110);
INSERT INTO public.bus_routes VALUES (222, 20, 2, 10, 179);
INSERT INTO public.bus_routes VALUES (223, 21, 3, 10, 92);
INSERT INTO public.bus_routes VALUES (224, 3, 4, 10, 163);
INSERT INTO public.bus_routes VALUES (225, 4, 5, 10, 170);
INSERT INTO public.bus_routes VALUES (226, 5, 6, 10, 137);
INSERT INTO public.bus_routes VALUES (227, 6, 7, 10, 105);
INSERT INTO public.bus_routes VALUES (228, 7, 8, 10, 223);
INSERT INTO public.bus_routes VALUES (229, 8, 9, 10, 377);
INSERT INTO public.bus_routes VALUES (230, 9, 10, 10, 430);
INSERT INTO public.bus_routes VALUES (231, 10, 11, 10, 365);
INSERT INTO public.bus_routes VALUES (294, 53, 4, 13, 131);
INSERT INTO public.bus_routes VALUES (295, 52, 5, 13, 258);
INSERT INTO public.bus_routes VALUES (296, 51, 6, 13, 156);
INSERT INTO public.bus_routes VALUES (297, 49, 7, 13, 157);
INSERT INTO public.bus_routes VALUES (298, 50, 8, 13, 97);
INSERT INTO public.bus_routes VALUES (299, 26, 9, 13, 173);
INSERT INTO public.bus_routes VALUES (300, 27, 10, 13, 187);
INSERT INTO public.bus_routes VALUES (301, 28, 11, 13, 141);
INSERT INTO public.bus_routes VALUES (302, 29, 12, 13, 117);
INSERT INTO public.bus_routes VALUES (303, 30, 13, 13, 114);
INSERT INTO public.bus_routes VALUES (304, 72, 14, 13, 75);
INSERT INTO public.bus_routes VALUES (305, 73, 15, 13, 136);
INSERT INTO public.bus_routes VALUES (306, 74, 16, 13, 222);
INSERT INTO public.bus_routes VALUES (307, 69, 17, 13, 139);
INSERT INTO public.bus_routes VALUES (308, 68, 18, 13, 89);
INSERT INTO public.bus_routes VALUES (309, 64, 19, 13, 81);
INSERT INTO public.bus_routes VALUES (310, 63, 20, 13, 117);
INSERT INTO public.bus_routes VALUES (311, 62, 21, 13, 160);
INSERT INTO public.bus_routes VALUES (312, 82, 22, 13, 54);
INSERT INTO public.bus_routes VALUES (313, 83, 23, 13, 269);
INSERT INTO public.bus_routes VALUES (314, 84, 24, 13, 98);
INSERT INTO public.bus_routes VALUES (315, 85, 25, 13, 115);
INSERT INTO public.bus_routes VALUES (316, 56, 26, 13, 212);
INSERT INTO public.bus_routes VALUES (317, 57, 27, 13, 213);
INSERT INTO public.bus_routes VALUES (318, 58, 28, 13, 102);
INSERT INTO public.bus_routes VALUES (319, 21, 29, 13, 279);
INSERT INTO public.bus_routes VALUES (320, 16, 30, 13, 167);
INSERT INTO public.bus_routes VALUES (321, 11, 31, 13, 134);
INSERT INTO public.bus_routes VALUES (322, 1, 32, 13, 77);
INSERT INTO public.bus_routes VALUES (323, 22, 33, 13, 170);
INSERT INTO public.bus_routes VALUES (324, 23, 34, 13, 111);
INSERT INTO public.bus_routes VALUES (325, 24, 35, 13, 111);
INSERT INTO public.bus_routes VALUES (326, 25, 36, 13, 118);
INSERT INTO public.bus_routes VALUES (327, 67, 37, 13, 133);
INSERT INTO public.bus_routes VALUES (328, 66, 38, 13, 116);
INSERT INTO public.bus_routes VALUES (329, 65, 39, 13, 168);
INSERT INTO public.bus_routes VALUES (331, 80, 2, 14, 374);
INSERT INTO public.bus_routes VALUES (332, 62, 3, 14, 558);
INSERT INTO public.bus_routes VALUES (333, 63, 4, 14, 160);
INSERT INTO public.bus_routes VALUES (334, 64, 5, 14, 117);
INSERT INTO public.bus_routes VALUES (335, 68, 6, 14, 81);
INSERT INTO public.bus_routes VALUES (336, 69, 7, 14, 89);
INSERT INTO public.bus_routes VALUES (337, 74, 8, 14, 139);
INSERT INTO public.bus_routes VALUES (338, 73, 9, 14, 222);
INSERT INTO public.bus_routes VALUES (339, 31, 10, 14, 180);
INSERT INTO public.bus_routes VALUES (340, 32, 11, 14, 83);
INSERT INTO public.bus_routes VALUES (341, 33, 12, 14, 181);
INSERT INTO public.bus_routes VALUES (342, 34, 13, 14, 132);
INSERT INTO public.bus_routes VALUES (343, 94, 14, 14, 177);
INSERT INTO public.bus_routes VALUES (344, 93, 15, 14, 119);
INSERT INTO public.bus_routes VALUES (345, 92, 16, 14, 141);
INSERT INTO public.bus_routes VALUES (346, 91, 17, 14, 91);
INSERT INTO public.bus_routes VALUES (347, 90, 18, 14, 112);
INSERT INTO public.bus_routes VALUES (348, 86, 19, 14, 131);
INSERT INTO public.bus_routes VALUES (349, 87, 20, 14, 242);
INSERT INTO public.bus_routes VALUES (350, 38, 21, 14, 230);
INSERT INTO public.bus_routes VALUES (351, 37, 22, 14, 145);
INSERT INTO public.bus_routes VALUES (352, 36, 23, 14, 131);
INSERT INTO public.bus_routes VALUES (353, 35, 24, 14, 137);
INSERT INTO public.bus_routes VALUES (354, 28, 25, 14, 309);
INSERT INTO public.bus_routes VALUES (355, 27, 26, 14, 141);
INSERT INTO public.bus_routes VALUES (356, 26, 27, 14, 187);
INSERT INTO public.bus_routes VALUES (357, 50, 28, 14, 173);
INSERT INTO public.bus_routes VALUES (358, 49, 29, 14, 97);
INSERT INTO public.bus_routes VALUES (359, 48, 30, 14, 154);
INSERT INTO public.bus_routes VALUES (360, 47, 31, 14, 81);
INSERT INTO public.bus_routes VALUES (361, 43, 32, 14, 138);
INSERT INTO public.bus_routes VALUES (362, 51, 33, 14, 295);
INSERT INTO public.bus_routes VALUES (363, 52, 34, 14, 156);
INSERT INTO public.bus_routes VALUES (364, 53, 35, 14, 258);
INSERT INTO public.bus_routes VALUES (365, 13, 36, 14, 131);
INSERT INTO public.bus_routes VALUES (366, 18, 37, 14, 176);
INSERT INTO public.bus_routes VALUES (367, 19, 38, 14, 143);
INSERT INTO public.bus_routes VALUES (369, 87, 2, 15, 132);
INSERT INTO public.bus_routes VALUES (370, 86, 3, 15, 242);
INSERT INTO public.bus_routes VALUES (371, 90, 4, 15, 131);
INSERT INTO public.bus_routes VALUES (372, 89, 5, 15, 257);
INSERT INTO public.bus_routes VALUES (373, 93, 6, 15, 290);
INSERT INTO public.bus_routes VALUES (374, 94, 7, 15, 119);
INSERT INTO public.bus_routes VALUES (375, 34, 8, 15, 177);
INSERT INTO public.bus_routes VALUES (376, 35, 9, 15, 90);
INSERT INTO public.bus_routes VALUES (377, 28, 10, 15, 309);
INSERT INTO public.bus_routes VALUES (378, 27, 11, 15, 141);
INSERT INTO public.bus_routes VALUES (379, 26, 12, 15, 187);
INSERT INTO public.bus_routes VALUES (380, 25, 13, 15, 140);
INSERT INTO public.bus_routes VALUES (381, 24, 14, 15, 118);
INSERT INTO public.bus_routes VALUES (382, 23, 15, 15, 111);
INSERT INTO public.bus_routes VALUES (383, 22, 16, 15, 111);
INSERT INTO public.bus_routes VALUES (384, 1, 17, 15, 170);
INSERT INTO public.bus_routes VALUES (385, 2, 18, 15, 189);
INSERT INTO public.bus_routes VALUES (386, 3, 19, 15, 187);
INSERT INTO public.bus_routes VALUES (387, 4, 20, 15, 170);
INSERT INTO public.bus_routes VALUES (388, 5, 21, 15, 137);
INSERT INTO public.bus_routes VALUES (389, 6, 22, 15, 105);
INSERT INTO public.bus_routes VALUES (390, 7, 23, 15, 223);
INSERT INTO public.bus_routes VALUES (391, 8, 24, 15, 377);
INSERT INTO public.bus_routes VALUES (392, 9, 25, 15, 430);
INSERT INTO public.bus_routes VALUES (393, 10, 26, 15, 365);
INSERT INTO public.bus_routes VALUES (395, 78, 2, 16, 340);
INSERT INTO public.bus_routes VALUES (396, 77, 3, 16, 324);
INSERT INTO public.bus_routes VALUES (397, 76, 4, 16, 403);
INSERT INTO public.bus_routes VALUES (398, 75, 5, 16, 162);
INSERT INTO public.bus_routes VALUES (399, 74, 6, 16, 101);
INSERT INTO public.bus_routes VALUES (400, 70, 7, 16, 159);
INSERT INTO public.bus_routes VALUES (401, 71, 8, 16, 171);
INSERT INTO public.bus_routes VALUES (402, 28, 9, 16, 186);
INSERT INTO public.bus_routes VALUES (403, 27, 10, 16, 141);
INSERT INTO public.bus_routes VALUES (404, 26, 11, 16, 187);
INSERT INTO public.bus_routes VALUES (405, 50, 12, 16, 173);
INSERT INTO public.bus_routes VALUES (406, 49, 13, 16, 97);
INSERT INTO public.bus_routes VALUES (407, 48, 14, 16, 154);
INSERT INTO public.bus_routes VALUES (408, 47, 15, 16, 81);
INSERT INTO public.bus_routes VALUES (409, 43, 16, 16, 138);
INSERT INTO public.bus_routes VALUES (410, 42, 17, 16, 209);
INSERT INTO public.bus_routes VALUES (411, 41, 18, 16, 135);
INSERT INTO public.bus_routes VALUES (412, 40, 19, 16, 104);
INSERT INTO public.bus_routes VALUES (413, 39, 20, 16, 106);
INSERT INTO public.bus_routes VALUES (414, 38, 21, 16, 106);
INSERT INTO public.bus_routes VALUES (415, 37, 22, 16, 145);
INSERT INTO public.bus_routes VALUES (416, 36, 23, 16, 131);
INSERT INTO public.bus_routes VALUES (417, 35, 24, 16, 137);
INSERT INTO public.bus_routes VALUES (418, 34, 25, 16, 90);
INSERT INTO public.bus_routes VALUES (419, 94, 26, 16, 177);
INSERT INTO public.bus_routes VALUES (420, 93, 27, 16, 119);
INSERT INTO public.bus_routes VALUES (421, 89, 28, 16, 290);
INSERT INTO public.bus_routes VALUES (422, 90, 29, 16, 257);
INSERT INTO public.bus_routes VALUES (423, 86, 30, 16, 131);
INSERT INTO public.bus_routes VALUES (424, 87, 31, 16, 242);
INSERT INTO public.bus_routes VALUES (425, 88, 32, 16, 132);
INSERT INTO public.bus_routes VALUES (427, 14, 2, 17, 110);
INSERT INTO public.bus_routes VALUES (428, 13, 3, 17, 124);
INSERT INTO public.bus_routes VALUES (429, 17, 4, 17, 170);
INSERT INTO public.bus_routes VALUES (430, 16, 5, 17, 95);
INSERT INTO public.bus_routes VALUES (431, 11, 6, 17, 134);
INSERT INTO public.bus_routes VALUES (432, 1, 7, 17, 77);
INSERT INTO public.bus_routes VALUES (433, 54, 8, 17, 160);
INSERT INTO public.bus_routes VALUES (434, 56, 9, 17, 102);
INSERT INTO public.bus_routes VALUES (435, 85, 10, 17, 212);
INSERT INTO public.bus_routes VALUES (436, 84, 11, 17, 115);
INSERT INTO public.bus_routes VALUES (437, 83, 12, 17, 98);
INSERT INTO public.bus_routes VALUES (438, 82, 13, 17, 269);
INSERT INTO public.bus_routes VALUES (439, 61, 14, 17, 227);
INSERT INTO public.bus_routes VALUES (440, 60, 15, 17, 140);
INSERT INTO public.bus_routes VALUES (441, 59, 16, 17, 491);
INSERT INTO public.bus_routes VALUES (442, 57, 17, 17, 102);
INSERT INTO public.bus_routes VALUES (443, 58, 18, 17, 102);
INSERT INTO public.bus_routes VALUES (444, 2, 19, 17, 188);
INSERT INTO public.bus_routes VALUES (445, 21, 20, 17, 161);
INSERT INTO public.bus_routes VALUES (446, 20, 21, 17, 92);
INSERT INTO public.bus_routes VALUES (447, 18, 22, 17, 143);
INSERT INTO public.bus_routes VALUES (448, 53, 23, 17, 275);
INSERT INTO public.bus_routes VALUES (449, 52, 24, 17, 258);
INSERT INTO public.bus_routes VALUES (450, 51, 25, 17, 156);
INSERT INTO public.bus_routes VALUES (451, 49, 26, 17, 157);
INSERT INTO public.bus_routes VALUES (452, 50, 27, 17, 97);
INSERT INTO public.bus_routes VALUES (453, 26, 28, 17, 173);
INSERT INTO public.bus_routes VALUES (454, 67, 29, 17, 131);
INSERT INTO public.bus_routes VALUES (455, 66, 30, 17, 116);
INSERT INTO public.bus_routes VALUES (456, 65, 31, 17, 168);
INSERT INTO public.bus_routes VALUES (457, 64, 32, 17, 166);
INSERT INTO public.bus_routes VALUES (458, 68, 33, 17, 81);
INSERT INTO public.bus_routes VALUES (459, 69, 34, 17, 89);
INSERT INTO public.bus_routes VALUES (460, 74, 35, 17, 139);
INSERT INTO public.bus_routes VALUES (461, 73, 36, 17, 222);
INSERT INTO public.bus_routes VALUES (462, 31, 37, 17, 180);
INSERT INTO public.bus_routes VALUES (463, 32, 38, 17, 83);
INSERT INTO public.bus_routes VALUES (464, 33, 39, 17, 181);
INSERT INTO public.bus_routes VALUES (465, 34, 40, 17, 132);
INSERT INTO public.bus_routes VALUES (466, 94, 41, 17, 177);
INSERT INTO public.bus_routes VALUES (467, 93, 42, 17, 119);
INSERT INTO public.bus_routes VALUES (468, 92, 43, 17, 141);
INSERT INTO public.bus_routes VALUES (469, 91, 44, 17, 91);
INSERT INTO public.bus_routes VALUES (470, 90, 45, 17, 112);
INSERT INTO public.bus_routes VALUES (471, 86, 46, 17, 131);
INSERT INTO public.bus_routes VALUES (472, 87, 47, 17, 242);
INSERT INTO public.bus_routes VALUES (473, 88, 48, 17, 132);
INSERT INTO public.bus_routes VALUES (475, 33, 2, 18, 181);
INSERT INTO public.bus_routes VALUES (476, 47, 3, 18, 553);
INSERT INTO public.bus_routes VALUES (477, 48, 4, 18, 81);
INSERT INTO public.bus_routes VALUES (478, 49, 5, 18, 154);
INSERT INTO public.bus_routes VALUES (479, 50, 6, 18, 97);
INSERT INTO public.bus_routes VALUES (480, 26, 7, 18, 173);
INSERT INTO public.bus_routes VALUES (481, 25, 8, 18, 140);
INSERT INTO public.bus_routes VALUES (482, 24, 9, 18, 118);
INSERT INTO public.bus_routes VALUES (483, 23, 10, 18, 111);
INSERT INTO public.bus_routes VALUES (484, 22, 11, 18, 111);
INSERT INTO public.bus_routes VALUES (485, 1, 12, 18, 170);
INSERT INTO public.bus_routes VALUES (486, 11, 13, 18, 77);
INSERT INTO public.bus_routes VALUES (487, 12, 14, 18, 148);
INSERT INTO public.bus_routes VALUES (488, 13, 15, 18, 119);
INSERT INTO public.bus_routes VALUES (489, 14, 16, 18, 124);
INSERT INTO public.bus_routes VALUES (490, 15, 17, 18, 110);
INSERT INTO public.bus_routes VALUES (492, 80, 2, 19, 374);
INSERT INTO public.bus_routes VALUES (493, 61, 3, 19, 543);
INSERT INTO public.bus_routes VALUES (494, 60, 4, 19, 140);
INSERT INTO public.bus_routes VALUES (495, 59, 5, 19, 491);
INSERT INTO public.bus_routes VALUES (496, 57, 6, 19, 102);
INSERT INTO public.bus_routes VALUES (497, 56, 7, 19, 213);
INSERT INTO public.bus_routes VALUES (498, 54, 8, 19, 102);
INSERT INTO public.bus_routes VALUES (499, 1, 9, 19, 160);
INSERT INTO public.bus_routes VALUES (500, 22, 10, 19, 170);
INSERT INTO public.bus_routes VALUES (501, 23, 11, 19, 111);
INSERT INTO public.bus_routes VALUES (502, 24, 12, 19, 111);
INSERT INTO public.bus_routes VALUES (503, 25, 13, 19, 118);
INSERT INTO public.bus_routes VALUES (504, 26, 14, 19, 140);
INSERT INTO public.bus_routes VALUES (505, 27, 15, 19, 187);
INSERT INTO public.bus_routes VALUES (506, 28, 16, 19, 141);
INSERT INTO public.bus_routes VALUES (507, 29, 17, 19, 117);
INSERT INTO public.bus_routes VALUES (508, 30, 18, 19, 114);
INSERT INTO public.bus_routes VALUES (509, 31, 19, 19, 129);
INSERT INTO public.bus_routes VALUES (510, 32, 20, 19, 83);
INSERT INTO public.bus_routes VALUES (511, 33, 21, 19, 181);
INSERT INTO public.bus_routes VALUES (512, 34, 22, 19, 132);
INSERT INTO public.bus_routes VALUES (513, 94, 23, 19, 177);
INSERT INTO public.bus_routes VALUES (514, 93, 24, 19, 119);
INSERT INTO public.bus_routes VALUES (515, 89, 25, 19, 290);
INSERT INTO public.bus_routes VALUES (516, 90, 26, 19, 257);
INSERT INTO public.bus_routes VALUES (517, 86, 27, 19, 131);
INSERT INTO public.bus_routes VALUES (518, 87, 28, 19, 242);
INSERT INTO public.bus_routes VALUES (564, 86, 20, 21, 131);
INSERT INTO public.bus_routes VALUES (565, 87, 21, 21, 242);
INSERT INTO public.bus_routes VALUES (566, 88, 22, 21, 132);
INSERT INTO public.bus_routes VALUES (576, 23, 10, 22, 111);
INSERT INTO public.bus_routes VALUES (577, 24, 11, 22, 111);
INSERT INTO public.bus_routes VALUES (578, 25, 12, 22, 118);
INSERT INTO public.bus_routes VALUES (579, 26, 13, 22, 140);
INSERT INTO public.bus_routes VALUES (580, 27, 14, 22, 187);
INSERT INTO public.bus_routes VALUES (581, 28, 15, 22, 141);
INSERT INTO public.bus_routes VALUES (582, 29, 16, 22, 117);
INSERT INTO public.bus_routes VALUES (583, 30, 17, 22, 114);
INSERT INTO public.bus_routes VALUES (584, 73, 18, 22, 151);
INSERT INTO public.bus_routes VALUES (585, 74, 19, 22, 222);
INSERT INTO public.bus_routes VALUES (586, 70, 20, 22, 159);
INSERT INTO public.bus_routes VALUES (587, 71, 21, 22, 171);
INSERT INTO public.bus_routes VALUES (588, 35, 22, 22, 447);
INSERT INTO public.bus_routes VALUES (589, 34, 23, 22, 90);
INSERT INTO public.bus_routes VALUES (519, 38, 29, 19, 230);
INSERT INTO public.bus_routes VALUES (520, 39, 30, 19, 106);
INSERT INTO public.bus_routes VALUES (521, 40, 31, 19, 106);
INSERT INTO public.bus_routes VALUES (522, 41, 32, 19, 104);
INSERT INTO public.bus_routes VALUES (523, 42, 33, 19, 135);
INSERT INTO public.bus_routes VALUES (525, 20, 2, 20, 179);
INSERT INTO public.bus_routes VALUES (526, 21, 3, 20, 92);
INSERT INTO public.bus_routes VALUES (527, 58, 4, 20, 279);
INSERT INTO public.bus_routes VALUES (528, 57, 5, 20, 102);
INSERT INTO public.bus_routes VALUES (529, 56, 6, 20, 213);
INSERT INTO public.bus_routes VALUES (530, 54, 7, 20, 102);
INSERT INTO public.bus_routes VALUES (531, 1, 8, 20, 160);
INSERT INTO public.bus_routes VALUES (532, 22, 9, 20, 170);
INSERT INTO public.bus_routes VALUES (533, 23, 10, 20, 111);
INSERT INTO public.bus_routes VALUES (534, 24, 11, 20, 111);
INSERT INTO public.bus_routes VALUES (535, 25, 12, 20, 118);
INSERT INTO public.bus_routes VALUES (536, 52, 13, 20, 291);
INSERT INTO public.bus_routes VALUES (537, 51, 14, 20, 156);
INSERT INTO public.bus_routes VALUES (538, 49, 15, 20, 157);
INSERT INTO public.bus_routes VALUES (539, 48, 16, 20, 154);
INSERT INTO public.bus_routes VALUES (540, 47, 17, 20, 81);
INSERT INTO public.bus_routes VALUES (541, 43, 18, 20, 138);
INSERT INTO public.bus_routes VALUES (542, 44, 19, 20, 102);
INSERT INTO public.bus_routes VALUES (543, 45, 20, 20, 163);
INSERT INTO public.bus_routes VALUES (544, 46, 21, 20, 146);
INSERT INTO public.bus_routes VALUES (546, 18, 2, 21, 143);
INSERT INTO public.bus_routes VALUES (547, 17, 3, 21, 120);
INSERT INTO public.bus_routes VALUES (548, 16, 4, 21, 95);
INSERT INTO public.bus_routes VALUES (549, 11, 5, 21, 134);
INSERT INTO public.bus_routes VALUES (550, 1, 6, 21, 77);
INSERT INTO public.bus_routes VALUES (551, 22, 7, 21, 170);
INSERT INTO public.bus_routes VALUES (552, 23, 8, 21, 111);
INSERT INTO public.bus_routes VALUES (553, 24, 9, 21, 111);
INSERT INTO public.bus_routes VALUES (554, 25, 10, 21, 118);
INSERT INTO public.bus_routes VALUES (555, 26, 11, 21, 140);
INSERT INTO public.bus_routes VALUES (556, 27, 12, 21, 187);
INSERT INTO public.bus_routes VALUES (557, 28, 13, 21, 141);
INSERT INTO public.bus_routes VALUES (558, 35, 14, 21, 309);
INSERT INTO public.bus_routes VALUES (559, 94, 15, 21, 196);
INSERT INTO public.bus_routes VALUES (560, 93, 16, 21, 119);
INSERT INTO public.bus_routes VALUES (561, 92, 17, 21, 141);
INSERT INTO public.bus_routes VALUES (562, 91, 18, 21, 91);
INSERT INTO public.bus_routes VALUES (563, 90, 19, 21, 112);
INSERT INTO public.bus_routes VALUES (568, 52, 2, 22, 156);
INSERT INTO public.bus_routes VALUES (569, 53, 3, 22, 258);
INSERT INTO public.bus_routes VALUES (570, 13, 4, 22, 131);
INSERT INTO public.bus_routes VALUES (571, 17, 5, 22, 170);
INSERT INTO public.bus_routes VALUES (572, 16, 6, 22, 95);
INSERT INTO public.bus_routes VALUES (573, 2, 7, 22, 151);
INSERT INTO public.bus_routes VALUES (574, 1, 8, 22, 189);
INSERT INTO public.bus_routes VALUES (575, 22, 9, 22, 170);
INSERT INTO public.bus_routes VALUES (590, 94, 24, 22, 177);
INSERT INTO public.bus_routes VALUES (591, 93, 25, 22, 119);
INSERT INTO public.bus_routes VALUES (592, 92, 26, 22, 141);
INSERT INTO public.bus_routes VALUES (593, 91, 27, 22, 91);
INSERT INTO public.bus_routes VALUES (594, 90, 28, 22, 112);
INSERT INTO public.bus_routes VALUES (595, 86, 29, 22, 131);
INSERT INTO public.bus_routes VALUES (596, 87, 30, 22, 242);
INSERT INTO public.bus_routes VALUES (597, 88, 31, 22, 132);


ALTER TABLE public.bus_routes ENABLE TRIGGER ALL;

--
-- Name: bus_routes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: example
--

SELECT pg_catalog.setval('public.bus_routes_id_seq', 597, true);


--
-- Name: buses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: example
--

SELECT pg_catalog.setval('public.buses_id_seq', 24, true);


--
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: example
--

SELECT pg_catalog.setval('public.routes_id_seq', 24, true);


--
-- Name: schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: example
--

SELECT pg_catalog.setval('public.schedules_id_seq', 1, true);


--
-- Name: stops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: example
--

SELECT pg_catalog.setval('public.stops_id_seq', 94, true);


--
-- PostgreSQL database dump complete
--

\unrestrict VE4HoNJq5kCMUrNpMa6Ht7ygXdp7yASVM3eW3lIVGpv7bldHXUvnsuelTZwRQPY

