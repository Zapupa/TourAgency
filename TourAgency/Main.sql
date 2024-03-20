USE [C:\Users\Progamix\source\repos\TourAgency\TourAgency\Database3.mdf]

CREATE TABLE [Clients](
    [id_client] INT NOT NULL IDENTITY(1,1),
    [c_surname] NVARCHAR(20) NOT NULL,
    [c_name] NVARCHAR(20) NOT NULL,
    [c_patronymic] NVARCHAR(20),
    [c_passport] NVARCHAR(20) NOT NULL,
    [c_gender] NVARCHAR(20) NOT NULL CHECK ([c_gender] = N'мужской' OR [c_gender] = N'женский'),
    [c_age] INT NOT NULL,
    [c_children] NVARCHAR(40),
    [c_preference] NVARCHAR(30) NOT NULL,

    CONSTRAINT [PK_client_id] PRIMARY KEY([id_client])
)

CREATE TABLE [Hotels](
    [id_hotel] INT NOT NULL IDENTITY(1,1),
    [h_name] NVARCHAR(20) NOT NULL,
    [h_adress] NVARCHAR(100) NOT NULL,
    [h_phone] BIGINT NOT NULL,

    CONSTRAINT [PK_hotels_id] PRIMARY KEY([id_hotel])
)

CREATE TABLE [Groups](
    [id_group] INT NOT NULL IDENTITY(1,1),
    [g_country] NVARCHAR(20) NOT NULL,
    [g_city] NVARCHAR(20) NOT NULL,
    [hotel_id] INT NOT NULL

    CONSTRAINT [PK_groups_id] PRIMARY KEY([id_group]),
    CONSTRAINT [FK_groups_hotel_id] FOREIGN KEY([hotel_id]) REFERENCES [Hotels]([id_hotel])
)

CREATE TABLE [Tourists](
    [id_tourist] INT NOT NULL IDENTITY(1,1),
    [group_id] INT NOT NULL,
    [client_id] INT NOT NULL,
    [t_room] NVARCHAR(10) NOT NULL,
    [t_visa] NVARCHAR(20) 

    CONSTRAINT [PK_tourists_id] PRIMARY KEY([id_tourist]),
    CONSTRAINT [FK_tourists_group_id] FOREIGN KEY([group_id]) REFERENCES [Groups]([id_group]),
    CONSTRAINT [FK_tourists_client_id] FOREIGN KEY([client_id]) REFERENCES [Clients]([id_client])
)

CREATE TABLE [Guides](
    [id_guide] INT NOT NULL IDENTITY(1,1),
    [g_surname] NVARCHAR(20) NOT NULL,
    [g_name] NVARCHAR(20) NOT NULL,
    [g_patronymic] NVARCHAR(20),
    [g_phone] BIGINT NOT NULL,

    CONSTRAINT [PK_guides_id] PRIMARY KEY([id_guide])
)

CREATE TABLE [Excursions](
    [id_excursion] INT NOT NULL IDENTITY(1,1),
    [e_name] NVARCHAR(100) NOT NULL,
    [e_description] NVARCHAR(500) NOT NULL,
    [e_date] DATE NOT NULL,
    [e_price] MONEY NOT NULL,
    [guide_id] INT NOT NULL

    CONSTRAINT [PK_excursions_id] PRIMARY KEY([id_excursion]),
    CONSTRAINT [FK_excursions_guide_id] FOREIGN KEY([guide_id]) REFERENCES [Guides]([id_guide])
)

CREATE TABLE [Attendances](
    [id_attendance] INT NOT NULL IDENTITY(1,1),
    [excursion_id] INT NOT NULL,
    [tourist_id] INT NOT NULL

    CONSTRAINT [PK_attendances_id] PRIMARY KEY([id_attendance]),
    CONSTRAINT [FK_attendance_excursion_id] FOREIGN KEY([excursion_id]) REFERENCES [Excursions]([id_excursion]),
    CONSTRAINT [FK_attendance_tourist_id] FOREIGN KEY([tourist_id]) REFERENCES [Tourists]([id_tourist])
)

INSERT INTO
    [Clients]([c_surname], [c_name], [c_patronymic], [c_passport], [c_gender], [c_age], [c_children], [c_preference])
VALUES
    (N'Абдразманов', N'Давид', N'Витальевич', N'82 09 564342', N'мужской', 20, N'нет', N'Eras Hotel'),
    (N'Лебедев', N'Дмитрий', N'Константинович', N'76 23 213424', N'женский', 19, N'нет', N'Fors Hotel'),
    (N'Абдрахманова', N'Карина', N'Мориарти', N'82 09 467543', N'женский', 19, N'нет', N'Eras Hotel'),
    (N'Иванов', N'Матвей', N'Юрьевич', N'89 22 123134', N'мужской', 32, N'нет', N'Vizyon Hotel'),
    (N'Саблин', N'Георгий', N'Георгий', N'92 23 153442', N'мужской', 43, N'нет', N'Taihan Hotel')

INSERT INTO
    [Hotels]([h_name], [h_adress], [h_phone])
VALUES
    (N'Eras Hotel', N'Tekir Yaylası Erciyes, Fatih/İstanbul, Турция', 89516758903),
    (N'Fors Hotel', N'Şehsuvar Bey, Kadırga Hamamı Sk. No:10, Fatih/İstanbul, Турция', 902125170961),
    (N'Vizyon Hotel', N'Emin Sinan, Gedik Paşa Cami Sk. No:52, 34123 Fatih/İstanbul, Турция', 9021263804),
    (N'Taihan', N'Muhsine Hatun, Türkeli Cd. No:5, 34130 Fatih/İstanbul, Турция', 902125179525)

INSERT INTO
    [Groups]([g_country], [g_city], [hotel_id])
VALUES
    (N'Стамбул', N'Турция' , 1),
    (N'Стамбул', N'Турция' , 3),
    (N'Стамбул', N'Турция' , 1),
    (N'Стамбул', N'Турция' , 2),
    (N'Стамбул', N'Турция' , 4)

INSERT INTO
    [Tourists]([group_id], [client_id], [t_room], [t_visa])
VALUES
    (1, 1, N'363', N'33 9843433'),
    (1, 3, N'363', N'33 7824212'),
    (2, 4, N'363', N'23 3124552'),
    (4, 2, N'363', N'56 3423523'),
    (5, 2, N'363', N'32 6523535')

INSERT INTO
    [Guides]([g_surname], [g_name], [g_patronymic], [g_phone])
VALUES
    (N'Йылмаз', N'Мустафа', NULL, 90212634),
    (N'Кайя', N'Махмуд', NULL, 90756473),
    (N'Демир', N'Салих', NULL, 90932243),
    (N'Челик', N'Кемаль', NULL, 90325764),
    (N'Шахин', N'Рамазан', NULL, 90124244)

INSERT INTO
    [Excursions]([e_name], [e_description], [e_date], [e_price], [guide_id])
VALUES
    (N'Влюбляя в Стамбул: прогулка с местной жительницей', N'Если вы уже ознакомились с центральными достопримечательностями Стамбула, то самое время увидеть город с нетуристической стороны. Я проведу вас по моим любимым местам, колоритным районам, уютным улочкам. Богемный Джихангир, Арнавуткёй с уникальной застройкой 19 века, атмосферные уголки Азиатской части, холм Чамлыджа и Босфор... Стамбул, встречай!', GETDATE(), 36, 1),
    (N'Стамбул с харизмой: от Балата до Босфора', N'Чтобы понять Стамбул, недостаточно просто познакомиться с Айя-Софией и Голубой мечетью: приглашаем вас открыть неизведанные грани города! С гидом вы прогуляетесь по району Балат с его красочными фасадами и атмосферными улочками, поторгуетесь в лавках Гранд-базара и Египетского рынка. Увидите гробницу султана Сулеймана, а после полюбуетесь городом, проплывая через Босфор.', GETDATE(), 129, 2),
    (N'Стамбул пешком — с двух сторон Босфора', N'Огромный город с богатейшей историей, да ещё на двух континентах... Мы поможем вам сориентироваться в Стамбуле, понять и полюбить его. За 4,5 часа вы погуляете по очень разным районам и улицам: это новый стильный Галатапорт, молодёжный Каракёй, консервативный Ускюдар и ажурный Кузгунджук. А ещё пройдёте по Босфору на кораблике и пообедаете в ресторане внучки султана.', GETDATE(), 77, 3),
    (N'Прогулка-квест по самобытному Кадыкёю', N'Когда Стамбульская «Европа» исхожена вдоль и поперёк, пора приниматься за другую сторону столицы — азиатскую! Гостеприимный, почти не туристический Кадыкёй гораздо интереснее открыть на дружеской квест-прогулке. Вы пройдете по антикварным и ремесленным улочкам, посетите любимые заведения местных и вдохнете ароматы восточного базара. Услышите рассказ о турецком Пушкине и взглянете на Мраморное море с лучшего ракурса.', GETDATE(), 125, 4),
    (N'Азиатский Стамбул: полное погружение', N'Не каждый путешественник перебирается через Босфор в азиатскую часть Стамбула — и зря! В Ускюдаре в основном живут и отдыхают местные, поэтому за настоящим Стамбулом именно сюда. Мы не спеша прогуляемся по колоритным улицам, выпьем чаю с видом на Босфор и насладимся расслабленной атмосферой района.', GETDATE(), 39, 5)

INSERT INTO
    [Attendances]([excursion_id], [tourist_id])
VALUES
    (1, 1),
    (1, 3),
    (4, 2),
    (5, 5),
    (3, 4)
