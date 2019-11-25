-- Em produção, você certamente limita o usuário de replicação que deve estar na follower (slave) machine,
-- para impedir que outros clientes acessem o log de outras máquinas. Por exemplo, 'replicator'@'follower.acme.com'.
--
-- No entanto, essa concessão é equivalente a especificar *any* hosts, o que facilita isso,
-- pois o host do docker não é facilmente conhecido pelo contêiner do Docker. Mas não faça isso na produção.

-- Garante que qualquer host pode se connectar como um replicador [nao fazer isso em prod, como explicado acima]
-- GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'replicator' IDENTIFIED BY 'replpass';
-- Define permissoes para usuario de replicacao
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT  ON *.* TO 'connector_user' IDENTIFIED BY 'connector_psw';

-- Cria o customerdb database que sera usado para verificarmos o efeito de leitura do binlog pelo debezium
CREATE DATABASE customerdb;
-- define as permissões para o usuario
-- ainda nao descobir como pegar o usuário definido no docker-compose de forma dinamica, por ora esta fixo
GRANT ALL PRIVILEGES ON customerdb.* TO 'mysqluser'@'%';

-- usar esse schema
USE customerdb;

-- Create some customers ...
CREATE TABLE customers (
  id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE KEY
) AUTO_INCREMENT=1001;