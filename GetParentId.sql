-- Usage : CALL GetParentId(<ID>) "Returns the Immidiate parent of a given Node" 

DROP FUNCTION IF EXISTS GetParentId;
DELIMITER go
CREATE FUNCTION GetParentId( node INTEGER )
RETURNS INTEGER
READS SQL DATA
BEGIN
  DECLARE level, thisleft, thisright, pid INTEGER DEFAULT 0;
  SELECT lft, rgt
    INTO thisleft, thisright
  FROM groups
  WHERE id = node;
  SELECT COUNT(n1.id)
    INTO level
  FROM groups AS n1
    INNER JOIN groups AS n2
    ON n2.lft BETWEEN n1.lft AND n1.rgt
  WHERE n2.id = node
  GROUP BY n2.id;
  SELECT
    n2.id INTO pid
  FROM groups AS n1
    INNER JOIN groups AS n2
    ON n2.lft BETWEEN n1.lft AND n1.rgt
  WHERE n2.lft < thisleft AND n2.rgt > thisright
  GROUP BY n2.id
  HAVING COUNT(n1.id)=level-1;
  RETURN pid;
END;
go
DELIMITER ;

