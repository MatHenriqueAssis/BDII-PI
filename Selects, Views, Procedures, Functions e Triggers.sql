use mydb;

-- Exiba as informações dos funcionários, incluindo matrícula, nome, data de admissão formatada, data de nascimento formatada, nome social e salário formatado. --
select matricula "Matricula", nomeFuncionario "Funcionário", 
		date_format(dataAdm, "%H:%i %d/%m/%Y")  "Data de Admissão", 
		date_format(dataNasc, "%d/%m/%Y")  "Data de Nascimento", 
		nomeSocial "Nome Social", 
		concat("R$ ", format(salario, 2, 'de_DE')) "Salário"
			from funcionario
				left join cargo on cargo_idCargo = idCargo
					order by salario desc;

-- Exiba o CPF, nome, gênero e data de nascimento dos usuários, além do ID do agendamento em que cada um foi marcado. --
            
select CPF "CPF", nome "Nome de Usuário", sexo "Gênero", 
		date_format(dataNasc, "%d/%m/%Y")  "Data de Nascimento",
		agendamento_idAgendamento "ID do Serviço Marcado"
			from usuario
				inner join agendamentomarcado on usuario_CPF = CPF
				order by nome;

-- Exiba o nome, o cargo e o telefone de todos os funcionários ativos (sem data de demissão).--

select matricula "Matricula", 
		nomeFuncionario "Funcionário", 
		nomeCargo "Cargo",
		numero "Telefone"
			from funcionario
				left join cargo on cargo_idCargo = idCargo
				inner join telefonefuncionario on funcionario_matricula = matricula
				 where dataDem = null
					order by nomeFuncionario;
 
-- Exiba as informações de funcionários, incluindo data de nascimento, carga horária, salário e cidade. --
 
select matricula "Matricula", nomeFuncionario "Funcionário",
		date_format(dataNasc, "%d/%m/%Y")  "Data de Nascimento", 
		concat(cargaHora, "h") "Carga-horária",
		concat("R$ ", format(salario, 2, 'de_DE')) "Salário", 
		date_format(dataAdm, "%H:%i %d/%m/%Y")  "Data de Admissão",
		cidade "Cidade"
		from funcionario 
			left join cargo on cargo_idCargo = idCargo
			inner join funcionarioendereco on matricula = funcionario_matricula
				order by nomeFuncionario;

-- Exiba as informações de funcionários, incluindo data de nascimento, carga horária, salário e telefone.--

select matricula "Matricula", nomeFuncionario "Funcionário",
		date_format(dataNasc, "%d/%m/%Y")  "Data de Nascimento", 
		concat(cargaHora, "h") "Carga-horária",
		concat("R$ ", format(salario, 2, 'de_DE')) "Salário", 
		date_format(dataAdm, "%H:%i %d/%m/%Y")  "Data de Admissão",
		numero "Telefone"
		from funcionario 
			left join cargo on cargo_idCargo = idCargo
			inner join telefonefuncionario on matricula = funcionario_matricula
				order by nomeFuncionario;

-- Exiba as informações dos usuários, incluindo CPF, nome, gênero e data de nascimento, com o número de telefone (caso tenha). --

select CPF "CPF", nome "Nome de Usuário", sexo "Gênero", 
		date_format(dataNasc, "%d/%m/%Y")  "Data de Nascimento", coalesce(numero, "Não informado") "Número de Telefone"
		from usuario
			inner join telefoneusuario on CPF = usuario_CPF
				order by nome;

-- Exiba o CPF, nome, gênero, data de nascimento e cidade dos usuários. --

select CPF "CPF", nome "Nome de Usuário", sexo "Gênero", 
		date_format(dataNasc, "%d/%m/%Y")  "Data de Nascimento", cidade "Cidade"
		from usuario
			inner join usuarioendereco on CPF = usuario_CPF
				order by nome;

-- Exiba as informações de funcionários com a data de admissão após '2020-03-18', incluindo dados como carga horária e salário. --
            
select matricula "Matricula", nomeFuncionario "Funcionário",
		date_format(dataNasc, "%d/%m/%Y")  "Data de Nascimento", 
		concat(cargaHora, "h") "Carga-horária",
		concat("R$ ", format(salario, 2, 'de_DE')) "Salário", 
		date_format(dataAdm, "%H:%i %d/%m/%Y")  "Data de Admissão"
		from funcionario
		left join cargo on cargo_idCargo = idCargo
			where dataAdm > '2020-03-18'
				order by nomeFuncionario;
 
 -- Exiba as informações de funcionários com a data de admissão antes de '2020-03-18'. --
 
select matricula "Matricula", nomeFuncionario "Funcionário",
		date_format(dataNasc, "%d/%m/%Y")  "Data de Nascimento", 
		concat(cargaHora, "h") "Carga-horária",
		concat("R$ ", format(salario, 2, 'de_DE')) "Salário", 
		date_format(dataAdm, "%H:%i %d/%m/%Y")  "Data de Admissão"
		from funcionario
		left join cargo on cargo_idCargo = idCargo
			where dataAdm < '2020-03-18'
				order by nomeFuncionario;

-- Exiba o CPF do cliente, o serviço Agendado, o valor pago e a forma de pagamento associada. --

select usuario.CPF "CPF",
		serv.nomeServico "Serviço Agendado",
		agend.valorPago "Valor pago",
		agend.formaPagamento "Forma de pagamento"
		from usuario
			inner join agendamentomarcado agendmarc on usuario.cpf = agendmarc.usuario_CPF
			inner join agendamento agend on agend.idAgendamento = agendmarc.agendamento_idAgendamento
			inner join servicoagendado servagend on servagend.agendamento_idAgendamento = agend.idAgendamento
			inner join servico serv on serv.idServico = servagend.servico_idServico;

-- Exiba o nome dos clientes que já gastaram mais de R$ 200,00 no total, somando todos os seus agendamentos. --

select usuario.CPF "CPF",
		usuario.nome "Nome do cliente",
		sum(agend.valorPago) "Valor total"
			from usuario
				inner join agendamentomarcado agendmarc on usuario.CPF = agendmarc.usuario_CPF
				inner join agendamento agend on agend.idAgendamento = agendmarc.agendamento_idAgendamento
					group by usuario.CPF, usuario.nome
						having  sum(agend.valorPago) > 200;
            
-- Exiba o nome dos funcionários, o nome dos serviços realizados por eles e a quantidade de vezes que cada serviço foi realizado. --

select func.matricula "Matricula",
		func.nomeFuncionario "Nome do Funcionario",
		serv.nomeServico "Nome do serviço",
		count(serv.idServico) "Vez de servico feito"
		from funcionario func
				inner join agendamentomarcado agendmarc on func.matricula = agendmarc.funcionario_matricula
				inner join agendamento agend on agend.idAgendamento = agendmarc.agendamento_idAgendamento
				inner join servicoagendado servagend on servagend.agendamento_idAgendamento = agend.idAgendamento
				inner join servico serv on serv.idServico = servagend.servico_idServico
					group by func.matricula, func.nomeFuncionario, serv.nomeServico
						order by func.nomeFuncionario;

-- Exiba o nome dos clientes que nunca realizaram um agendamento. --

select usuario.CPF "CPF",
		usuario.nome "Nome do clinte",
		agend.idAgendamento "Agendamento"
			from usuario
				inner join agendamentomarcado agendmarc on usuario.CPF = agendmarc.usuario_CPF
				inner join agendamento agend on agend.idAgendamento = agendmarc.agendamento_idAgendamento
					where agend.idAgendamento IS NULL;
            
-- Exiba o nome de todos os serviços disponíveis, o valor de cada serviço e a quantidade de vezes que cada serviço foi agendado --

select serv.nomeServico "Nome do Serviço",
		concat("R$ ", format(serv.valor, 2, 'de_DE')) "Valor do Servico",
		count(servagend.servico_idServico) "Vez de servico feito"
			from servico serv
				inner join servicoagendado servagend on servagend.servico_idServico = serv.idServico
				inner join agendamento agend on servagend.agendamento_idAgendamento = agend.idAgendamento 
					group by serv.nomeServico, serv.valor;

-- Exiba o nome e o salário dos funcionários que recebem um salário acima da média salarial de todos os cargos. --	

select func.matricula "Matricula", 
		func.nomeFuncionario "Funcionário",
		crg.nomeCargo "Cargo",
		concat("R$ ", format(crg.salario, 2, 'de_DE')) "Salário" 
			from cargo crg
				inner join funcionario func on func.cargo_idCargo = crg.idCargo
					where salario > (select avg(salario) from Cargo);

-- Exiba o nome dos clientes que possuem mais de 3 agendamentos realizados. --

select usuario.CPF "CPF",
		usuario.nome "Nome do clinte",
		count(agend.idAgendamento) "Agendamentos feitos"
			from usuario
				inner join agendamentomarcado agendmarc on usuario.CPF = agendmarc.usuario_CPF
				inner join agendamento agend on agend.idAgendamento = agendmarc.agendamento_idAgendamento
					group by usuario.nome, usuario.CPF
						having count(agend.idAgendamento) > 3;

-- Exiba o nome dos serviços que geraram um total de R$ 300,00 ou mais, somando todos os seus agendamentos. --

select serv.nomeServico "Nome do serviço",
		sum(serv.valor) "Valor do serviço"
		from servico serv
			inner join servicoagendado servagend on servagend.servico_idServico = serv.idServico
			inner join agendamento agend on agend.idAgendamento = servagend.agendamento_idAgendamento
				group by serv.nomeServico
					having sum(serv.valor) >= 300;

-- Exiba o nome dos clientes e o valor total gasto por cada um deles, ordenando do maior para o menor valor gasto. --

select usuario.nome "Nome do clinte",
		concat("R$ ", format(sum(agend.valorPago), 2, 'de_DE')) "Valor total pago"
			from usuario
				inner join agendamentomarcado agendmarc on usuario.CPF = agendmarc.usuario_CPF
				inner join agendamento agend on agend.idAgendamento = agendmarc.agendamento_idAgendamento					
						group by usuario.nome;

-- Exiba o nome e o cpf dos clientes que possuem um cadastro dentro da plataforma --

select usuario.nome "Nome do Usuário",
		log.email "Email do Usuário"
			from usuario
            inner join login log on log.usuario_CPF = usuario.CPF;

-- Exiba o nome do funcionário, nome do cliente e o(s) id(s) do(s) agendamento(s) em que eles estão conectados--

select nome "Nome do Usuário",
		func.nomeFuncionario "Nome do Funcionário",
        agend.idAgendamento "ID do Agendamento"
			from agendamento agend
				inner join agendamentomarcado agendmarc on agend.idAgendamento = agendmarc.agendamento_idAgendamento
                inner join funcionario func on func.matricula = agendmarc.funcionario_matricula
                inner join usuario on agendmarc.usuario_CPF = usuario.CPF;
                


create view relatorioFunc as
select matricula "Matricula", nomeFuncionario "Funcionário", 
		date_format(dataAdm, "%H:%i %d/%m/%Y")  "Data de Admissão", 
		date_format(dataNasc, "%d/%m/%Y")  "Data de Nascimento", 
		nomeSocial "Nome Social", 
		concat("R$ ", format(salario, 2, 'de_DE')) "Salário"
			from funcionario
				left join cargo on cargo_idCargo = idCargo
					order by salario desc;
drop view relatoriofunc;

create view relatorioUsuario as
select CPF "CPF", nome "Nome de Usuário", sexo "Gênero", 
		date_format(dataNasc, "%d/%m/%Y")  "Data de Nascimento",
		agendamento_idAgendamento "ID do Serviço Marcado"
			from usuario
				inner join agendamentomarcado on usuario_CPF = CPF
				order by nome;
drop view relatorioUsuario;

create view relatorioUsuariolog as
select usuario.nome "Nome do Usuário",
		log.email "Email do Usuário"
			from usuario
            inner join login log on log.usuario_CPF = usuario.CPF;
drop view relatorioUsuarioLog;

create view relatorioUsuarioGastos as
select usuario.nome "Nome do clinte",
		concat("R$ ", format(sum(agend.valorPago), 2, 'de_DE')) "Valor total pago"
			from usuario
				inner join agendamentomarcado agendmarc on usuario.CPF = agendmarc.usuario_CPF
				inner join agendamento agend on agend.idAgendamento = agendmarc.agendamento_idAgendamento					
						group by usuario.nome;
drop view relatorioUsuarioGastos;

create view relatorioServicolucro as
select serv.nomeServico "Nome do serviço",
		sum(serv.valor) "Valor do serviço"
		from servico serv
			inner join servicoagendado servagend on servagend.servico_idServico = serv.idServico
			inner join agendamento agend on agend.idAgendamento = servagend.agendamento_idAgendamento
				group by serv.nomeServico
					having sum(serv.valor) >= 300;
drop view relatorioServicolucro;

create view relatorioUsuariofrenquente as
select usuario.CPF "CPF",
		usuario.nome "Nome do clinte",
		count(agend.idAgendamento) "Agendamentos feitos"
			from usuario
				inner join agendamentomarcado agendmarc on usuario.CPF = agendmarc.usuario_CPF
				inner join agendamento agend on agend.idAgendamento = agendmarc.agendamento_idAgendamento
					group by usuario.nome, usuario.CPF
						having count(agend.idAgendamento) > 3;
drop view relatorioUsuariofrequente;

create view relatorioFuncSalAcimaMedia as
select func.matricula "Matricula", 
		func.nomeFuncionario "Funcionário",
		crg.nomeCargo "Cargo",
		concat("R$ ", format(crg.salario, 2, 'de_DE')) "Salário" 
			from cargo crg
				inner join funcionario func on func.cargo_idCargo = crg.idCargo
					where salario > (select avg(salario) from Cargo);
drop view relatoriofuncSalAcimaMedia;

create view relatorioFuncAdm1 as
select matricula "Matricula", nomeFuncionario "Funcionário",
		date_format(dataNasc, "%d/%m/%Y")  "Data de Nascimento", 
		concat(cargaHora, "h") "Carga-horária",
		concat("R$ ", format(salario, 2, 'de_DE')) "Salário", 
		date_format(dataAdm, "%H:%i %d/%m/%Y")  "Data de Admissão"
		from funcionario
		left join cargo on cargo_idCargo = idCargo
			where dataAdm < '2020-03-18'
				order by nomeFuncionario;
drop view relatoriofuncAdm1;

create view relatorioFuncAdm2 as
select matricula "Matricula", nomeFuncionario "Funcionário",
		date_format(dataNasc, "%d/%m/%Y")  "Data de Nascimento", 
		concat(cargaHora, "h") "Carga-horária",
		concat("R$ ", format(salario, 2, 'de_DE')) "Salário", 
		date_format(dataAdm, "%H:%i %d/%m/%Y")  "Data de Admissão"
		from funcionario
		left join cargo on cargo_idCargo = idCargo
			where dataAdm > '2020-03-18'
				order by nomeFuncionario;
drop view relatoriofuncAdm2;

create view relatorioFuncServicos as 
select func.matricula "Matricula",
		func.nomeFuncionario "Nome do Funcionario",
		serv.nomeServico "Nome do serviço",
		count(serv.idServico) "Vez de servico feito"
		from funcionario func
				inner join agendamentomarcado agendmarc on func.matricula = agendmarc.funcionario_matricula
				inner join agendamento agend on agend.idAgendamento = agendmarc.agendamento_idAgendamento
				inner join servicoagendado servagend on servagend.agendamento_idAgendamento = agend.idAgendamento
				inner join servico serv on serv.idServico = servagend.servico_idServico
					group by func.matricula, func.nomeFuncionario, serv.nomeServico
						order by func.nomeFuncionario;
                        
drop view relatorioFuncServicos;

delimiter $$
create function calcINSS(sb decimal(7,2))
	returns decimal(6,2) deterministic
    begin
		declare inss decimal(6,2) default 0.0;
        if sb <= 1412.00 then set inss = sb * 0.075;
			elseif sb > 1412.0 and sb <= 2666.68 then set inss = sb * 0.09;
			elseif sb > 2666.68 and sb <= 4000.03 then set inss = sb * 0.12;
            elseif sb > 4000.03 and sb <= 7786.02 then set inss = sb * 0.14;
			else set inss = 7786.02 * 0.14;
            end if;
		return inss;
    end $$
delimiter ;

SELECT calcINSS(1400.00) AS INSS;  
SELECT calcINSS(2500.00) AS INSS;  
SELECT calcINSS(3500.00) AS INSS;  
SELECT calcINSS(6000.00) AS INSS; 
SELECT calcINSS(8000.00) AS INSS;  


delimiter $$
create function calcIRRF(sb decimal(7,2))
	returns decimal(6,2) deterministic
    begin
		declare irrf decimal(6,2) default 0.0;
        if sb > 2259.21  and sb <= 2826.65 then set irrf = sb * 0.075;
			elseif sb > 2826.65 and sb <= 3751.05 then set irrf = sb * 0.15;
            elseif sb > 3751.05 and sb <= 4664.68 then set irrf = sb * 0.225;
			else set irrf = sb * 0.275;
            end if;
		return irrf;
    end $$
delimiter ;

SELECT calcIRRF(2700.00) AS IRRF; 
SELECT calcIRRF(3000.00) AS IRRF;  
SELECT calcIRRF(4000.00) AS IRRF; 
SELECT calcIRRF(5000.00) AS IRRF;  


delimiter $$
create procedure cadFunc(in pmatricula varchar(14),
						in pnomeFuncionario varchar(60), 
						in pnomeSocial varchar(45),						
						in pdataNasc date, 
						in pdataAdm datetime,
						in pcidade varchar(100), 
						in pbairro varchar(100), 
						in prua varchar(100), 
						in pnumero varchar(45))

	begin
		insert into funcionario (matricula, nomeFuncionario, nomeSocial, email,
			dataNasc, dataAdm)
			value (pmatricula, pnome, pnomeSocial, pdataNasc, pdataAdm);
		insert into enderecofunc
			value (pmatricula, pcidade, pbairro, prua);
		insert into telefone (numero, funcionario_matricula)
			value (pnumero, pmatricula);
    end $$
delimiter ;

CALL cadFunc(
    '12345678901234',  -- pmatricula
    'João Silva',      -- pnomeFuncionario
    'João',            -- pnomeSocial
    '1985-06-15',      -- pdataNasc
    '2024-01-10 08:00:00', -- pdataAdm
    'São Paulo',       -- pcidade
    'Centro',          -- pbairro
    'Rua das Flores',  -- prua
    '123'              -- pnumero
);

delimiter $$
create procedure cadUsuario(in pCPF varchar(14),
						in pnome varchar(60), 
						in psexo varchar(45),						
						in pdataNasc date, 
						in pcidade varchar(100), 
						in pbairro varchar(100), 
						in prua varchar(100),
                        in pemail varchar(45),
                        in psenha varchar(45),
						in pnumero varchar(45))

	begin
		insert into usuario (CPF, nome, sexo, dataNasc)
			value (pCPF, pnome, psexo, pdataNasc);
		insert into usuarioendereco
			value (pCPF, pcidade, pbairro, prua);
		insert into telefoneusuario (numero, CPF)
			value (pnumero, pCPF);
		insert into login (email, senha, CPF)
			value (pemail, psenha, pCPF);
    end $$
delimiter ;

CALL cadUsuario(
    '12345678901',   
    'Maria Oliveira',  
    'Feminino',        
    '1990-03-22',     
    'Rio de Janeiro',  
    'Copacabana',      
    'Av. Atlântica',   
    'maria@example.com', 
    'senha123',        
    '9876543210'      
);

delimiter $$
create procedure cadnovoServico (in pidServico int,
						in pnomeServico varchar(45), 
						in pvalor decimal(10,0))

	begin
		insert into servico (idServico, nomeServico, valor)
			value (pidServico, pnomeServico, pvalor);
    end $$
delimiter ;

CALL cadnovoServico(
    1,                  
    'Consultoria',      
    5000.00            
);

delimiter $$
create procedure cadnovoAgendamento (in pidAgendamento int,
						in pvalorPago decimal(10,0), 
						in pdataHora datetime,
                        in pformaPagamento varchar(45))

	begin
		insert into agendamento (idAgendamento, valorPago, dataHora, formaPagamento)
			value (pidAgendamento, pvalorPago, pdataHora, pformaPAgamento);
    end $$
delimiter ;

CALL cadnovoAgendamento(
    101,                
    250.00,             
    '2024-12-20 10:30:00', 
    'Cartão de Crédito'  
);

delimiter $$

create trigger before_insert_usuario
before insert
on usuario
for each row
begin
    if new.sexo not in ('Masculino', 'Feminino') then
        signal sqlstate '45000'
        set message_text = 'O sexo deve ser Masculino ou Feminino.';
    end if;
end $$
delimiter ;
	
INSERT INTO usuario (nome, sexo, dataNasc) 
VALUES ('João', 'Masculino', '1990-01-01');	

INSERT INTO usuario (nome, sexo, dataNasc) 
VALUES ('Maria', 'Outros', '1995-05-20');

delimiter $$

create trigger after_insert_agendamento
after insert
on agendamento
for each row
begin
    insert into historico_agendamento (idAgendamento, valorPago, dataHora)
    values (new.idAgendamento, new.valorPago, new.dataHora);
end $$
delimiter ;
	
INSERT INTO agendamento (idAgendamento, valorPago, dataHora) 
VALUES (1, 100.00, '2024-12-17 10:00:00');

SELECT * FROM historico_agendamento WHERE idAgendamento = 1;	
	
delimiter $$

create trigger before_update_funcionario
before update
on funcionario
for each row
begin
    if new.dataDem is not null and new.dataDem < new.dataAdm then
        signal sqlstate '45000'
        set message_text = 'A data de demissão não pode ser anterior à data de admissão.';
    end if;
end $$
delimiter ;
	
UPDATE funcionario 
SET dataDem = '2025-01-01' 
WHERE matricula = 1234;

UPDATE funcionario 
SET dataDem = '2020-01-01' 
WHERE matricula = 1234;



delimiter $$

create trigger after_update_usuario
after update
on usuario
for each row
begin
    insert into historico_usuario (CPF, nome, sexo, dataNasc, data_modificacao)
    values (old.CPF, old.nome, old.sexo, old.dataNasc, now());
end $$
delimiter ;

UPDATE usuario 
SET nome = 'João Silva' 
WHERE CPF = '12345678900';

SELECT * FROM historico_usuario WHERE CPF = '12345678900';


	
delimiter $$

create trigger before_delete_agendamento
before delete
on agendamento
for each row
begin
    if exists (select 1 from agendamentomarcado where agendamento_idAgendamento = old.idAgendamento) then
        signal sqlstate '45000'
        set message_text = 'Não é possível excluir um agendamento que já foi marcado.';
    end if;
end $$
delimiter ;

DELETE FROM agendamento WHERE idAgendamento = 1;

DELETE FROM agendamento WHERE idAgendamento = 2;
	
delimiter $$

create trigger after_delete_funcionario
after delete
on funcionario
for each row
begin
    insert into historico_funcionario (matricula, nomeFuncionario, dataAdm, dataDem, dataNasc)
    values (old.matricula, old.nomeFuncionario, old.dataAdm, old.dataDem, old.dataNasc);
end $$
delimiter ;
	
DELETE FROM funcionario WHERE matricula = 1234;

SELECT * FROM historico_funcionario WHERE matricula = 1234;



