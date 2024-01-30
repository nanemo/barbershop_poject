create database barbershop_project;

create table if not exists info
(
    info_id  bytea,
    about_ud text,
    contact  varchar,
    activity text
);

create table users
(
    user_id         serial primary key generated by default as identity,
    name            varchar(50)             not null,
    surname         VARCHAR(50)             not null,
    birthdate       DATE                    not null,
    gender          gender                  not null,
    phone_number_id serial                  not null,
    password        varchar(250)            not null,
    email           email unique,
    user_role       user_role               not null,
    is_barber       boolean   default false not null,
    created_at      timestamp default CURRENT_TIMESTAMP,
    updated_at      timestamp default CURRENT_TIMESTAMP,
    constraint users_ibfk_2 foreign key (phone_number_id) references phone_numbers (phone_number_id) on update cascade
);

create extension if not exists citext;

create domain email AS citext
    check ( value ~
            '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' );

create type gender as enum ('male', 'female');

create type user_role as enum ('user', 'admin', 'moderator', 'guest');

create table user_favorite_barber_shops
(
    users_id       SERIAL REFERENCES users (user_id),
    barber_shop_id SERIAL REFERENCES barber_shops (barber_shop_id),
    PRIMARY KEY (users_id, barber_shop_id)
);

-- TODO check the instruction again.
create table if not exists barbers
(
    barber_id serial primary key generated by default as identity,
    user_id   serial references users (user_id) CHECK ( )
);

create table barber_shops
(
    barber_shop_id SERIAL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY
);

create table phone_numbers
(
    phone_number_id        SERIAL PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    national_operator_code BYTEA,
    phone_number           numeric(7, 0)
);

create table category_of_services
(
    category_of_service_id   serial primary key generated by default as identity,
    category_name varchar(50) not null
);

create table services
(
    service_id serial primary key generated by default as identity,
    category_id serial references category_of_services(category_of_service_id) not null
)
