-- Usage CALL SubTree(<ID>) returns Tree Startinf grom a given parent id
DROP PROCEDURE IF EXISTS SubTree;
DELIMITER go
CREATE PROCEDURE SubTree( IN node INTEGER )
BEGIN
  select GetParentId(child.id), 
         child.id, 
         count(*),
         child.name 
  from groups as parent 
  join groups as child 
  on child.lft between parent.lft and parent.rgt 
  where parent.lft  > (select lft from groups where id = node) 
  and parent.rgt < (select rgt from groups where id = node) 
  group by child.id 
  order by child.lft;
END;
go
DELIMITER ;
