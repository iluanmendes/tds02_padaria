-- --------------------------------------------------------
-- Servidor:                     10.91.45.36
-- Versão do servidor:           11.8.6-MariaDB-0+deb13u1 from Debian - -- Please help get to 10k stars at https://github.com/MariaDB/Server
-- OS do Servidor:               debian-linux-gnu
-- HeidiSQL Versão:              12.21.0.7344
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para padaria_bd
DROP DATABASE IF EXISTS `padaria_bd`;
CREATE DATABASE IF NOT EXISTS `padaria_bd` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `padaria_bd`;

-- Copiando estrutura para tabela padaria_bd.Cliente
DROP TABLE IF EXISTS `Cliente`;
CREATE TABLE IF NOT EXISTS `Cliente` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `CPF` varchar(14) DEFAULT NULL,
  `Telefone` varchar(20) DEFAULT NULL,
  `Endereco` varchar(255) DEFAULT NULL,
  `Pontos` int(11) DEFAULT 0,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `CPF` (`CPF`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela padaria_bd.Compra
DROP TABLE IF EXISTS `Compra`;
CREATE TABLE IF NOT EXISTS `Compra` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `DataHora` datetime NOT NULL DEFAULT current_timestamp(),
  `FuncionarioId` int(11) NOT NULL,
  `ClienteId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FuncionarioId` (`FuncionarioId`),
  KEY `ClienteId` (`ClienteId`),
  CONSTRAINT `Compra_ibfk_1` FOREIGN KEY (`FuncionarioId`) REFERENCES `Funcionario` (`Id`),
  CONSTRAINT `Compra_ibfk_2` FOREIGN KEY (`ClienteId`) REFERENCES `Cliente` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela padaria_bd.Fornecedor
DROP TABLE IF EXISTS `Fornecedor`;
CREATE TABLE IF NOT EXISTS `Fornecedor` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `CNPJ` varchar(18) DEFAULT NULL,
  `Telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `CNPJ` (`CNPJ`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela padaria_bd.Funcionario
DROP TABLE IF EXISTS `Funcionario`;
CREATE TABLE IF NOT EXISTS `Funcionario` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `CPF` varchar(14) DEFAULT NULL,
  `Cargo` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `CPF` (`CPF`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela padaria_bd.ItemCompra
DROP TABLE IF EXISTS `ItemCompra`;
CREATE TABLE IF NOT EXISTS `ItemCompra` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CompraId` int(11) NOT NULL,
  `ProdutoId` int(11) NOT NULL,
  `Quantidade` int(11) NOT NULL CHECK (`Quantidade` > 0),
  `PrecoCobrado` decimal(10,2) NOT NULL CHECK (`PrecoCobrado` > 0),
  PRIMARY KEY (`Id`),
  KEY `CompraId` (`CompraId`),
  KEY `ProdutoId` (`ProdutoId`),
  CONSTRAINT `ItemCompra_ibfk_1` FOREIGN KEY (`CompraId`) REFERENCES `Compra` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `ItemCompra_ibfk_2` FOREIGN KEY (`ProdutoId`) REFERENCES `Produto` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela padaria_bd.Marca
DROP TABLE IF EXISTS `Marca`;
CREATE TABLE IF NOT EXISTS `Marca` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela padaria_bd.MarcaFornecedor
DROP TABLE IF EXISTS `MarcaFornecedor`;
CREATE TABLE IF NOT EXISTS `MarcaFornecedor` (
  `MarcaId` int(11) NOT NULL,
  `FornecedorId` int(11) NOT NULL,
  PRIMARY KEY (`MarcaId`,`FornecedorId`),
  KEY `FornecedorId` (`FornecedorId`),
  CONSTRAINT `MarcaFornecedor_ibfk_1` FOREIGN KEY (`MarcaId`) REFERENCES `Marca` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `MarcaFornecedor_ibfk_2` FOREIGN KEY (`FornecedorId`) REFERENCES `Fornecedor` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela padaria_bd.Produto
DROP TABLE IF EXISTS `Produto`;
CREATE TABLE IF NOT EXISTS `Produto` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Preco` decimal(10,2) NOT NULL CHECK (`Preco` > 0),
  `Categoria` varchar(50) DEFAULT NULL,
  `Fabricado` tinyint(1) NOT NULL DEFAULT 0,
  `MarcaId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `MarcaId` (`MarcaId`),
  CONSTRAINT `Produto_ibfk_1` FOREIGN KEY (`MarcaId`) REFERENCES `Marca` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela padaria_bd.ProdutoFabricado
DROP TABLE IF EXISTS `ProdutoFabricado`;
CREATE TABLE IF NOT EXISTS `ProdutoFabricado` (
  `ProdutoId` int(11) NOT NULL,
  `DescricaoProducao` text DEFAULT NULL,
  PRIMARY KEY (`ProdutoId`),
  CONSTRAINT `ProdutoFabricado_ibfk_1` FOREIGN KEY (`ProdutoId`) REFERENCES `Produto` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
