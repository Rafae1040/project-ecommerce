-- Criar as tabelas do Projeto ecommerce

create database projetoEcommerce;

use projetoEcommerce;


-- criar tabela clientes 

create table Clientes (
    idClient int auto_increment primary key,
    Fname varchar(50),
    Lname VARCHAR(50),
    CPF VARCHAR(11),
    email VARCHAR(50),
    endereco VARCHAR(50),
    dataNascimento DATE
);

-- criar tabela pedidos

create table Pedidos (
    idPedido int auto_increment primary key,
    idClient int,
    dataPedido date,
    totalPedido int,
    statusPedido VARCHAR(50),
    endereco ENUM('Pendente', 'Processando', 'Aprovado') default 'pendente',
    dataNascimento DATE,
    foreign key (idClient) references Clientes(idClient)
);


create table Produtos (
    idProduct int auto_increment primary key,
    idClient int,
    descrição varchar(100),
    category ENUM('Livros', 'Eletronicos', 'Brinquedos', 'Smartphone') default 'Livros',
    preçoUnitario decimal(10,2),
    preçoTotal decimal(10,2),
    quantidade int
);

-- criar tabela formas de pagamentos
create table formasdepagamento (
    idPagamento int auto_increment primary key,
    idClient int,
    idProduct int,
    dataPagamento date,
    tipoPagamento ENUM('Débito', 'Crédito', 'Pix') default 'Débito',
    statusPagamento ENUM('Aguardando', 'Pendente', 'Concluido', 'Cancelado') default 'Aguardando',
    FOREIGN KEY (idClient) REFERENCES Clientes(idClient)
);

-- criar tabela entrega 

create table Entregas (
    idEntrega int auto_increment primary key,
    idPedido int,
	dataEntrega date,
    codigorastreio varchar(100),
    statusEntrega ENUM('Processando', 'Separando', 'Na Transpotadora', 'Enviado', 'Entregue') default 'Processando',
	FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido)
);

-- criar tabela fornecedores

create table Fornecedores (
    idFornecedor int auto_increment primary key,
    nome varchar(50),
    razãoSocial varchar(50),
    CNPJ VARCHAR(15),
    email VARCHAR(50),
    contato VARCHAR(50)
);


-- criar tabela estoque
create table Estoque (
    idEstoque int auto_increment primary key,
    idProduct int,
    idFornecedor int,
    statusProduct ENUM('Disponivel', 'Indisponivel') default 'Disponivel',
    quantidade int,
    FOREIGN KEY (idProduct) REFERENCES Produtos(idProduct),
    FOREIGN KEY (idFornecedor) REFERENCES Fornecedores(idFornecedor)
);

-- criar tabela vendedores 

create table Vendedores (
    idVendedor int auto_increment primary key,
    idProduct int,
    idFornecedor int,
    Fnome varchar(100),
    Lnome varchar(100),
    email varchar(100),
    CPF varchar(12),
    contato varchar(45),
    FOREIGN KEY (idProduct) REFERENCES Produtos(idProduct),
    FOREIGN KEY (idFornecedor) REFERENCES Fornecedores(idFornecedor)
);

show tables;