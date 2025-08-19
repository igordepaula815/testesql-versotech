# Teste Técnico de SQL

Este repositório contém a solução do **Teste Técnico de Conhecimentos em SQL**, incluindo:

- Criação das tabelas.
- Inserção dos dados fornecidos.
- Queries para cada um dos cinco desafios do teste.

---

## 1️⃣ Criação das Tabelas

As tabelas criadas são:

- `EMPRESA`
- `PRODUTOS`
- `VENDEDORES`
- `CONFIG_PRECO_PRODUTO`
- `CLIENTES`
- `PEDIDO`
- `ITENS_PEDIDO`

O script inclui todos os **CREATE TABLE** necessários com suas referências (FOREIGN KEYS).

---

## 2️⃣ Inserção de Dados

Os dados fornecidos pelo teste foram inseridos usando **INSERT INTO**, garantindo que as queries possam ser testadas corretamente.

---

## 3️⃣ Queries dos Desafios

### 3.1 Consulta de Vendedores Ativos
Retorna **id, nome e salário** dos vendedores ativos, ordenados pelo nome ascendente.

### 3.2 Funcionários com Salário Acima da Média
Retorna **id, nome e salário** dos funcionários cujo salário é **acima da média**, ordenados por salário descendente.

### 3.3 Resumo por Cliente
Lista todos os clientes com o **valor total dos pedidos já transmitidos**, ordenados pelo total descendente.

### 3.4 Situação por Pedido
Retorna a situação de cada pedido (`CANCELADO`, `FATURADO` ou `PENDENTE`) junto com **id, valor e data**.

### 3.5 Produto Mais Vendido
Retorna o produto mais vendido em **quantidade**, mostrando:

- `id_produto`
- `quantidade_vendida`
- `total_vendido`
- `pedidos` (quantidade de pedidos)
- `clientes` (quantidade de clientes distintos)

Em caso de empate na quantidade, o critério de desempate é o **total vendido**.

---

## 4️⃣ Como Rodar

1. Copie o arquivo `teste_sql_queries.sql`.
2. Cole no PostgreSQL ou SQL Fiddle.
3. Execute todo o script de uma vez.
4. Confira os resultados de cada desafio separados por comentários.

---

## 5️⃣ Resultado Esperado

Os resultados de cada query estão de acordo com os exemplos fornecidos no teste, garantindo **conformidade completa**.

---

**Autor:** Igor Silva  
**LinkedIn/GitHub:** [seu-link-aqui]

