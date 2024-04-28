CREATE USER 'alpha'@'%' IDENTIFIED BY 'alpha_password'; -- Remplacez 'alpha_password' par un mot de passe sécurisé
CREATE DATABASE alpha_db;
GRANT ALL PRIVILEGES ON alpha_db.* TO 'alpha'@'%';

CREATE USER 'beta'@'%' IDENTIFIED BY 'beta_password'; -- Remplacez 'beta_password' par un mot de passe sécurisé
CREATE DATABASE beta_db;
GRANT ALL PRIVILEGES ON beta_db.* TO 'beta'@'%';

FLUSH PRIVILEGES;