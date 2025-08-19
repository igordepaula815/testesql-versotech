-- ==============================
-- 1️⃣ Criação das Tabelas
-- ==============================
CREATE TABLE EMPRESA (
    ID_EMPRESA SERIAL PRIMARY KEY,
    RAZAO_SOCIAL VARCHAR(255) NOT NULL,
    INATIVO BOOLEAN DEFAULT FALSE
);

CREATE TABLE PRODUTOS (
    ID_PRODUTO SERIAL PRIMARY KEY,
    DESCRICAO VARCHAR(255) NOT NULL,
    INATIVO BOOLEAN DEFAULT FALSE
);

CREATE TABLE VENDEDORES (
    ID_VENDEDOR SERIAL PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL,
    CARGO VARCHAR(255),
    SALARIO DECIMAL(10, 2),
    DATA_ADMISSAO DATE,
    INATIVO BOOLEAN DEFAULT FALSE
);

CREATE TABLE CONFIG_PRECO_PRODUTO (
    ID_CONFIG_PRECO_PRODUTO SERIAL PRIMARY KEY,
    ID_VENDEDOR INT REFERENCES VENDEDORES(ID_VENDEDOR),
    ID_EMPRESA INT REFERENCES EMPRESA(ID_EMPRESA),
    ID_PRODUTO INT REFERENCES PRODUTOS(ID_PRODUTO),
    PRECO_MINIMO DECIMAL(10, 2) NOT NULL,
    PRECO_MAXIMO DECIMAL(10, 2) NOT NULL
);

CREATE TABLE CLIENTES (
    ID_CLIENTE SERIAL PRIMARY KEY,
    RAZAO_SOCIAL VARCHAR(255) NOT NULL,
    DATA_CADASTRO DATE NOT NULL,
    ID_VENDEDOR INT REFERENCES VENDEDORES(ID_VENDEDOR),
    ID_EMPRESA INT REFERENCES EMPRESA(ID_EMPRESA),
    INATIVO BOOLEAN DEFAULT FALSE
);

CREATE TABLE PEDIDO (
    ID_PEDIDO SERIAL PRIMARY KEY,
    ID_EMPRESA INT REFERENCES EMPRESA(ID_EMPRESA),
    ID_CLIENTE INT REFERENCES CLIENTES(ID_CLIENTE),
    VALOR_TOTAL DECIMAL(10, 2) NOT NULL,
    DATA_EMISSAO DATE NOT NULL,
    DATA_FATURAMENTO DATE,
    DATA_CANCELAMENTO DATE
);

CREATE TABLE ITENS_PEDIDO (
    ID_ITEM_PEDIDO SERIAL PRIMARY KEY,
    ID_PEDIDO INT REFERENCES PEDIDO(ID_PEDIDO),
    ID_PRODUTO INT REFERENCES PRODUTOS(ID_PRODUTO),
    PRECO_PRATICADO DECIMAL(10, 2) NOT NULL,
    QUANTIDADE INT NOT NULL
);

-- ==============================
-- 2️⃣ Inserção de Dados
-- ==============================
INSERT INTO EMPRESA (razao_social, inativo) VALUES
('Empresa A', FALSE),
('Empresa B', FALSE),
('Empresa C', TRUE),
('Empresa D', FALSE),
('Empresa E', TRUE);

INSERT INTO PRODUTOS (id_produto, descricao, inativo) VALUES
(1, 'Produto 1', FALSE),
(2, 'Produto 2', FALSE),
(3, 'Produto 3', TRUE),
(4, 'Produto 4', FALSE),
(5, 'Produto 5', TRUE);

INSERT INTO VENDEDORES (id_vendedor, nome, cargo, salario, data_admissao, inativo) VALUES
(1, 'Vendedor Z', 'Cargo A', 3000.00, '2023-01-10', FALSE),
(2, 'Vendedor B', 'Cargo B', 4000.00, '2023-02-15', FALSE),
(3, 'Vendedor C', 'Cargo C', 3500.00, '2023-03-20', TRUE),
(4, 'Vendedor D', 'Cargo D', 3800.00, '2023-04-25', FALSE),
(5, 'Vendedor E', 'Cargo E', 4200.00, '2023-05-30', TRUE);

INSERT INTO CONFIG_PRECO_PRODUTO (id_vendedor, id_empresa, id_produto, preco_minimo, preco_maximo) VALUES
(1, 1, 1, 10.00, 20.00),
(2, 2, 2, 15.00, 25.00),
(3, 3, 3, 12.00, 22.00),
(4, 4, 4, 18.00, 28.00),
(5, 5, 5, 20.00, 30.00);

INSERT INTO CLIENTES (id_cliente, razao_social, data_cadastro, id_vendedor, id_empresa, inativo) VALUES
(1, 'Cliente A', '2023-06-01', 1, 1, FALSE),
(2, 'Cliente B', '2023-06-05', 2, 2, FALSE),
(3, 'Cliente C', '2023-06-10', 3, 3, TRUE),
(4, 'Cliente D', '2023-06-15', 4, 4, FALSE),
(5, 'Cliente E', '2023-06-20', 5, 5, TRUE);

INSERT INTO PEDIDO (id_pedido, id_empresa, id_cliente, valor_total, data_emissao, data_faturamento, data_cancelamento) VALUES
(1, 1, 1, 120.00, '2023-07-06', NULL, NULL),
(2, 1, 1, 130.00, '2023-07-07', NULL, NULL),
(3, 2, 2, 170.00, '2023-07-08', '2023-07-09', NULL),
(4, 2, 2, 180.00, '2023-07-09', '2023-07-10', '2023-07-11'),
(5, 3, 3, 210.00, '2023-07-10', NULL, NULL),
(6, 3, 3, 220.00, '2023-07-11', '2023-07-11', NULL),
(7, 4, 4, 260.00, '2023-07-12', '2023-07-12', '2023-07-13'),
(8, 4, 4, 270.00, '2023-07-13', '2023-07-14', NULL);

INSERT INTO ITENS_PEDIDO (id_pedido, id_produto, preco_praticado, quantidade) VALUES
(1, 1, 10.00, 5),
(1, 2, 15.00, 2),
(2, 2, 15.00, 6),
(2, 3, 20.00, 3),
(3, 1, 20.00, 7),
(3, 2, 25.00, 4),
(3, 3, 27.00, 4),
(4, 4, 25.00, 8),
(4, 5, 30.00, 5);

-- ==============================
-- 3️⃣ Consulta de Vendedores Ativos
-- ==============================
-- Resultado esperado: id, nome, salario dos vendedores ativos em ordem ascendente pelo nome
SELECT id_vendedor AS id, nome, salario
FROM vendedores
WHERE inativo = FALSE
ORDER BY nome ASC;

-- ==============================
-- 4️⃣ Funcionários com Salário Acima da Média
-- ==============================
-- Resultado esperado: id, nome, salario dos funcionários com salário acima da média, ordenados por salario desc
SELECT id_vendedor AS id, nome, salario
FROM vendedores
WHERE salario > (SELECT AVG(salario) FROM vendedores)
ORDER BY salario DESC;

-- ==============================
-- 5️⃣ Resumo por Cliente
-- ==============================
-- Resultado esperado: id, razao_social, total de pedidos já transmitidos, ordenado por total desc
SELECT c.id_cliente AS id,
       c.razao_social,
       COALESCE(SUM(p.valor_total), 0) AS total
FROM clientes c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.razao_social
ORDER BY total DESC;

-- ==============================
-- 6️⃣ Situação por Pedido
-- ==============================
-- Resultado esperado: id, valor, data, situacao (CANCELADO, FATURADO, PENDENTE)
SELECT id_pedido AS id,
       valor_total AS valor,
       data_emissao AS data,
       CASE 
           WHEN data_cancelamento IS NOT NULL THEN 'CANCELADO'
           WHEN data_faturamento IS NOT NULL THEN 'FATURADO'
           ELSE 'PENDENTE'
       END AS situacao
FROM pedido
ORDER BY id_pedido;

-- ==============================
-- 7️⃣ Produto Mais Vendido
-- ==============================
-- Resultado esperado: id_produto, quantidade_vendida, total_vendido, pedidos, clientes
WITH produto_stats AS (
    SELECT i.id_produto,
           SUM(i.quantidade) AS quantidade_vendida,
           SUM(i.quantidade * i.preco_praticado) AS total_vendido,
           COUNT(DISTINCT i.id_pedido) AS pedidos,
           COUNT(DISTINCT p.id_cliente) AS clientes
    FROM itens_pedido i
    JOIN pedido p ON i.id_pedido = p.id_pedido
    GROUP BY i.id_produto
)
SELECT *
FROM produto_stats
ORDER BY quantidade_vendida DESC, total_vendido DESC
LIMIT 1;
