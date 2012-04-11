-- Usage CALL GetDecendents(<ID>) returns All decentents for a given node

DROP PROCEDURE IF EXISTS GetDecendents;
DELIMITER go
CREATE PROCEDURE GetDecendents( IN root INTEGER )
BEGIN
  SELECT child.id FROM groups AS parent
    JOIN groups AS child ON child.lft BETWEEN parent.lft AND parent.rgt
  WHERE parent.lft > (SELECT lft FROM groups WHERE id = root)
    AND parent.rgt < (SELECT rgt FROM groups WHERE id = root)
  GROUP BY child.id;
END;
go
DELIMITER ;
