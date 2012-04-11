-- Table to hold the nested set.
CREATE TABLE `groups` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `lft` int(11) NOT NULL,
      `rgt` int(11) NOT NULL,
      `name` text NOT NULL,
      `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Initialize REQUIRED

INSERT INTO `groups` VALUES (1,1,1,'Root',now());

CREATE TABLE `tmpgrp` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `lft` int(11) NOT NULL,
      `rgt` int(11) NOT NULL,
      `name` text NOT NULL,
      `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


