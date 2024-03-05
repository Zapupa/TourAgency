USE [C:\Users\Progamix\source\repos\TourAgency\TourAgency\DatabaseMain.mdf]

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
    [h_adress] NVARCHAR(20) NOT NULL,
    [h_phone] INT NOT NULL,

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
    [g_phone] INT NOT NULL,

    CONSTRAINT [PK_guides_id] PRIMARY KEY([id_guide])
)

CREATE TABLE [Excursions](
    [id_excursion] INT NOT NULL IDENTITY(1,1),
    [e_name] NVARCHAR(20) NOT NULL,
    [e_description] NVARCHAR(20) NOT NULL,
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