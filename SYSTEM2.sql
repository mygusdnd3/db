create user hello identified by hello account unlock;

grant connect, resource, select any table to hello;

 SELECT * FROM ALL_USERS;