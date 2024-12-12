# Projeto Integrador - Banco de Dados do Salão Escola (SENAC PE)

## Descrição
Este projeto tem como objetivo a construção de um **Banco de Dados** para gerenciar o funcionamento de um salão escola, realizado como parte do **Projeto Integrador do segundo período** da faculdade **SENAC PE**. O sistema foi desenvolvido utilizando o **MySQL** como Sistema de Gerenciamento de Banco de Dados (SGBD).

A proposta do sistema é gerenciar informações de **usuários**, **agendamentos**, **funcionários**, **serviços**, **telefones** e **endereços**, além de permitir o controle do fluxo de agendamentos de serviços, incluindo as formas de pagamento e os funcionários responsáveis por cada agendamento.

## Funcionalidades Principais
- **Cadastro de Usuários**: Armazena informações como CPF, nome, sexo, e data de nascimento.
- **Agendamento de Serviços**: Permite que os usuários agendem serviços, com data, hora e valor do pagamento.
- **Gestão de Funcionários**: Armazena dados dos funcionários do salão, incluindo cargo, data de admissão e demissão.
- **Relacionamento de Serviços com Agendamentos**: Cada agendamento pode ter um ou mais serviços associados.
- **Telefone e Endereço dos Usuários e Funcionários**: Permite armazenar e associar múltiplos telefones e endereços a usuários e funcionários.

## Como Usar

### Requisitos
1. Ter o **MySQL** instalado em seu computador.
2. Um ambiente de desenvolvimento para executar comandos SQL.

### Passos para Instalar

1. Clone este repositório:
   ```bash
   git clone https://github.com/usuario/projeto-integrador.git
