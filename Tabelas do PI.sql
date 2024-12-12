-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`agendamento` (
  `idAgendamento` INT NOT NULL,
  `valorPago` DECIMAL(10,0) NOT NULL,
  `dataHora` DATETIME NOT NULL,
  `formaPagamento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAgendamento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cargo` (
  `idCargo` INT NOT NULL,
  `nomeCargo` VARCHAR(45) NOT NULL,
  `salario` DECIMAL(6,2) NOT NULL,
  `cargaHora` TIME NOT NULL,
  PRIMARY KEY (`idCargo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`funcionario` (
  `matricula` INT NOT NULL,
  `nomeFuncionario` VARCHAR(45) NOT NULL,
  `dataAdm` DATETIME NOT NULL,
  `dataDem` DATETIME NULL DEFAULT NULL,
  `dataNasc` DATE NOT NULL,
  `nomeSocial` VARCHAR(45) NULL DEFAULT NULL,
  `cargo_idCargo` INT NOT NULL,
  PRIMARY KEY (`matricula`),
  INDEX `fk_funcionario_cargo1_idx` (`cargo_idCargo` ASC) VISIBLE,
  CONSTRAINT `fk_funcionario_cargo1`
    FOREIGN KEY (`cargo_idCargo`)
    REFERENCES `mydb`.`cargo` (`idCargo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `CPF` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `sexo` VARCHAR(45) NOT NULL,
  `dataNasc` DATE NOT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`agendamentomarcado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`agendamentomarcado` (
  `usuario_CPF` VARCHAR(14) NOT NULL,
  `funcionario_matricula` INT NOT NULL,
  `agendamento_idAgendamento` INT NOT NULL,
  PRIMARY KEY (`usuario_CPF`, `funcionario_matricula`, `agendamento_idAgendamento`),
  INDEX `fk_table1_funcionario1_idx` (`funcionario_matricula` ASC) VISIBLE,
  INDEX `fk_table1_agendamento1_idx` (`agendamento_idAgendamento` ASC) VISIBLE,
  CONSTRAINT `fk_table1_agendamento1`
    FOREIGN KEY (`agendamento_idAgendamento`)
    REFERENCES `mydb`.`agendamento` (`idAgendamento`),
  CONSTRAINT `fk_table1_funcionario1`
    FOREIGN KEY (`funcionario_matricula`)
    REFERENCES `mydb`.`funcionario` (`matricula`),
  CONSTRAINT `fk_table1_usuario`
    FOREIGN KEY (`usuario_CPF`)
    REFERENCES `mydb`.`usuario` (`CPF`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`servico` (
  `idServico` INT NOT NULL,
  `nomeServico` VARCHAR(45) NOT NULL,
  `valor` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`idServico`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`servicoagendado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`servicoagendado` (
  `servico_idServico` INT NOT NULL,
  `agendamento_idAgendamento` INT NOT NULL,
  INDEX `fk_servicoAgendado_servico1_idx` (`servico_idServico` ASC) VISIBLE,
  INDEX `fk_servicoAgendado_agendamento1_idx` (`agendamento_idAgendamento` ASC) VISIBLE,
  CONSTRAINT `fk_servicoAgendado_agendamento1`
    FOREIGN KEY (`agendamento_idAgendamento`)
    REFERENCES `mydb`.`agendamento` (`idAgendamento`),
  CONSTRAINT `fk_servicoAgendado_servico1`
    FOREIGN KEY (`servico_idServico`)
    REFERENCES `mydb`.`servico` (`idServico`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`telefonefuncionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefonefuncionario` (
  `funcionario_matricula` INT NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  INDEX `fk_telefoneFuncionario_funcionario1_idx` (`funcionario_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_telefoneFuncionario_funcionario1`
    FOREIGN KEY (`funcionario_matricula`)
    REFERENCES `mydb`.`funcionario` (`matricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`telefoneusuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefoneusuario` (
  `numero` VARCHAR(45) NOT NULL,
  `usuario_CPF` VARCHAR(14) NOT NULL,
  INDEX `fk_telefoneUsuario_usuario1_idx` (`usuario_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_telefoneUsuario_usuario1`
    FOREIGN KEY (`usuario_CPF`)
    REFERENCES `mydb`.`usuario` (`CPF`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydb`.`funcionarioEndereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`funcionarioEndereco` (
  `funcionario_matricula` INT NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`funcionario_matricula`),
  CONSTRAINT `fk_funcionarioEndereco_funcionario1`
    FOREIGN KEY (`funcionario_matricula`)
    REFERENCES `mydb`.`funcionario` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarioEndereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarioEndereco` (
  `usuario_CPF` VARCHAR(14) NOT NULL,
  `rua` VARCHAR(100) NOT NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`usuario_CPF`),
  CONSTRAINT `fk_table1_usuario1`
    FOREIGN KEY (`usuario_CPF`)
    REFERENCES `mydb`.`usuario` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS mydb.login (
  usuario_CPF VARCHAR(14) NOT NULL,
  email VARCHAR(45) NOT NULL,
  senha VARCHAR(45) NOT NULL,
  INDEX fk_cadastro_usuario1_idx (usuario_CPF ASC) VISIBLE,
  CONSTRAINT fk_cadastro_usuario1
    FOREIGN KEY (usuario_CPF)
    REFERENCES mydb.usuario (CPF)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
