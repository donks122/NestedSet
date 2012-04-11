-- Usage: CALL Fultree() Returns Complete Nested Set tree
DROP PROCEDURE IF EXISTS FullTree;
DELIMITER go
CREATE PROCEDURE FullTree()
BEGIN
  select GetParentId(child.id), 
         child.id , 
         count(*),
         child.name 
  from groups as parent 
  join groups as child 
  on child.lft between parent.lft and parent.rgt 
  group by child.id 
  order by child.lft;
END;
go
DELIMITER ;

