DROP DATABASE `pocli`;

CREATE DATABASE `pocli`;

USE `pocli`;

CREATE TABLE `eventDocuments`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `idDocument` INT NOT NULL,
    `idEvent` INT NOT NULL
);

CREATE TABLE `communicationMembers`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `idFamilyMember` INT NOT NULL,
    `idCommunication` INT NOT NULL,
    `isOpened` TINYINT(1) NOT NULL
);

CREATE TABLE `admins` (
    `id` INT auto_increment PRIMARY KEY,
    `firstname` VARCHAR(100) NOT NULL,
    `lastname` VARCHAR(100) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(100) NOT NULL
);

CREATE TABLE `partners` (
    `id` INT auto_increment PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `logo` VARCHAR(100) NOT NULL,
    `url` VARCHAR(100) NOT NULL
);

CREATE TABLE `familyMemberEvents`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `idFamilyMember` INT NOT NULL,
    `idEvent` INT NOT NULL
);

CREATE TABLE `communications`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `object` VARCHAR(255) NOT NULL,
    `content` VARCHAR(255) NOT NULL,
    
    `idAdmin` INT NOT NULL,
    `isBanner` TINYINT(1) NOT NULL
);

CREATE TABLE `familyMemberActivities`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `idActivity` INT NOT NULL,
    `idFamilyMember` INT NOT NULL
);

CREATE TABLE `events`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `numberParticipantsMax` INT NULL,
    `date` VARCHAR(100) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `text` TEXT NULL,
    `podcastLink` VARCHAR(255) NULL,
    `reservedAdherent` TINYINT(1) NOT NULL,
    `price` INT NULL,
    `idPostType` INT NOT NULL,
    `idActivity` INT NULL
);

CREATE TABLE `paymentRecords`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `idPaymentMethod` INT NOT NULL,
    `numberCheck` VARCHAR(50) NULL,
    `isPaymentActivity` TINYINT(1) NOT NULL,
    `datePay` VARCHAR(50) NOT NULL,
    `amountPay` INT NOT NULL,
    `idFamily` INT NULL,
    `idFamilyMember` INT NULL,
    `idActivity` INT NOT NULL
);

CREATE TABLE `familyMembers`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `idFamily` INT NOT NULL,
    `firstname` VARCHAR(255) NOT NULL,
    `birthday` VARCHAR(50) NOT NULL,
    `isActive` TINYINT(1) NOT NULL
);

CREATE TABLE `families`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `streetNumber` INT NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `phoneNumber` INT NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `idCity` INT NOT NULL,
    `idRecipient` INT NOT NULL,
    `isActive` TINYINT(1) NOT NULL
);

CREATE TABLE `postTypes`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);

CREATE TABLE `documents`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `url` VARCHAR(255) NOT NULL
);

CREATE TABLE `activities`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `category` VARCHAR(100) NOT NULL,
    `abridged` VARCHAR(100) NOT NULL
);

CREATE TABLE `recipients`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);

CREATE TABLE `cities`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(150) NOT NULL,
    `zipCode` INT NOT NULL
);

CREATE TABLE `paymentMethods`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);

ALTER TABLE
    `paymentRecords`
ADD
    CONSTRAINT `paymentrecords_idpaymentmethod_foreign` FOREIGN KEY(`idPaymentMethod`) REFERENCES `paymentMethods`(`id`);

ALTER TABLE
    `paymentRecords`
ADD
    CONSTRAINT `paymentrecords_idfamily_foreign` FOREIGN KEY(`idFamily`) REFERENCES `families`(`id`);

ALTER TABLE
    `paymentRecords`
ADD
    CONSTRAINT `paymentrecords_idfamilymember_foreign` FOREIGN KEY(`idFamilyMember`) REFERENCES `familyMembers`(`id`);

ALTER TABLE
    `paymentRecords`
ADD
    CONSTRAINT `paymentrecords_idactivity_foreign` FOREIGN KEY(`idActivity`) REFERENCES `activities`(`id`);

ALTER TABLE
    `familyMembers`
ADD
    CONSTRAINT `familymembers_idfamily_foreign` FOREIGN KEY(`idFamily`) REFERENCES `families`(`id`);

ALTER TABLE
    `families`
ADD
    CONSTRAINT `families_idcity_foreign` FOREIGN KEY(`idCity`) REFERENCES `cities`(`id`);

ALTER TABLE
    `families`
ADD
    CONSTRAINT `families_idrecipient_foreign` FOREIGN KEY(`idRecipient`) REFERENCES `recipients`(`id`);

ALTER TABLE
    `familyMemberActivities`
ADD
    CONSTRAINT `familymemberactivities_idactivity_foreign` FOREIGN KEY(`idActivity`) REFERENCES `activities`(`id`);

ALTER TABLE
    `familyMemberActivities`
ADD
    CONSTRAINT `familymemberactivities_idfamilymember_foreign` FOREIGN KEY(`idFamilyMember`) REFERENCES `familyMembers`(`id`);

ALTER TABLE
    `communicationMembers`
ADD
    CONSTRAINT `communicationMembers_idcommunications_foreign` FOREIGN KEY(`idCommunication`) REFERENCES `communications`(`id`);

ALTER TABLE
    `communicationMembers`
ADD
    CONSTRAINT `communicationMembers_idfamilyMember_foreign` FOREIGN KEY(`idFamilyMember`) REFERENCES `familyMembers`(`id`);

ALTER TABLE
    `familyMemberEvents`
ADD
    CONSTRAINT `familymemberevents_idfamilymember_foreign` FOREIGN KEY(`idFamilyMember`) REFERENCES `familyMembers`(`id`);

ALTER TABLE
    `familyMemberEvents`
ADD
    CONSTRAINT `familymemberevents_idevent_foreign` FOREIGN KEY(`idEvent`) REFERENCES `events`(`id`);

ALTER TABLE
    `events`
ADD
    CONSTRAINT `events_idposttype_foreign` FOREIGN KEY(`idPostType`) REFERENCES `postTypes`(`id`);

ALTER TABLE
    `events`
ADD
    CONSTRAINT `events_idactivity_foreign` FOREIGN KEY(`idActivity`) REFERENCES `activities`(`id`);

ALTER TABLE
    `eventDocuments`
ADD
    CONSTRAINT `eventdocuments_iddocument_foreign` FOREIGN KEY(`idDocument`) REFERENCES `documents`(`id`);

ALTER TABLE
    `eventDocuments`
ADD
    CONSTRAINT `eventdocuments_idevent_foreign` FOREIGN KEY(`idEvent`) REFERENCES `events`(`id`);

-- ACTIVITIES
INSERT INTO
    activities (`name`, `category`, `abridged`)
VALUES
    ('Part’Ages', 'Famille - Parentalité', 'family'),
    (
        'Parents Thèmes',
        'Famille - Parentalité',
        'family'
    ),
    ('Pilates', 'Sport et bien-être', 'sport'),
    ('Gym Douce', 'Sport et bien-être', 'sport'),
    ('Gym Seniors', 'Sport et bien-être', 'sport'),
    ('Bien-Être Solo', 'Sport et bien-être', 'sport'),
    ('Bien-Être Duo', 'Sport et bien-être', 'sport'),
    (
        'Visites de Convivialité',
        'Prévention - Action sociale',
        'social'
    ),
    (
        'Rencontres L.I.S.E',
        'Sport et bien-être',
        'sport'
    ),
    (
        'Animations locales',
        'Animation locale',
        'animation'
    );

-- POST TYPES

INSERT INTO
    postTypes (`name`)
VALUES
    ('Activité'),
    ('Article'),
    ('Podcast');

-- EVENTS
INSERT INTO
    events (
        `numberParticipantsMax`,
        `date`,
        `description`,
        `text`,
        `podcastLink`,
        `reservedAdherent`,
        `price`,
        `idPostType`,
        `idActivity`
    )
VALUES
    (
        3,
        '12/12/12',
        '“Atelier à venir...” Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa',
        null,
        0,
        100,
        1,
        1
    ),
    (
        10,
        '01/01/22',
        'Les activités proposées vous permettent, parents et grands-parents, de partager un moment avec vos enfants et petits enfants de 0 à 12 ans',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa',
        null,
        0,
        1000,
        2,
        null
    ),
    (
        10,
        '12/04/10',
        'Moment convivial autour d’une activité partagée : découverte sensorielle, motricité, éveil musical, contes, activité manuelle, sortie nature',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa',
        null,
        1,
        1000,
        1,
        3
    ),
    (
        5,
        '12/12/12',
        'Vous pratiquerez des activités sportives dans une ambiance détendue et conviviale : pilates, gym douce, gym seniors',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa',
        null,
        1,
        500,
        3,
        null
    ),
    (
        25,
        '12/12/12',
        'Hello man',
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa Lorem ipsum dolor sit amet consectetur adipisicing elit. Non perferendis libero ipsa',
        null,
        1,
        50,
        1,
        8
    );

INSERT INTO 
    cities (
        `name`, 
        `zipCode`
        )
VALUES 
        ('ABZAC', 33230),
        ('ARVEYRES', 33500),
        ('BAYAS', 33230),
        ('BONZAC', 33910),
        ('CADARSAC', 33750),
        ('CAMPS SUR L’ISLE', 33660),
        ('CHAMADELLE', 33230),
        ('COUTRAS', 33230),
        ('DAIGNAC', 33420),
        ('DARDENAC', 33420),
        ('ESPIET', 33420),
        ("GÉNISSAC", 33420),
        ('GOUR', 33660),
        ('GUÎTRES', 33230),
        ('IZON', 33450),
        ('LAGORCE', 33230),
        ('LALANDE DE POMEROL', 33500),
        ('LAPOUYADE', 33620),
        ('LE FIEU', 33230),
        ('LES BILLAUX', 33500),
        ('LES EGLISOTTES ET CHALAURES', 33230),
        ('LES PEINTURES', 33230),
        ('LIBOURNE', 33500),
        ('MARANSIN', 33230),
        ('MOULON', 33420),
        ('NÉRIGEAN', 33750),
        ('POMEROL', 33500),
        ('PORCHÈRES', 33660),
        ('PUYNORMAND', 33660),
        ('SABLON', 33910),
        ('SAINT ANTOINE DE L’ISLE', 33660),
        ('SAINT CHRISTOPHE DE DOUBLE', 33230),
        ('SAINT CIERS D’ABZAC', 33910),
        ('SAINT DENIS DE PILE', 33910),
        ('SAINT GERMAIN DU PUCH', 33750),
        ('SAINT MARTIN DE LAYE', 33910),
        ('SAINT MARTIN DU BOIS', 33910),
        ('SAINT MEDARD DE GUIZIERES', 33230),
        ('SAINT QUENTIN DE BARON', 33750),
        ('SAINT SAUVEUR DE PUYNORMAND', 33660),
        ('SAINT SEURIN DE L’ISLE', 3660),
        ('SAVIGNAC DE L’ISLE', 33910),
        ('TIZAC DE CURTON', 33531),
        ('TIZAC DE LAPOUYADE', 33620),
        ('VAYRES', 33870),
        ('BOSSUGAN', 33350),
        ('BRANNE', 33420),
        ('CABARA', 33420),
        ('CASTILLON LA BATAILLE', 33350),
        ('CIVRAC-SUR-DORDOGNE', 33350),
        ('COUBEYRAC', 33890),
        ('DOULEZON', 33350),
        ('FLAUJAGUES', 33350),
        ('GENSAC', 33890),
        ("GRÉZILLAC", 33420),
        ('GUILLAC', 33420),
        ('JUGAZAN', 33420),
        ('JUILLAC', 33890),
        ('LES SALLES DE CASTILLON', 33350),
        ('LUGAIGNAC', 33420),
        ('MERIGNAS', 33350),
        ('MOULIETS ET VILLEMARTIN', 33350),
        ('NAUJAN ET POSTIAC', 33420),
        ('PESSAC SUR DORDOGNE', 33890),
        ('PUJOLS SUR DORDOGNE', 33350),
        ('RAUZAN', 33420),
        ('RUCH', 33350),
        ('SAINT AUBIN DE BRANNE', 33420),
        ('SAINTE COLOMBE', 33350),
        ('SAINTE FLORENCE', 33350),
        ('SAINT JEAN DE BLAIGNAC', 33420),
        ('SAINT MAGNE DE CASTILLON', 33350),
        ('SAINT MICHEL DE MONTAIGNE', 24230),
        ('SAINT PEY DE CASTETS', 33350),
        ('SAINTE RADEGONDE', 33350),
        ('SAINT VINCENT DE PERTIGNAS', 33420),
        ('BARON', 33750),
        ('BLESIGNAC', 33670),
        ('CAPIAN', 33550),
        ('CARDAN', 33410),
        ('CREON', 33670),
        ('CURSAN', 33670),
        ('HAUX', 33550),
        ('LA SAUVE MAJEUR', 33670),
        ('LE POUT', 33670),
        ('LOUPES', 33370),
        ('MADIRAC', 33670),
        ('SADIRAC', 33670),
        ('SAINT GENES DE LOMBAUD', 33670),
        ('SAINT LEION', 33670),
        ('VILLENAVE DE RIONS', 33550);

INSERT INTO recipients (
    `name`) VALUES (“CAF”), (”MSA”), (”None”);

INSERT INTO families (
    `name`,
    `streetNumber`,
    `address`,
    `phoneNumber`,
    `email`,
    `password`,
    `idCity`,
    `idRecipient`,
    `isActive`) VALUES (“Ducasse”, 123, “route des colonies”, 0636656565, “ducasse@gmail.com”, “password”, 1, 1, 1), (“Dupont”, 144, “route des montagne”, 0636655555, “dupont@gmail.com”, “cartable”, 2, 2, 1), ( “Doe”, 52, “Avenue des plages”, 0689145715, “doe@gmail.chine”, “rootroot”, 3, 3, 1);


INSERT INTO familyMembers (
    `idFamily`,
    `firstname`,
    `birthday`,
    `isActive`) VALUES (1, “Philipe”, 16/05/1978, 1),(1, “Maire”, 19/02/1976, 1),(1, “Kevin”, 24/12/1989,1),
     (2, "Gérard", 20/05/1976, 1),(2, “Yvette”, 02/09/1980, 1),(2, “Jeremy”, 24/12/2000,1),(3, "John", 20/05/1952, 1),(3, “Suzy”, 02/09/1960, 1),(3, “Eric”, 24/12/2008,1);


INSERT INTO paymentMethods (`name`) VALUES ("ESPÈCES"),("CHÈQUE"),("CARTE BANCAIRE");

INSERT INTO paymentRecords (
    `idPaymentMethod`,
    `numberCheck`,
    `isPaymentActivity`,
    `datePay`,
    `amountPay`,
    `idFamily`,
    `idFamilyMember`,
    `idActivity`) VALUES (2, 21654987312178554, 1, 25/06/2022, 40, 2, null, 3),(1, null, 1, 12/05/2021, 20, null, 2, 1),(3, null, 1, 10/12/2021, 10, 3, null, 5);


INSERT INTO documents (`name`,
    `url`) VALUES ("cadeaux","https://ibb.co/b16ss3J"),
                                ("enfantsPeintures","https://ibb.co/p36J9h0"),
                                ("anes","https://ibb.co/XZqbSKy"), 
                                ("enfantDécoupage","https://ibb.co/vQkN2sW"), 
                                ("réunion","https://ibb.co/fX9pq3r"), 
                                ("papiEnfants","https://ibb.co/GR3gTYx"), 
                                ("jeux","https://ibb.co/C0q8QPw"), 
                                ("pilate","https://ibb.co/QjnWG98"), 
                                ("gymDouce","https://ibb.co/MSfBWw7"), 
                                ("gym","https://ibb.co/0MQB832"
                            );

INSERT INTO eventDocuments (`idDocument`,
    `idEvent`) VALUES (1,1), (2,1), (3,1),(4,1), (5,2), (6,2), (7,3), (8,3),(7,4),(8,4),(9,5),(10,5);

INSERT INTO communications (`object`,
    `content`,
    `idAdmin`,
    `isBanner`)
    VALUES ('Informations', 'Lorem ipsum dolor sit amet consectetur adipisicing elit', 1, 1),
            ('Fermeture', 'Nous fermerons nos portes du 10 au 20/06', 2, 1),
            ('Atelier', 'Future Atelier parent - enfant', 1, 0);

INSERT INTO communicationMembers (`idFamilyMember`,
    `idCommunication`,
    `isOpened`) VALUES (1, 1, 1), (3, 2, 0), (2, 3, 1);
