ttitle center 'Library cache lock holders/waiters' skip 2

column sid 		format 999999
column serial 		format 9999
column username 	format a10
column module 		format a15
column obj_owner 	format a10
column obj_name 	format a22
column state 		format a8
column secs 		format 999
select
 distinct
    ses.ksusenum as sid, ses.ksuseser serial, ses.ksuudlna username,KSUSEMNM module
   , ob.kglnaown obj_owner, ob.kglnaobj obj_name
   , lk.kgllkcnt lck_cnt, lk.kgllkmod lock_mode, lk.kgllkreq lock_req
   , w.state, w.event, w.wait_Time wtime, w.seconds_in_Wait secs
 from
  sys.x$kgllk lk,  sys.x$kglob ob,sys.x$ksuse ses
  , v$session_wait w
where lk.kgllkhdl in (select kgllkhdl from sys.x$kgllk where kgllkreq >0 )
and ob.kglhdadr = lk.kgllkhdl
and lk.kgllkuse = ses.addr
and w.sid = ses.indx
order by seconds_in_wait desc
/
ttitle off
