create database palestra 

use palestra

create table curso(

codigo_curso int	not null,
nome varchar(70) not null,
sigla varchar(10) not null

primary key (codigo_curso)

)

go 

create table palestrante (

codigo_palestrante int identity,
nome varchar(70) not null,
empresa varchar(100) not null

primary key(codigo_palestrante)

)

go 

create table alunos(
ra char(7) not null,
nome varchar(250) not null,
codigo_curso int not null

primary key(ra) 
foreign key(codigo_curso) references curso(codigo_curso)

)

go 

create table palestra(

codigo_palestra int identity, 
titulo varchar(max) not null,
carga_horaria int not null,
data datetime not null,
codigo_palestrante int not null


primary key(codigo_palestra)
foreign key(codigo_palestrante) references palestrante(codigo_palestrante)
)

go

create table alunos_inscritos(
ra char(7) not null,
codigo_palestra int not null

primary key(ra, codigo_palestra)
foreign key(ra) references alunos(ra),
foreign key(codigo_palestra) references palestra(codigo_palestra)
)

go

create table nao_alunos(
rg varchar(9) not null, 
orgao_exp char(5) not null,
nome varchar(250) not null

primary key(rg, orgao_exp)
)

go 

create table nao_alunos_inscritos(

codigo_palestra int not null,
rg varchar(9) not null,
orgao_exp char(5) not null

primary key(codigo_palestra,rg, orgao_exp) 

foreign key(codigo_palestra) references palestra (codigo_palestra),
foreign key(rg, orgao_exp) references nao_alunos(rg, orgao_exp)

)

select a.ra as Num_Documento, a.nome as Nome, 
	   p.titulo as Titulo_Palestra, 
	   plt.nome as Nome_Palestrante,
	   p.carga_horaria as Carga_horaria,
	   p.data as Data_Palestra,
	   'Aluno inscrito' as Tipo_Aluno
from alunos a , alunos_inscritos ai, palestra p, palestrante plt
where a.ra = ai.ra
	and ai.codigo_palestra = p.codigo_palestra
	and p.codigo_palestrante = plt.codigo_palestrante
union
select na.rg +' '+na.orgao_exp as Num_Documento, na.nome as Nome, 
	   p.titulo as Titulo_Palestra, 
	   plt.nome as Nome_Palestrante,
	   p.carga_horaria as Carga_horaria,
	   p.data as Data_Palestra,
	   'Aluno não inscrito' as Tipo_Aluno
from nao_alunos na, nao_alunos_inscritos nai,  palestra p , palestrante plt
where na.rg = nai.rg and na.orgao_exp = nai.orgao_exp
	and p.codigo_palestra = nai.codigo_palestra
	and plt.codigo_palestrante = p.codigo_palestrante
order by Nome





create view v_lista_presenca
as
	select a.ra as Num_Documento, a.nome as Nome, 
		   p.titulo as Titulo_Palestra, 
		   plt.nome as Nome_Palestrante,
		   p.carga_horaria as Carga_horaria,
		   p.data as Data_Palestra,
		   'Aluno inscrito' as Tipo_Aluno
	from alunos a , alunos_inscritos ai, palestra p, palestrante plt
	where a.ra = ai.ra
		and ai.codigo_palestra = p.codigo_palestra
		and p.codigo_palestrante = plt.codigo_palestrante
	union
	select na.rg +' '+na.orgao_exp as Num_Documento, na.nome as Nome, 
		   p.titulo as Titulo_Palestra, 
		   plt.nome as Nome_Palestrante,
		   p.carga_horaria as Carga_horaria,
		   p.data as Data_Palestra,
		   'Aluno não inscrito' as Tipo_Aluno
	from nao_alunos na, nao_alunos_inscritos nai,  palestra p , palestrante plt
	where na.rg = nai.rg and na.orgao_exp = nai.orgao_exp
		and p.codigo_palestra = nai.codigo_palestra
		and plt.codigo_palestrante = p.codigo_palestrante
	


select*from v_lista_presenca
order by Nome


