-- Criando o banco de dados
create database if not exists eightBits character set utf8mb4 collate utf8mb4_0900_ai_ci;
-- Definindo base de dados principal
use eightBits;
-- Criando tabela cliente
create table if not exists cliente (
cpf varchar(11) primary key not null,
email varchar(100) unique not null,
nome varchar(150) not null,
data_nascimento date not null,
sexo char(1) not null,
ativo boolean not null,
check (sexo in('M','F','m','f'))
);

-- Criando tabela produto
create table if not exists  produto (
id_produto int primary key not null auto_increment,
nome_produto varchar(100) not null,
categoria varchar(30) not null,
preco_produto double not null,
descricao_detalhada varchar(250) not null,
qtd_estoque int not null
);

-- Criando tabela endereço
create table if not exists endereco (
id_entrega int primary key not null auto_increment,
logradouro varchar(60) not null,
numero int not null,
bairro varchar(120) not null,
cidade varchar(120) not null,
estado char(2) not null,
pais varchar(50) not null,
fk_cpf_cliente varchar(11) not null,
foreign key (fk_cpf_cliente) references cliente (cpf)
);

-- criando tabela endereço_cliente
create table if not exists endereco_cliente (
fk_cpf_cliente VARCHAR(11) not null,
fk_entrega_endereco int not null,
foreign key (fk_cpf_cliente) references cliente (cpf),
foreign key (fk_entrega_endereco) references endereco (id_entrega)
);

-- Criando tabela cartão
create table if not exists cartao (
id_cartao int primary key not null auto_increment,
num_cartao varchar(16) unique not null,
data_valid date not null,
cod_seg int not null,
fk_cpf_cliente varchar(11) not null,
foreign key (fk_cpf_cliente) references cliente(cpf)
);


-- Criando tabela pedido
create table if not exists pedido (
id_pedido int primary key not null auto_increment,
data_pedido date not null,
fk_entrega_endereco int not null,
fk_cpf_cliente VARCHAR(11) not null,
foreign key (fk_cpf_cliente) references cliente (cpf),
foreign key (fk_entrega_endereco) references endereco (id_entrega)
);

-- Criando tabela pedido_produto
create table if not exists pedido_produto (
fk_id_produto int not null,
fk_id_pedido int not null,
quantidade int not null
);

-- Crianto tabela nota fiscal
create table if not exists nota_fiscal (
num_nf int primary key not null auto_increment,
data_nf date not null,
fk_pedido int not null unique,
foreign key (fk_pedido) references pedido (id_pedido)
);

-- creates index
create index cliente_nome on cliente (nome);
create index cliente_email on cliente (email);
create index produto_nome on produto(nome_produto);
create index produto_categoria on produto(categoria);
create index endereco_estado on endereco(estado);
create index endereco_pais on endereco(pais);
create index pedido_data on pedido(data_pedido);
create index pedido_produto_quantidade on pedido_produto(quantidade);
create index nota_fiscal_data on nota_fiscal(data_nf);

-- views
CREATE VIEW cartão_view AS SELECT id_cartao, cod_seg FROM cartao WHERE num_cartao;
CREATE VIEW cliente_view AS SELECT cpf, nome FROM cliente WHERE ativo;
CREATE VIEW endereco_view AS SELECT id_entrega, estado FROM endereco WHERE pais;
CREATE VIEW endereco_cliente_view AS SELECT fk_cpf_cliente, fk_entrega_endereco FROM endereco_cliente WHERE fk_cpf_cliente;
CREATE VIEW nota_fiscal_view AS SELECT num_nf, data_nf FROM nota_fiscal WHERE fk_pedido;
CREATE VIEW pedido_view AS SELECT id_pedido, data_pedido FROM pedido WHERE fk_cpf_cliente;
CREATE VIEW pedido_produto_view AS SELECT fk_id_produto, fk_id_pedido FROM pedido_produto WHERE quantidade;
CREATE VIEW produto_view AS SELECT id_produto, nome_produto FROM produto WHERE preco_produto;


-- inserindo dados na tabela cliente
insert into cliente(cpf, email, nome, data_nascimento, sexo, ativo) values (
'12345678900', 'aleatorio@ale.com', 'Xeros das Gaia da Silva', '2022-02-01', 'm', true),
(
'12345678901', 'aleatorio2@ale.com', 'Varus GKei Nordetino', '2022-02-02', 'f', true),
( 
'12345678902', 'aleatorio3@ale.com', 'Joselino Da Silva Pinto', '2022-02-03', 'm', true),
(
'12345678903', 'aleatorio4@ale.com', 'Givaldino Laskus De Marre', '2022-02-03', 'm', true),
(
'12345678905', 'aleatorio5@ale.com', 'Lascado Da Silva', '2022-02-05', 'm', true),
(
'12345678906', 'aleatorio6@ale.com', 'Wagner Loraine Santana Silva', '2022-02-06', 'f', true),
(
'12345678907', 'aleatorio7@ale.com', 'Tiririca Bomdepapo Da Silva', '2022-02-07', 'm', true),
(
'12345678908', 'aleatorio8@ale.com', 'Tirulipa Bomdepapo Silva Santos', '2022-02-08', 'm', true),
(
'12345678909', 'aleatorio9@ale.com', 'Valdivia Machado Pires', '2022-02-09', 'f', true),
(
'12345678910', 'aleatorio10@ale.com', 'Valeska ComK dos Santos', '2022-02-10', 'f', true),
(
'12345678911', 'aleatorio11@ale.com', 'Thaylohani Simiara Campus', '2022-02-11', 'f', true),
(
'12345678912', 'aleatorio12@ale.com', 'Tirana Rekissi Oliveira', '2022-02-12', 'f', true),
(
'12345678913', 'aleatorio13@ale.com', 'Ohaney Xuxa Lima', '2022-02-13', 'f', true),
(
'12345678914', 'aleatorio14@ale.com', 'Maria Antonia Haguro', '2022-02-14', 'f', true),
(
'12345678915', 'aleatorio15@ale.com', 'Xuxa Lima Cunha', '2022-02-15', 'f', true),
(
'12345678916', 'aleatorio16@ale.com', 'Gerivaldo Ferreira', '2022-02-16', 'm', true),
(
'12345678917', 'aleatorio17@ale.com', 'Batore Almeida', '2022-02-17', 'm', true),
(
'12345678918', 'aleatorio18@ale.com', 'Valdiskei Simiante', '2022-02-18', 'm', true),
(
'12345678919', 'aleatorio19@ale.com', 'Leonel Messinico Ferreira', '2022-02-19', 'm', true),
(
'12345678920', 'aleatorio20@ale.com', 'Ney de Costa', '2022-02-20', 'm', false);

-- para testar tabela cliente com os inserts
select * from cliente;


-- para acrescentar os produtos
insert into produto (nome_produto, categoria, preco_produto, descricao_detalhada, qtd_estoque) values ('SSD A400, Kingston, SA400S37/240G, Cinza', 'SSD', 219.90, 'Capacidade: 240 GB, Interface: SATA 6.0 Gb/s, Expectativa de vida útil: 1 milhão de horas, Formato: 7 mm',10),
('Processador AMD Ryzen 5 5600G, 3.9GHz (4.4GHz Max Turbo), AM4, Vídeo Integrado, 6 Núcleos', 'Processador', 1474.89, 'Velocidade da CPU: 3.9 GHz, Soquete da CPU: Socket AM4, cache: 19MB, formato: Atx',10),
('Placa-Mãe ASUS Prime - B450M Gaming/BR, AMD', 'Placa mãe', 509.90, 'AM4, mATX, DDR4',10),
('Placa de Vídeo Gainward - GeForce GTX 1660 Ti, 6GB GDDR6, GHOST Series', 'Placa de video', 2749.00, 'Tecnologia de processo: 12nm, Boost Clock: 1770 MHz, CUDA Núcleos: 1536, MAx. TPG: 120W, Quantidade de memória: 6 GB, Memoru Clock: 6000 MHZ, Tipo de memória: 192b GDDR6, Largura de banda da memória: 288 (GB / seg)',10),
('HD Seagate ST2000DM008 BarraCuda 2TB 3.5´ SATA III', 'HD', 372.58, 'Tamanho do disco rígido: 1 TB, Interface: SATA 6Gb/s - Taxa de transferência suportado SATA: 6.0 / 3.0 / 1.5 Gb/s',10),
('SSD M.2 2280 WD GREEN SN350 1TB NVME -WDS100T3G0C', 'SSD', 699.75, 'Tamanho do disco rígido: 1 TB, Velocidade de leitura: 3200 Megabytes Per Second, Velocidade de gravação: 2500 Megabytes Per Second',10),
('Gabinete Cooler Master MasterBox Q300L, M-ATX, Lateral em Acrílico Transparente', 'gabinete', 369.91, 'Cor: PRETO, Material: Acrílico, Método de refrigeração: Ventilação',10),
('Fonte Cooler Master Elite V3 Full Range 500W (sem cabo de força), PFC Ativo', 'Fonte', 303.00, 'Potência em watts: 500 watts, Formato: ATX',10),
('Cooler p/ processador cooler master hyper 212 spectrum - rr-212a-20pd-r1', 'Cooler para processador', 214.00, 'Dimensões do item C x L x A	16 x 10 x 23 centímetros, Nível de ruído: 15 dB',10),
('Ventoinha Pichau Gaming Feather 120mm Branco, Pgfea-white', 'Ventoinha', 26.00, 'Dimensões do item 120mm',10),
('HX426C16FB3/8 - Memória HyperX Fury de 8GB DIMM DDR4 2666Mhz 1,2V para desktop', 'Memoria', 292.00, 'Tamanho da memória do computador: 8 GB, Velocidade da memória: 2666 MHz, DDR4',10),
('Proint Core I3-9100F 3.60Ghz 6Mb Fclga1151, Intel', 'Processador', 901.00, 'Frequencia: 3.6Ghz, Cache: 6MB, Soquete: LGA1151',10),
('Placa-Mãe ASUS Prime - H310M-E R2.0/BR, Intel LGA 1151, mATX, DDR4', 'Placa mãe', 542.00, 'Soquete da CPU: LGA 1151, Velocidade do clock de memória: 2666 MHz, Tecnologia de memória RAM: DDR4',10),
('Intel Core I5-9400F Processador 9ª Geração, LGA 1151', 'Processador', 1099.00, 'Soquete da CPU: LGA 1151, Velocidade da CPU: 2.9 GHz, Cache 9MB, 6 Nucleos, 6 Threads',10),
('PLACA DE VIDEO NVIDIA GEFORCE GT 740 GDD5 4GB', 'Placa de video', 799.00, 'Chipset: GK107, Core clock:993 MHz, Energia da placa:64W',10),
('GIGABYTE HD SSD 256GB Aorus NVMe M.2 RGB - GP-ASM2NE2256GTTDR', 'SSD', 700.90, 'Capacidade: 256 GB, Leitura: 3100MB/s, Gravação: 1050MB/s',10),
('HD Purple DVR Western Digital 2TB 5400 RPM 64MB Cache SATA 6.0Gb/s', 'HD', 430.90, 'Capacidade: 2 TB, 64MB Cache, SATA 6.0Gb/s',10),
('Processador AMD Ryzen 7 5800X', 'processador', 2790.00, 'Cache 36MB, 3.8GHz (4.7GHz Max Turbo), AM4',10),
('WATER COOLER SANGUE FRIO 2 240MM ', 'water cooler', 410.90, 'Tensão: 7 Volts, Método de refrigeração: Água, TDP 250W',10),
('Processador AMD Ryzen 9 5900X', 'Processador', 3391.90, 'Cache 70MB, 3.7GHz (4.8GHz Max Turbo), AM4',10);

-- para testar tabela produtos com os inserts
select * from produto;

-- para acrescentar os edereços
insert into endereco (logradouro, numero, bairro, cidade, estado, pais, 
fk_cpf_cliente) values ('Rua João de Deus', 1, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678900'),
 ('Rua João de Deus', 2, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678901'),
 ('Rua João de Deus', 3, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678902'),
 ('Rua João de Deus', 4, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678903'),
 ('Rua João de Deus', 5, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678905'),
 ('Rua João de Deus', 6, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678906'),
 ('Rua João de Deus', 7, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678907'),
 ('Rua João de Deus', 8, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678908'),
 ('Rua João de Deus', 9, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678909'),
 ('Rua João de Deus', 10, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678910'),
 ('Rua João de Deus', 11, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678911'),
 ('Rua João de Deus', 12, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678912'),
 ('Rua João de Deus', 13, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678913'),
 ('Rua João de Deus', 14, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678914'),
 ('Rua João de Deus', 15, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678915'),
 ('Rua João de Deus', 16, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678916'),
 ('Rua João de Deus', 17, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678917'),
 ('Rua João de Deus', 18, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678918'),
 ('Rua João de Deus', 19, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678919'),
 ('Rua João de Deus', 20, 'Brasilite', 'Recife', 'PE', 'Brasil', '12345678920');

-- para verificar a tabela de endereços
select * from endereco;

-- para acrescentar a tabela endereco_cliente
insert into endereco_cliente (fk_cpf_cliente ,fk_entrega_endereco) values 
('12345678900', 1),
('12345678901', 2),
('12345678902', 3),
('12345678903', 4),
('12345678905', 5),
('12345678906', 6),
('12345678907', 7),
('12345678908', 8),
('12345678909', 9),
('12345678910', 10),
('12345678911', 11),
('12345678912', 12),
('12345678913', 13),
('12345678914', 14),
('12345678915', 15),
('12345678916', 16),
('12345678917', 17),
('12345678918', 18),
('12345678919', 19),
('12345678920', 20);

-- para verificar a tabela endereco_cliente
select * from endereco_cliente;

-- para acrescentar a tabela cartão
insert into cartao (num_cartao, data_valid, cod_seg, fk_cpf_cliente) values 
('1234567890123400', '2022-04-01', 101, '12345678900'),
('1234567890123401', '2022-04-01', 101, '12345678901'),
('1234567890123402', '2022-04-02', 102, '12345678902'),
('1234567890123403', '2022-04-03', 103, '12345678903'),
('1234567890123405', '2022-04-05', 105, '12345678905'),
('1234567890123406', '2022-04-06', 106, '12345678906'),
('1234567890123407', '2022-04-07', 107, '12345678907'),
('1234567890123408', '2022-04-08', 108, '12345678908'),
('1234567890123409', '2022-04-09', 109, '12345678909'),
('1234567890123410', '2022-04-10', 110, '12345678910'),
('1234567890123411', '2022-04-11', 111, '12345678911'),
('1234567890123412', '2022-04-12', 112, '12345678912'),
('1234567890123413', '2022-04-13', 113, '12345678913'),
('1234567890123414', '2022-04-14', 114, '12345678914'),
('1234567890123415', '2022-04-15', 115, '12345678915'),
('1234567890123416', '2022-04-16', 116, '12345678916'),
('1234567890123417', '2022-04-17', 117, '12345678917'),
('1234567890123418', '2022-04-18', 118, '12345678918'),
('1234567890123419', '2022-04-19', 119, '12345678919'),
('1234567890123420', '2022-04-19', 120, '12345678920');

-- para verificar a tabela de cartão
select * from cartao;

-- para acrescentar a tabela pedido
insert into pedido (data_pedido,fk_cpf_cliente ,fk_entrega_endereco) values 
('2022-02-21','12345678900', 1),
('2022-11-20','12345678901', 2),
('2022-12-17','12345678902', 3),
('2022-02-20','12345678903', 4),
('2022-05-19','12345678905', 5),
('2022-06-19','12345678906', 6),
('2022-04-16','12345678907', 7),
('2022-01-13','12345678908', 8),
('2022-09-25','12345678909', 9),
('2022-10-28','12345678910', 10),
('2022-12-26','12345678911', 11),
('2022-03-21','12345678912', 12),
('2022-09-07','12345678913', 13),
('2022-07-05','12345678914', 14),
('2022-03-31','12345678915', 15),
('2022-04-30','12345678916', 16),
('2022-02-12','12345678917', 17),
('2022-08-09','12345678918', 18),
('2022-06-06','12345678919', 19),
('2022-04-13','12345678920', 20);

-- para verificar a tabela de pedido
select * from pedido;

-- para acrescentar a tabela pedido_produto
insert into pedido_produto (fk_id_pedido, fk_id_produto, quantidade) values
(1,1,1),
(2,2,1),
(3,3,1),
(4,4,1),
(5,5,1),
(6,6,1),
(7,7,1),
(8,8,1),
(9,9,1),
(10,10,1),
(11,11,1),
(12,12,1),
(13,13,1),
(14,14,1),
(15,15,1),
(16,16,1),
(17,17,1),
(18,18,1),
(19,19,1),
(20,20,1);

-- para verificar a tabela de pedido_produto
select * from pedido_produto;

-- para acrescentar a tabela nota_fiscal
insert into nota_fiscal (data_nf, fk_pedido) value 
( current_date(), 1),
( current_date(), 2),
( current_date(), 3),
( current_date(), 4),
( current_date(), 5),
( current_date(), 6),
( current_date(), 7),
( current_date(), 8),
( current_date(), 9),
( current_date(), 10),
( current_date(), 11),
( current_date(), 12),
( current_date(), 13),
( current_date(), 14),
( current_date(), 15),
( current_date(), 16),
( current_date(), 17),
( current_date(), 18),
( current_date(), 19),
( current_date(), 20);

-- para verificar a tabela de nota_fiscal
select * from nota_fiscal;

-- cliente update
update cliente set nome = 'Mago Lindiu Do Santius' where cpf = '12345678900';
update cliente set email = 'magolindiyu@totozo.com' where cpf = '12345678900';
-- produto update
update produto set nome_produto = 'M2 green' where id_produto = '1';
update produto set qtd_estoque = '0' where id_produto = '1';
-- endereço update
update endereco  set numero = '5' where id_entrega = '1';
update endereco set bairro = 'Magus Das cavernas' where id_entrega = '1';
-- cartao update
update cartao set num_cartao = '1234567891234567' where id_cartao = '1';
update cartao set cod_seg = '049' where id_cartao = '1';
-- pedido update
update pedido set data_pedido = current_date() where id_pedido = '1';
update pedido set data_pedido = current_date() where id_pedido = '2';
-- nota fiscal update
update nota_fiscal set data_nf = '2022-04-30' where num_nf = '1';
update nota_fiscal set data_nf = '2022-04-20' where num_nf = '2';

-- delete cliente
DELETE FROM cliente WHERE ativo = 0;
DELETE FROM cliente WHERE sexo = "F";
DELETE FROM cliente WHERE cpf = "12345678900";
-- delete produto
DELETE FROM produto WHERE qtd_estoque > 450;
DELETE FROM produto WHERE id_produto = 4;
DELETE FROM produto WHERE categoria = 'Processador';
-- delete endereco
DELETE FROM endereco WHERE id_entrega = 1;
DELETE FROM endereco WHERE numero = 5;
DELETE FROM endereco WHERE fk_cpf_cliente = '12345678901';
-- delete endereco_cliente
DELETE FROM endereco_cliente WHERE fk_cpf_cliente = '12345678901';
DELETE FROM endereco_cliente WHERE fk_entrega_endereco = 3;
DELETE FROM endereco_cliente WHERE fk_entrega_endereco = 10;
-- delete cartao
DELETE FROM cartao WHERE id_cartao = 1;
DELETE FROM cartao WHERE cod_seg = 120;
DELETE FROM cartao WHERE data_valid = '2022-04-05';
-- delete pedido
DELETE FROM pedido WHERE id_pedido = 1;
DELETE FROM pedido WHERE fk_entrega_endereco = 5;
DELETE FROM pedido WHERE fk_cpf_cliente = '12345678918';
-- delete pedido_produto
DELETE FROM pedido_produto WHERE fk_id_pedido = 4;
DELETE FROM pedido_produto WHERE fk_id_produto = 5;
DELETE FROM pedido_produto WHERE quantidade = 1;
-- delete nota_fiscal
DELETE FROM nota_fiscal WHERE num_nf = 3;
DELETE FROM nota_fiscal WHERE fk_pedido = 5;
DELETE FROM nota_fiscal WHERE data_nf = '2022-05-02';


-- transacionais
select * from cliente where sexo = 'm';
select * from cliente where sexo = 'f';
select fk_pedido from nota_fiscal;
select data_nf from nota_fiscal;
select num_nf from nota_fiscal;
select email from cliente;
select pais, estado, cidade, bairro, logradouro, numero from endereco;
select data_pedido from pedido;
select estado from endereco;
select cpf from cliente;
SELECT * from cliente as Nomes order by nome asc;
select * from produto where categoria like 'Processador';
select * from produto where categoria not like 'ssd';
select * from produto;
select * from pedido;
select * from nota_fiscal;
select qtd_estoque from produto;
select preco_produto from produto;


-- gerenciais 
select sum(qtd_estoque) from produto where categoria = 'Processador';
SELECT data_pedido FROM pedido WHERE MONTH(data_pedido) = 04;
select count(cidade) from endereco where cidade = 'Recife';
select count(quantidade) from pedido_produto where fk_id_produto = 10;
select count(id_pedido) from pedido;
select count(fk_cpf_cliente) from pedido where fk_cpf_cliente = '12345678900';
select count(cpf) from cliente;
select count(sexo) from cliente where sexo = 'M';
select count(sexo) from cliente where sexo = 'F';
select sum(preco_produto) from produto;
select count(estado) from endereco where estado = 'PE';
select count(id_cartao) from cartao;
select max(preco_produto) from produto;
select min(preco_produto) from produto;
select count(ativo) from cliente where ativo = '1';
select count(ativo) from cliente where ativo = '0';
select count(nome_produto) from produto where nome_produto = 'Processador AMD Ryzen 9 5900X' ;
select sum(qtd_estoque) from produto;
SELECT COUNT(*) FROM nota_fiscal WHERE MONTH(data_nf) = 05;
SELECT cpf, id_pedido FROM pedido INNER JOIN cliente ON (cliente.cpf = pedido.fk_cpf_cliente);
SELECT cpf FROM cliente INNER JOIN pedido ON (pedido.fk_cpf_cliente = cliente.cpf) ORDER BY cpf ASC LIMIT 5;
select count(cod_seg) from cartao;
select count(pais) from endereco;
select count(bairro) from endereco;



select count(cpf) as qtdCliente from cliente;
SELECT max(preco_produto) as maiorValorProduto FROM produto;
SELECT min(preco_produto) as menorValorProduto FROM produto;
SELECT avg(preco_produto) as mediaValorProduto FROM produto;
SELECT sum(preco_produto) as somaValorProdutos FROM produto;
select nome,email from cliente group by cpf; 
select distinct logradouro from endereco; 
select nome, email, cpf from cliente where sexo in ('f','F') order by nome;
select nome, email, cpf from cliente where sexo not in ('f','F') order by nome;
select nome, email, sexo from cliente where cpf is null; -- não há retorno, pois não há campo na tabela sendo null
select nome, email, sexo from cliente where cpf is not null;
SELECT * FROM cliente as c JOIN pedido as p ON c.cpf = p.fk_cpf_cliente;

-- verificando endereço do cliente em tabelas diferente INNER JOIN, LEFT JOIN, RIGHT JOIN
select * from endereco inner join cliente on endereco.fk_cpf_cliente = cliente.cpf;
select * from endereco left join cliente on endereco.fk_cpf_cliente = cliente.cpf;
select * from endereco right join cliente on endereco.fk_cpf_cliente = cliente.cpf;
SELECT COUNT(ativo), nome FROM cliente GROUP BY nome HAVING COUNT(ativo) > 5;




