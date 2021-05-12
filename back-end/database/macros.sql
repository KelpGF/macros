-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 12-Maio-2021 às 18:32
-- Versão do servidor: 10.4.17-MariaDB
-- versão do PHP: 7.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `macros`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `aliementos_ingeridos`
--

CREATE TABLE `aliementos_ingeridos` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_alimento` int(11) NOT NULL,
  `quantidade` decimal(6,2) NOT NULL,
  `data_hora` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `aliementos_ingeridos`
--

INSERT INTO `aliementos_ingeridos` (`id`, `id_usuario`, `id_alimento`, `quantidade`, `data_hora`) VALUES
(1, 1, 1, '200.00', '2021-05-12 13:28:22');

-- --------------------------------------------------------

--
-- Estrutura da tabela `alimentos`
--

CREATE TABLE `alimentos` (
  `id` int(11) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `carboidratos` decimal(6,2) NOT NULL,
  `proteinas` decimal(6,2) NOT NULL,
  `gorduras` decimal(6,2) NOT NULL,
  `porcao` int(11) NOT NULL,
  `unidade_medida` enum('g','ml') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `alimentos`
--

INSERT INTO `alimentos` (`id`, `nome`, `carboidratos`, `proteinas`, `gorduras`, `porcao`, `unidade_medida`) VALUES
(1, 'banana', '23.00', '1.10', '0.30', 100, 'g');

-- --------------------------------------------------------

--
-- Estrutura da tabela `dados_usuario`
--

CREATE TABLE `dados_usuario` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `nome` varchar(80) NOT NULL,
  `idade` int(11) NOT NULL,
  `sexo` enum('m','f') NOT NULL,
  `altura` int(11) NOT NULL,
  `peso` decimal(6,3) NOT NULL,
  `biotipo` enum('ecto','endo','meso') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `dados_usuario`
--

INSERT INTO `dados_usuario` (`id`, `id_usuario`, `nome`, `idade`, `sexo`, `altura`, `peso`, `biotipo`) VALUES
(5, 1, 'Kelvin Gomes', 18, 'm', 180, '80.000', 'ecto');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `login` varchar(50) NOT NULL,
  `senha` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `login`, `senha`) VALUES
(1, 'kelp', '123');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `aliementos_ingeridos`
--
ALTER TABLE `aliementos_ingeridos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuarios_alimento_ingerido_fk` (`id_usuario`),
  ADD KEY `alimentos_ingeridos_fk` (`id_alimento`);

--
-- Índices para tabela `alimentos`
--
ALTER TABLE `alimentos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `dados_usuario`
--
ALTER TABLE `dados_usuario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_dados_fk` (`id_usuario`);

--
-- Índices para tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `aliementos_ingeridos`
--
ALTER TABLE `aliementos_ingeridos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `alimentos`
--
ALTER TABLE `alimentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `dados_usuario`
--
ALTER TABLE `dados_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `aliementos_ingeridos`
--
ALTER TABLE `aliementos_ingeridos`
  ADD CONSTRAINT `alimentos_ingeridos_fk` FOREIGN KEY (`id_alimento`) REFERENCES `alimentos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios_alimento_ingerido_fk` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `dados_usuario`
--
ALTER TABLE `dados_usuario`
  ADD CONSTRAINT `usuario_dados_fk` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
