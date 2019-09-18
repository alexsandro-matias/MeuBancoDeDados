

-- -----------------------------------------------------
-- Schema roque
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema roque
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `roque` DEFAULT CHARACTER SET utf8 ;
USE `roque` ;

-- -----------------------------------------------------
-- Table `roque`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roque`.`aluno` (
  `idaluno` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idaluno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `roque`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roque`.`professor` (
  `idprofessor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(30) NOT NULL,
  `titulo` ENUM('mestre', 'doutor', 'especialista', '') NOT NULL,
  PRIMARY KEY (`idprofessor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `roque`.`disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roque`.`disciplina` (
  `iddisciplina` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cargahoraria` INT NULL,
  PRIMARY KEY (`iddisciplina`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `roque`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roque`.`curso` (
  `idcurso` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idcurso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `roque`.`dependente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roque`.`dependente` (
  `id_dependente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `id_professor` INT NOT NULL,
  PRIMARY KEY (`id_dependente`, `id_professor`),
  INDEX `fk_dependente_professor1_idx` (`id_professor` ASC),
  CONSTRAINT `fk_dependente_professor1`
    FOREIGN KEY (`id_professor`)
    REFERENCES `roque`.`professor` (`idprofessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `roque`.`avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roque`.`avaliacao` (
  `idavaliacao` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `unidade` VARCHAR(10) NOT NULL,
  `data_avaliacao` DATE NOT NULL,
  `nota_maxima` DECIMAL(4,2) NOT NULL,
  `nota_minima` DECIMAL(4,2) NOT NULL,
  `peso` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`idavaliacao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `roque`.`diario_professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roque`.`diario_professor` (
  `idprofessor` INT NOT NULL AUTO_INCREMENT,
  `funcao` VARCHAR(40) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`idprofessor`),
  INDEX `fk_diario_has_professor_professor1_idx` (`idprofessor` ASC),
  CONSTRAINT `fk_diario_has_professor_professor1`
    FOREIGN KEY (`idprofessor`)
    REFERENCES `roque`.`professor` (`idprofessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `roque`.`diario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roque`.`diario` (
  `iddiario` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idaluno` INT NOT NULL,
  `iddisciplina` INT NOT NULL,
  `idcurso` INT NOT NULL,
  `turno` ENUM('manhã', 'tarde', 'noite') NOT NULL,
  `idavaliacao` INT NOT NULL,
  `idprofessor` INT NOT NULL,
  PRIMARY KEY (`iddiario`, `iddisciplina`, `idcurso`, `idavaliacao`, `idprofessor`),
  INDEX `fk_diario_disciplina1_idx` (`iddisciplina` ASC),
  INDEX `fk_diario_curso1_idx` (`idcurso` ASC),
  INDEX `fk_diario_avaliacao1_idx` (`idavaliacao` ASC),
  INDEX `fk_diario_diario_professor1_idx` (`idprofessor` ASC),
  CONSTRAINT `fk_diario_disciplina1`
    FOREIGN KEY (`iddisciplina`)
    REFERENCES `roque`.`disciplina` (`iddisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_diario_curso1`
    FOREIGN KEY (`idcurso`)
    REFERENCES `roque`.`curso` (`idcurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_diario_avaliacao1`
    FOREIGN KEY (`idavaliacao`)
    REFERENCES `roque`.`avaliacao` (`idavaliacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_diario_diario_professor1`
    FOREIGN KEY (`idprofessor`)
    REFERENCES `roque`.`diario_professor` (`idprofessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `roque`.`notas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roque`.`notas` (
  `idavaliacao` INT NOT NULL,
  `nota` DECIMAL(4,2) NOT NULL,
  `idaluno` INT NOT NULL,
  PRIMARY KEY (`idavaliacao`, `idaluno`),
  INDEX `fk_nota_has_avaliacao_avaliacao1_idx` (`idavaliacao` ASC),
  INDEX `fk_nota_avaliacao_aluno1_idx` (`idaluno` ASC),
  CONSTRAINT `fk_nota_has_avaliacao_avaliacao1`
    FOREIGN KEY (`idavaliacao`)
    REFERENCES `roque`.`avaliacao` (`idavaliacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_avaliacao_aluno1`
    FOREIGN KEY (`idaluno`)
    REFERENCES `roque`.`aluno` (`idaluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Data for table `roque`.`aluno`
-- -----------------------------------------------------
START TRANSACTION;
USE `roque`;
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (1, 'Alexsandro matias');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (2, 'Josiane maria');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (3, 'eliane maria');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (4, 'Priscila matias');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (5, 'raul seixas');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (6, 'chico buarque');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (7, 'chico cesar');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (8, 'Josiane santos');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (9, 'jonh lima');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (10, 'gideone santos');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (11, 'maurilo santana');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (12, 'mauricio moura');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (13, 'jose Silva');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (14, 'jose santos');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (15, 'maria eduarda');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (16, 'maria Silva');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (17, 'Matheus neves');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (18, 'paulo roberto');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (19, 'girlane coelho');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (20, 'helio da Silva');
INSERT INTO `roque`.`aluno` (`idaluno`, `nome`) VALUES (21, 'horácio de castro');

COMMIT;


-- -----------------------------------------------------
-- Data for table `roque`.`professor`
-- -----------------------------------------------------
START TRANSACTION;
USE `roque`;
INSERT INTO `roque`.`professor` (`idprofessor`, `nome`, `titulo`) VALUES (1, 'marco domingues', DEFAULT);
INSERT INTO `roque`.`professor` (`idprofessor`, `nome`, `titulo`) VALUES (2, 'rafael roque', DEFAULT);
INSERT INTO `roque`.`professor` (`idprofessor`, `nome`, `titulo`) VALUES (3, 'anderson moreira', DEFAULT);
INSERT INTO `roque`.`professor` (`idprofessor`, `nome`, `titulo`) VALUES (4, 'paulo abadie', DEFAULT);
INSERT INTO `roque`.`professor` (`idprofessor`, `nome`, `titulo`) VALUES (5, 'paulo goncalves', DEFAULT);
INSERT INTO `roque`.`professor` (`idprofessor`, `nome`, `titulo`) VALUES (6, 'renata freire', DEFAULT);
INSERT INTO `roque`.`professor` (`idprofessor`, `nome`, `titulo`) VALUES (7, 'renata dantas', DEFAULT);
INSERT INTO `roque`.`professor` (`idprofessor`, `nome`, `titulo`) VALUES (8, 'ainda ferreira', DEFAULT);
INSERT INTO `roque`.`professor` (`idprofessor`, `nome`, `titulo`) VALUES (9, 'marcos andré ', DEFAULT);
INSERT INTO `roque`.`professor` (`idprofessor`, `nome`, `titulo`) VALUES (10, 'Heloísa rodrigues', DEFAULT);
INSERT INTO `roque`.`professor` (`idprofessor`, `nome`, `titulo`) VALUES (11, 'Fernanda Tenónio', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `roque`.`disciplina`
-- -----------------------------------------------------
START TRANSACTION;
USE `roque`;
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (1, 'Estrutura de Dados ', 100);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (2, 'Banco de Dados 1 ', 60);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (3, 'Banco de Dados 2 ', 40);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (4, 'Arquitetura de Computadores ', 50);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (5, 'Sistema Operacionais ', 50);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (6, 'Português Instrumental ', 30);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (7, 'Inglês Instrumental', 35);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (8, 'Programação Orientada a Objetos ', 120);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (9, 'Desenvolvimento Web 1 ', 80);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (10, 'Desenvolvimento Web 2 ', 90);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (11, 'Cálculo 1 ', 120);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (12, 'Cálculo 2 ', 80);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (13, 'Cálculo 3 ', 60);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (14, 'Redes 1 ', 60);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (15, 'Redes 2 ', 50);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (16, 'Sistemas Embarcados ', 45);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (17, 'LIBRAS ', 45);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (18, 'Introdução à Programação ', 90);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (19, 'Ética Profissional ', 30);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (20, 'Cálculo Numérico ', 65);
INSERT INTO `roque`.`disciplina` (`iddisciplina`, `nome`, `cargahoraria`) VALUES (21, 'Geometria Analítica ', 70);

COMMIT;


-- -----------------------------------------------------
-- Data for table `roque`.`curso`
-- -----------------------------------------------------
START TRANSACTION;
USE `roque`;
INSERT INTO `roque`.`curso` (`idcurso`, `nome`) VALUES (1, 'Tecnólogo análise de desenvolvimento de sistemas');
INSERT INTO `roque`.`curso` (`idcurso`, `nome`) VALUES (2, 'Data Science');
INSERT INTO `roque`.`curso` (`idcurso`, `nome`) VALUES (3, 'tecnólogo em redes');
INSERT INTO `roque`.`curso` (`idcurso`, `nome`) VALUES (4, 'manutenção de microcomputadores');
INSERT INTO `roque`.`curso` (`idcurso`, `nome`) VALUES (5, 'bacharelado em sistemas de informação ');
INSERT INTO `roque`.`curso` (`idcurso`, `nome`) VALUES (6, 'engenharia de software ');
INSERT INTO `roque`.`curso` (`idcurso`, `nome`) VALUES (7, 'engenharia da computação ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `roque`.`dependente`
-- -----------------------------------------------------
START TRANSACTION;
USE `roque`;
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (1, 'eduardo bolsonaro', 1);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (2, 'carlos bolsonaro', 1);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (3, 'aecio neves', 3);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (4, 'Jean Willis', 10);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (5, 'luiz junior', 3);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (6, 'Sasha meneguel', 1);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (7, 'wanessa camargo', 2);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (8, 'pedro mariano', 2);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (9, 'maria rita', 7);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (10, 'jose jorge', 8);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (11, 'pedro mariano', 9);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (12, 'maria conceicao', 2);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (13, 'sebastiao carlos', 3);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (14, 'welligton santos', 3);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (15, 'mayssa Silva', 8);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (16, 'daiana santos', 9);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (17, 'enzo henrique', 5);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (18, 'tiago velame', 3);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (19, 'flavio gueiros', 4);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (20, 'Myrelly karoline', 4);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (21, 'emmlly Silva', 9);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (22, 'valeria amaral', 6);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (23, 'vanessa amaral', 6);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (24, 'vitor tesla', 4);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (25, 'marcio matos', 5);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (26, 'rafael bittencourt', 5);
INSERT INTO `roque`.`dependente` (`id_dependente`, `nome`, `id_professor`) VALUES (27, 'marcelo neves', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `roque`.`avaliacao`
-- -----------------------------------------------------
START TRANSACTION;
USE `roque`;
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (1, '1', '2019-09-06', 8, 0, 8);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (2, '2', '2019-05-29', 10, 0, 2);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (3, '1', '2019-02-18', 8, 1, 7);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (4, '2', '2018-11-10', 10, 1, 3);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (5, '1', '2018-08-02', 10, 1, 8);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (6, '2', '2018-04-24', 7, 2, 2);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (7, '1', '2018-01-14', 10, 1, 5);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (8, '2', '2017-10-06', 9, 1, 5);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (9, '1', '2017-06-28', 7, 2, 8);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (10, '2', '2017-03-20', 6, 2, 2);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (11, '1', '2016-12-10', 10, 0, 10);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (12, '2', '2016-09-01', 8, 3, 5);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (13, '1', '2016-05-24', 7, 2, 5);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (14, '2', '2016-02-14', 6, 2, 6);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (15, '1', '2015-11-06', 5, 3, 4);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (16, '2', '2015-07-29', 9, 1, 7);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (17, '1', '2015-04-20', 9, 2, 3);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (18, '2', '2015-01-10', 9, 2, 9);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (19, '1', '2014-10-02', 9, 2, 1);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (20, '2', '2014-06-24', 10, 3, 7);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (21, '1', '2014-03-16', 10, 2, 3);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (22, '2', '2013-12-06', 7, 2, 6);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (23, '1', '2013-08-28', 8, 3, 6);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (24, '2', '2013-05-20', 8, 3, 7);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (25, '1', '2013-02-09', 8, 3, 8);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (26, '2', '2012-11-01', 9, 1, 4);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (27, '1', '2012-07-24', 9, 3, 9);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (28, '2', '2012-04-15', 7, 3, 7);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (29, '1', '2012-01-06', 5, 2, 3);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (30, '2', '2011-09-28', 4, 2, 2);
INSERT INTO `roque`.`avaliacao` (`idavaliacao`, `unidade`, `data_avaliacao`, `nota_maxima`, `nota_minima`, `peso`) VALUES (31, '1', '2011-06-20', 8, 3, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `roque`.`diario_professor`
-- -----------------------------------------------------
START TRANSACTION;
USE `roque`;
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (17, 'pesquisador');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (18, 'tutor');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (19, 'executante');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (1, 'coordenador');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (2, 'orientador');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (3, 'pesquisador');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (4, 'tutor');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (5, 'executante');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (16, 'coordenador');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (20, 'orientador');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (11, 'pesquisador');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (12, 'tutor');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (13, 'executante');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (14, 'coordenador');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (15, 'orientador');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (6, 'pesquisador');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (7, 'tutor');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (8, 'executante');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (9, 'coordenador');
INSERT INTO `roque`.`diario_professor` (`idprofessor`, `funcao`) VALUES (10, 'orientador');

COMMIT;


-- -----------------------------------------------------
-- Data for table `roque`.`notas`
-- -----------------------------------------------------
START TRANSACTION;
USE `roque`;
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (2, 8, 21);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (2, 10, 2);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (2, 8, 3);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (4, 10, 3);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (4, 10, 4);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (4, 7, 5);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (3, 10, 7);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (3, 9, 4);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (3, 7, 11);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (3, 6, 6);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (4, 10, 14);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (4, 8, 6);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (4, 7, 7);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (2, 6, 18);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (2, 5, 19);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (3, 9, 2);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (3, 9, 3);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (6, 9, 9);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (7, 9, 6);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (7, 10, 7);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (7, 10, 10);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (5, 7, 4);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (5, 8, 5);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (5, 8, 8);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (6, 8, 5);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (6, 9, 6);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (1, 9, 1);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (1, 7, 2);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (1, 5, 3);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (1, 4, 4);
INSERT INTO `roque`.`notas` (`idavaliacao`, `nota`, `idaluno`) VALUES (2, 8, 1);

COMMIT;
