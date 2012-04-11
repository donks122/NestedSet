--Usage CALL InsertNode(<PARENTID>, <LABEL>) Inserts a new node under a given parent

DROP PROCEDURE IF EXISTS InsertNode;
DELIMITER go
CREATE PROCEDURE InsertNode( IN parent INTEGER, IN label TEXT )
BEGIN
  DECLARE parentleft, parentright, groupid INTEGER DEFAULT 0;
  SET groupid:= (SELECT MAX(id) FROM groups);
  SELECT lft, rgt
    INTO parentleft, parentright
  FROM groups
  WHERE id = parent;
  IF FOUND_ROWS() = 1 THEN
    BEGIN
      UPDATE groups
        SET rgt = rgt + 2
      WHERE rgt > parentleft;
      UPDATE groups
        SET lft = lft + 2
      WHERE lft > parentleft;
      INSERT INTO groups
        VALUES ( groupid + 1, parentleft + 1, parentleft + 2, label, now() );
    END;
  END IF;
END;
go
DELIMITER ;

