-- inserçoes de dados e queries

use projetoEcommerce;

INSERT INTO Clientes (idClient, Fname, Lname, CPF, email, endereco, dataNascimento)
	 VALUES (1, 'Marcelo', 'Neves', 07486423631, 'marceloneves@example.com', 'Rua Garibaldi, 59 - Tiradentes - Perneiras, SP','1985-09-21'),
            (21, 'Ana', 'Mendes', 12586463132, 'ana@example.com', 'Rua Bombocado, 188 - Arco iris - Salto, SP','1992-04-19'),
            (18, 'Maria', 'Silva', 22385424649, 'mariasilva@example.com', 'Av Deodoro, 1339 - Nova Olinda - Perdizes, PR','1999-06-12'),
            (23, 'Marcos', 'Menezes', 87526424608, 'marcos@example.com', 'Av Tomate, 33 - Torres - Tendas, GO','1994-11-01'),
            (44, 'Flavia', 'Neres', 01415425812, 'flavianeres@example.com', 'Rua Goiabeira, 99 - Pomar - Belo Monte, PR','2000-05-12');
            

insert into Pedidos (idPedido, idClient, dataPedido, totalPedido, statusPedido)
	 values (28, 23, '2023-02-15', '2', 'Processando'),
			(55, 1, '2023-03-22', '4', 'Aprovado'),
            (12, 21, '2023-05-15', '5', 'Pendente'),
            (32, 18, '2023-05-17', '6','Aprovado'),
            (17, 44, '2023-06-19', '3','Processando');


insert into Produtos (idProduct, idClient, descrição, category, preçounitario, preçototal, quantidade)
		values (7, 18, 'Biblia Sagrada', 'Livros', 189.90, 1139.40, '6'),
			   (36, 44, 'Boneco Avengers', 'Brinquedos', 109.90, 329.70, '3'),
               (26, 1, 'R Mobila', 'Smartphone', 2229.85, 8919.40, '4'),
               (89, 23, 'Tv Smart O', 'Eletronicos', 3599.95, 7199.90, '2'),
               (63, 21, 'Cegonheira', 'Brinquedos', 49.90, 249.50, 5);



insert into formasdepagamento (idPagamento, idClient, idProduct, dataPagamento, tipoPagamento, statusPagamento)
         values (79, 21, 7, '2023-05-15', 'Pix', 'Pendente'),
                (72, 1, 26, '2023-04-22', 'Crédito', 'Concluido'),
                (85, 23, 89,'2023-02-17', 'Débito', 'Aguardando'),
                (105, 18, 7, '2023-06-17', 'Pix', 'Concluido'),
                (93, 44, 36, '2023-05-18', 'Pix', 'Concluido');

insert into Entregas (idEntrega, idPedido, dataEntrega, codigorastreio, statusEntrega)
         values (112, 28, '2023-02-25', 50021859, 'Processando'),
			    (134, 55, '2023-04-02', '61831585', 'Enviado'),
                (148, 12, '2023-05-25', '75845963', 'Processando'),
                (157, 32, '2023-06-07', '32547821','Entregue'),
                (189, 17, '2023-07-29', '46832914', 'Entregue');
                
insert into Fornecedores (idFornecedor, nome, razãoSocial, CNPJ, email, contato)
		values (10, 'Grupo MR', 'MR Eletro', '32501281000158', 'mreletro1@mreletro.com','0800305634'),
			   (20, 'Grupo Saber', 'Livraria Paz de Deus', '17170207000107', 'gruposaber@gruposaber.com','0800311757');

insert into Estoque (idEstoque, idProduct, idFornecedor, statusProduct, quantidade)
		 values (101, 26, 10, 'Disponivel', 12),
                (102, 36, 10, 'Disponivel', 15),
                (103, 89, 10, 'Disponivel', 13),
                (104, 63, 10, 'Disponivel', 19),
                (700, 7, 20, 'Disponivel', 22);
               
insert into Vendedores (idVendedor, idProduct, idFornecedor, Fnome, Lnome, email, CPF, contato)
         values (221, 36, 10, 'Roberto', 'Santos', 'robertosantos@mreletro.com', '1048856903','31992183355'),
                (222, 26, 10, 'Fernando', 'Silva', 'fernandosilva@mreletro.com', '1843356913','31992183422'),
				(223, 89, 10, 'Elaine', 'Carvalho', 'elainecarvalho@mreletro.com', '0573252063','31992182344'),
				(224, 63, 10, 'Silvia', 'Antunes', 'silvias@mreletro.com', '1131818312','31992182456'),
                (701, 7, 20, 'Adriana', 'Pontes', 'adrianap@gruposaber.com', '0248261918','35988221525');

-- Recupera todos os clientes
SELECT * FROM Clientes;

-- Recupera todos os produtos
SELECT * FROM Produtos;

-- Recupera os pedidos feitos por um cliente específico (ID 21)
SELECT * FROM Pedidos WHERE idClient = 21;

-- Recupera produtos de uma categoria específica (ex: 'Brinquedos')
SELECT * FROM Produtos WHERE category = 'Brinquedos';

-- Recupera o total do pedido multiplicando o preço unitário pelo quantidade
SELECT idProduct, preçototal, (preçounitario * quantidade) AS total FROM Produtos LIMIT 0, 1000;

-- Recupera produtos ordenados por preço em ordem decrescente
SELECT * FROM Produtos ORDER BY preçounitario DESC;

-- Recupera o total de vendas por categoria de produtos
SELECT category, SUM(preçounitario * quantidade) AS total_vendas FROM Produtos
GROUP BY category HAVING total_vendas > 1000;

-- Recupera informações de pedidos e clientes associados
SELECT Pedidos.idPedido, Clientes.Fname, Clientes.Lname, Pedidos.dataPedido
FROM Pedidos
JOIN Clientes ON Pedidos.idClient = Clientes.idClient;

-- Quantos Pedidos Foram Feitos por Cada Cliente?
SELECT idClient, COUNT(*) AS total_pedidos
FROM Pedidos
GROUP BY idClient;

-- Algum Vendedor Também É Fornecedor?
SELECT DISTINCT V.idVendedor, V.Fnome, V.Lnome
FROM Vendedores V
JOIN Fornecedores F ON V.idFornecedor = F.idFornecedor;

-- Relação de Produtos, Fornecedores e Estoques:
SELECT P.idProduct, P.descrição AS produto, F.nome AS fornecedor, E.quantidade
FROM Produtos P
JOIN Estoque E ON P.idProduct = E.idProduct
JOIN Fornecedores F ON E.idFornecedor = F.idFornecedor;

-- Relação de Nomes dos Fornecedores e Nomes dos Produtos:
SELECT F.nome AS fornecedor, P.descrição AS produto
FROM Produtos P
JOIN Estoque E ON P.idProduct = E.idProduct
JOIN Fornecedores F ON E.idFornecedor = F.idFornecedor;










	