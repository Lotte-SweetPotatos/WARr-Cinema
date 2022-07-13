create table member(
                       id bigint auto_increment primary key,
                       userId varchar(100) not null,
                       userName varchar(100) not null,
                       password varchar(100) not null,
                       email varchar(100) not null
);

create table movie(
                      id bigint auto_increment primary key,
                      title varchar(100) not null,
                      content varchar(4000) not null,
                      grade decimal(8,2) not null,
                      genre varchar(100) not null,
                      director varchar(100) not null,
                      runningTime int not null,
                      openingDate varchar(100) not null,
                      poster varchar(1000) not null,
                      percent decimal(8,2) not null
);

create table running (
                         id bigint auto_increment primary key,
                         movie_id bigint not null,
                         reserveStartTime varchar(100) not null,
                         reserveEndTime varchar(100) not null,
                         runningTime int not null,
                         runningDate varchar(100) not null,
                         cineName varchar(100) not null,
                         totalSeat int not null,
                         curSeat int not null
);

create table reservation(
                            id bigint auto_increment primary key,
                            member_id bigint not null,
                            running_id bigint not null,
                            movie_id bigint not null
);



alter table running
    add
        foreign key(movie_id)
            references movie(id);

alter table reservation
    add
        foreign key(member_id)
            references member(id);

alter table reservation
    add
        foreign key(running_id)
            references running(id);

alter table reservation
    add
        foreign key(movie_id)
            references movie(id);
