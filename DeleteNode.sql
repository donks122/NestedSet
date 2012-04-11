-- Usage CALL DeleteNode(<PROMOTE|REPLACE>, <ID>) Deletes a given node
-- Can Call this in a loop using GetDecentents(<ID>) and delete the entire tree.


DROP PROCEDURE IF EXISTS DeleteNode;
DELIMITER go
CREATE PROCEDURE DeleteNode( IN mode CHAR(7), IN node INTEGER )
BEGIN
  DECLARE thisleft, thisright INTEGER DEFAULT 0;
  SELECT lft, rgt
    INTO thisleft, thisright
  FROM groups
  WHERE id = node;
  IF mode = 'PROMOTE' THEN
    BEGIN
      DELETE FROM users
      WHERE group_id = node;
      UPDATE router
        SET group_id = null
      WHERE group_id = node;
      DELETE FROM groups
      WHERE id = node;
      UPDATE groups
        SET lft = lft - 1, rgt = rgt - 1
      WHERE lft BETWEEN thisleft AND thisright;
      UPDATE groups
        SET rgt = rgt - 2
      WHERE rgt > thisright;
      UPDATE groups
        SET lft = lft - 2
      WHERE lft > thisright;
    END;
  ELSEIF mode = 'REPLACE' THEN
    BEGIN
      UPDATE groups
        SET lft = thisleft - 1, rgt = thisright
      WHERE lft = thisleft + 1;
      UPDATE groups
        SET rgt = rgt - 2
      WHERE rgt > thisleft;
      UPDATE groups
        SET lft = lft - 2
      WHERE lft > thisleft;
      DELETE FROM groups
      WHERE id = node;
    END;
  END IF;
END;
go
DELIMITER ;

