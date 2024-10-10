USE Gerenciamento_loja;

CREATE TABLE endereco(
    endereco_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(100) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    numero VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL
);

CREATE TABLE usuario(
    usuario_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    cpf VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    end_int_id INT UNSIGNED,
    FOREIGN KEY (end_int_id) REFERENCES endereco(endereco_id)
);

CREATE TABLE funcionario(
    funcionario_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(100) NOT NULL
);

CREATE TABLE pedido(
    pedido_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    data_pedido TIMESTAMP NOT NULL,
    usu_int_id INT UNSIGNED, 
    FOREIGN KEY (usu_int_id) REFERENCES usuario(usuario_id)
);

CREATE TABLE categoria(
    categoria_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    categoria_nome VARCHAR(100) NOT NULL,
    categoria_descricao VARCHAR(100) NOT NULL
);

CREATE TABLE produto(
    produto_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    estoque INT NOT NULL,
    data_fabricacao DATE NOT NULL,
    valor FLOAT NOT NULL,
    cat_int_id INT UNSIGNED,
    func_int_id INT UNSIGNED,
    FOREIGN KEY (cat_int_id) REFERENCES categoria(categoria_id),
    FOREIGN KEY (func_int_id) REFERENCES funcionario(funcionario_id)
);

CREATE TABLE pedido_produto(
    pedidoProduto_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    prod_int_id INT UNSIGNED,
    ped_int_id INT UNSIGNED,
    FOREIGN KEY (prod_int_id) REFERENCES produto(produto_id),
    FOREIGN KEY (ped_int_id) REFERENCES pedido(pedido_id)
);


--Aqui usamos index para mostrar a informações do produto

CREATE index prod1_index ON produto(nome,estoque, produto_id);

CREATE index prod2_index ON produto(valor, data_fabricacao);

--Index para o usuário

CREATE index usu1_index ON usuario(usuario_id, nome, cpf, data_nascimento);

CREATE index usu2_index ON usuario(nome, email, end_int_id);

--Index para o pedido

CREATE index ped1_index ON pedido(pedido_id, data_pedido, usu_int_id);

INSERT INTO endereco(rua, bairro, numero, cidade, estado)
VALUES  
    ('Capitão Rodrigo', 'Centro', '678', 'Novo Oriente', 'Ceará'),
    ('Dom Pedro II', 'Fátima II', '1221', 'Crateús', 'Ceará'),
    ('Cazza Rocha', 'Centro', '1342', 'Novo Oriente', 'Ceará'),
    ('15 de Março', 'Lagoa das Goiabeiras', '873', 'São Benedito', 'Ceará'),
    ('Castelo Branco', 'São Vicente', '345', 'Xexéu', 'Pernambuco');

SELECT * FROM endereco;
-- Agora, iremos alterar a descricao, da tabela categoria, para o tipo texto para receber + caracteres

ALTER TABLE categoria 
MODIFY categoria_descricao TEXT;

INSERT INTO categoria (categoria_nome, categoria_descricao)
VALUES
('Componentes de PC', 'Peças internas como processadores, placas-mãe, memória RAM e placas de vídeo que são essenciais para montar ou atualizar um computador.'),
('Periféricos para PC', 'Equipamentos externos como mouses, teclados, monitores e impressoras que melhoram a interação e a produtividade ao usar um computador.'),
('Celulares', 'Dispositivos móveis multifuncionais que permitem chamadas, mensagens, navegação na internet e acesso a aplicativos, com variações de marcas e especificações.
'),
('Acessórios para Celulares', 'Itens complementares como capas, películas protetoras, carregadores e fones de ouvido que melhoram a funcionalidade e a proteção de smartphones.'),
('Software para PC e Celulares','Programas e aplicativos que otimizam o uso de computadores e celulares, abrangendo sistemas operacionais, suítes de escritório, ferramentas de segurança e entretenimento.');

SELECT * FROM categoria;


INSERT INTO usuario (nome, email, cpf, data_nascimento, end_int_id)
VALUES
('123 da Silva 4', '123silva@gmail.com', '22233344455', '2000-01-01',1),
('Jackson Costa', 'costajack@gmail.com', '09885413209', '1999-02-02', 2),
('Paula Pontes','paulap@yahoo.com', '3245687690', '2003-05-14', 3),
('Fabio Lima','lima123@gmail.com', '85490215343', '1998-03-03',4),
('Junior Azevedo','azevedo@gmail.com','09313245698', '1985-10-10',5);

SELECT * FROM usuario;

INSERT INTO funcionario (nome, cpf)
values ('Maria','11122233344' ),
('Mikael','22233344455'),
('Vicente', '33344455566'),
('Aguiar','44455566677'),
('Joel','55566677788');

SELECT * FROM funcionario;

ALTER TABLE produto
MODIFY descricao TEXT;

INSERT INTO produto (cat_int_id, func_int_id, nome, descricao, estoque, data_fabricacao, valor)
VALUES
(1, 1, 'Processador Intel Core i7', 'Processador de alto desempenho para jogos e tarefas intensivas.', 50, '2023-05-10', 200.00),
(1, 2, 'Placa de Vídeo NVIDIA GeForce RTX 3060', 'Placa de vídeo para jogos em alta definição e criação de conteúdo.', 30, '2023-06-15', 1500.00),
(2, 3, 'Teclado Mecânico RGB', 'Teclado com iluminação personalizável e teclas mecânicas para gamers.', 75, '2023-04-20', 300.00),
(2, 4, 'Monitor Full HD 24"', 'Monitor com resolução Full HD ideal para jogos e trabalho.', 40, '2023-03-12', 1200.00),
(3, 5, 'Smartphone Samsung Galaxy S21', 'Smartphone com câmera de alta qualidade e desempenho rápido.', 60, '2023-01-25', 3500.00),
(3, 1, 'iPhone 13', 'Smartphone da Apple com chip A15 Bionic e excelente câmera.', 40, '2023-02-14', 5000.00),
(4, 2, 'Capa de Silicone para iPhone 13', 'Capa protetora e leve para iPhone 13, disponível em várias cores.', 100, '2023-03-01', 100.00),
(4, 3, 'Fone de Ouvido Sem Fio Bluetooth', 'Fones de ouvido sem fio com cancelamento de ruído e alta qualidade de som.', 80, '2023-04-15', 450.00),
(10, 4, 'Microsoft Office 2021', 'Pacote de produtividade com Word, Excel, PowerPoint e mais.', 150, '2023-01-10', 800.00),
(10, 5, 'Antivírus Norton 360', 'Software de segurança completo para proteger dispositivos contra malware.', 90, '2023-02-28', 250.00);

SELECT * FROM produto;

INSERT INTO pedido (data_pedido, usu_int_id)
VALUES
('2024-02-09 11:09:00', 1),
('2024-02-18 17:00:00', 2), 
('2024-04-15 12:43:00', 4), 
('2024-09-01 16:00:00', 5); 

SELECT * FROM pedido;

INSERT INTO pedido_produto(ped_int_id, prod_int_id)
VALUES
(1,2),
(1,1),
(2,4),
(2,5),
(3,3),
(3,11),
(4,17),
(4,6),
(3,7),
(2,8);

SELECT * FROM pedido_produto;

