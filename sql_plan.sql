select * from table(dbms_xplan.display_cursor('&1',null,'advanced -outline'));