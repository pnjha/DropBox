with cte(FOLDERID, FULLPATH, RECLEVEL) as (
select C.FOLDERID, cast(C.FOLDERNAME as TEXT) as FULLPATH, 0 as RECLEVEL from 
FOLDER C where C.P_FOLDERID IS NULL 
UNION ALL
select C1.FOLDERID, CAST((C.FULLPATH || '/' || C1.FOLDERNAME) AS TEXT) as FULLPATH, C.RECLEVEL + 1 as RECLEVEL 
from FOLDER C1 inner join cte C on C1.P_FOLDERID = C.FOLDERID
)
select FULLPATH from cte where FOLDERID in (select P_FOLDERID from file where FILEID=2);

with cte(FOLDERID, RECLEVEL) as (
select C.FOLDERID, 0 as RECLEVEL from FOLDER C where C.P_FOLDERID IS NULL 
UNION ALL
select C1.FOLDERID, C.RECLEVEL + 1 as RECLEVEL 
from FOLDER C1 inner join cte C on C1.P_FOLDERID = C.FOLDERID)
select * from cte;