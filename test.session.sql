use mtaservver;
create table vehicles(
    id int auto_increment,
    model int not null,
    x real not null,
    y real not null,
    z real not null,
    primary key(id)
) engine = InnoDB default charset = utf8mb4;