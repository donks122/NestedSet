-- Usage: CALL MoveNode(<OLDPARENT>, <NEWPARENT>) Moves the entire node with its subtree to a new parent
-- REQUIRES a temp table exact copy of groups table;

DROP PROCEDURE IF EXISTS MoveNode;
DELIMITER go
CREATE PROCEDURE MoveNode( IN oid INTEGER, IN nid INTEGER )
BEGIN
    SELECT @myLeft := lft, @myRight := rgt, @myWidth := rgt - lft + 1, @catId := id
    FROM groups
    WHERE id = oid;
    SELECT @insRgt := rgt  FROM groups WHERE id = nid;
    SELECT @step := @insRgt - @myLeft + 1;
    INSERT tmpgrp
    SELECT * FROM groups
    WHERE lft >= @myLeft AND lft <= @myRight;
    UPDATE tmpgrp
    SET lft = lft + @step,
    rgt = rgt + @step,
    id = -id;
    UPDATE groups SET lft = lft + @myWidth WHERE lft > @insRgt;
    UPDATE groups SET rgt = rgt + @myWidth WHERE rgt > @insRgt;
    INSERT groups
    SELECT * FROM tmpgrp;
    SELECT @myLeft := lft, @myRight := rgt, @myWidth := rgt - lft + 1
    FROM groups
    WHERE id = @catId;
    DELETE FROM groups WHERE lft BETWEEN @myLeft AND @myRight;
    UPDATE groups SET rgt = rgt - @myWidth WHERE rgt > @myRight;
    UPDATE groups SET lft = lft - @myWidth WHERE lft > @myRight;
    UPDATE groups SET id = -id WHERE id < 0;
    SELECT @setRgt := rgt from groups where id = oid;
    update groups set lft = lft + 1  where lft > @setRgt;
    update groups set rgt = rgt + 1  where rgt > @setRgt;
    UPDATE groups set rgt = @setRgt + 1 where id = nid;
    DELETE FROM tmpgrp;
END
go
DELIMITER ;

