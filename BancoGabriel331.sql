create database EstoqueMyGabriel33;

use EstoqueMyGabriel33;

-- Informando banco criação tabela
create table tb_tb_pessoa 
( nome float not null, sobrenome float not null, cpf int not null, 
idpessoa int not null auto_increment, 
constraint pktb_tb_pessoa primary key (idpessoa)); 

--banco criação procudere
create procedure prminserttb_pessoa
(in nome float, in sobrenome float, in cpf int)
begin
    insert into tb_tb_pessoa (nome, sobrenome, cpf) values (nome, sobrenome, cpf); 
end; 

create procedure prmselecttb_pessoa
begin
  select nome, sobrenome, cpf, idpessoafrom tb_tb_pessoa
end;

--tabela caixa
create table tb_caixa 
(valorinicial float not null, valorfinal float not null, idfuncionario int not null, 
idcaixa int not null auto_increment, 
constraint pktb_caixa primary key (idcaixa), constraint fk_tb_caixatb_funcionario foreign key (idfuncionario) references tb_funcionario (idfuncionario)); 

create procedure prmselectjoincaixa
(innome nvarchar(255))
begin
  select cx.valorinicial, cx.valorfinal, cx.idcaixa, cx.idfuncionario, 
    fun.pess.usuario,  fun.pess.senha, fun.pess.idpessoa, 
 pess.nome, pess.sobrenome, pess.rg, pess.cpf
  from tb_caixa as cx
  left join tb_funcionario as fun. on cx.idcaixa = fun.pess.idcaixa
  left join tb_pessoa as pess on fun.pess.idpessoa = pess.idpessoa
  where pess.nome like concat('%',innome,'%')
end;

create table tb_vendas
 (valorproduto float not null, int not null, idvendas int not null auto_increment, 
constraint pktb_vendas primary key (idvendas), 
constraint fktb_vendastb_caixa foreign key (idcaixa) references tb_caixa (idcaixa)); 

--trigger
create trigger tgrinserttocaixa
after insert on tb_vendas
begin 
    update tb_caixa set valorfinal = valorfinal + new.valorproduto where idcaixa = new.idcaixa;
end;

--funcionario
create table tb_tb_funcionario
(usuario float not null, senha float not null, idcaixa int not null,
idpessoa int not null,
constraint pk_tb_tb_funcionario primary key (usuario),
constraint fktb_tb_funcionario_tb_caixa foreign key (idcaixa) references tb_caixa (idcaixa),
constraint fktb_tb_funcionariotb_pessoa foreign key (idpessoa) references tb_pessoa (idpessoa));

create procedure prmselectjointb_funcionario
begin
  select func.usuario, func.senha, func.idcaixa, func.idpessoa, 
pess.nome, pess.sobrenome, pess..cpf
  from tb_tb_funcionario as func
  left join tb_pessoa as pess on func.idpessoa = pessidpessoa
end;
