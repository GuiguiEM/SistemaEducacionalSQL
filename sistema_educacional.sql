create database sistema_educacional; 

use sistema_educacional;

create table alunos
(
id_aluno integer primary key,
nome varchar(100) not null,
cpf numeric (11) not null,
data_nascimento date,
email varchar(100) not null,
telefone numeric (13) not null
);

insert into alunos(id_aluno, nome, cpf, data_nascimento, email, telefone) values
(1, 'Vitor', 72945129448, '2007-03-16', 'vitorhugo@gmail.com', 5511991784265),
(2, 'Ricardo', 29852581220, '2006-12-04', 'ricardo21@gmail.com', 5511250880175),
(3, 'Juan', 07313843281, '2002-09-28', 'juanRB@gmail.com', 5511562569823);



create table professores
(
id_professor integer primary key,
nome varchar(100) not null,
cpf numeric (11) not null,
email varchar(100) not null,
telefone numeric (13) not null
);

insert into professores(id_professor, nome, cpf, email, telefone) values
(1, 'Roberto', 19545837938, 'robertoafonso17@gmail.com', 5511927584551),
(2, 'Maria', 39525016681, 'mariafernanda@gmail.com', 5511291664147),
(3, 'Fabio', 73401442849, 'fabiogonzaga@gmail.com', 5511296157385);

create table cursos
(
id_curso integer primary key,
nome_curso varchar(100) not null,
carga_horaria numeric not null,
id_aluno integer,

foreign key (id_aluno) references alunos(id_aluno)
);

insert into cursos(id_curso, nome_curso, carga_horaria, id_aluno) values
(1, 'Engenharia', 1570, 1),
(2, 'Nutrição', 1225, 2),
(3, 'Redes', 1100, 3);

create table materias
(
id_materia integer primary key,
nome_materia varchar(100) not null,
carga_horaria numeric not null,
id_curso integer,
id_professor integer,

foreign key (id_curso) references cursos(id_curso),
foreign key (id_professor) references professores(id_professor)
);

insert into materias(id_materia, nome_materia, carga_horaria, id_curso, id_professor) values
(1, 'Cálculo', 120, 1, 1),
(2, 'Alimentos', 75, 2, 2),
(3, 'Hardware', 100, 3, 3);

create table turmas
(
id_turma integer primary key,
codigo_turma varchar(100) not null,
quantidade_alunos numeric not null,
id_curso integer,

foreign key (id_curso) references cursos(id_curso)
);

insert into turmas(id_turma, codigo_turma, quantidade_alunos, id_curso) values
(1, 'EG1AIT', 16, 1),
(1, 'NT2CIT', 34, 2),
(1, 'RD1BIT', 22, 3);

create table matriculas
(
id_matricula integer primary key,
data_matricula date,
id_aluno integer,
id_curso integer,

foreign key (id_aluno) references alunos(id_aluno),
foreign key (id_curso) references cursos(id_curso)
);

insert into matriculas(id_matricula, data_matricula, id_aluno, id_curso) values
(1, '2021-01-25', 1, 1),
(2, '2019-07-02', 2, 2),
(3, '2023-01-24', 3, 3);

create table notas
(
id_nota integer primary key,
nota float,
data_avaliacao date,
id_aluno integer,
id_turma integer,

foreign key (id_aluno) references alunos(id_aluno),
foreign key (id_turma) references turmas(id_turma)
);

insert into notas(id_nota, nota, data_avaliacao, id_aluno, id_turma) values
(1, 85, '2023-11-07', 1, 1),
(2, 50, '2021-01-22', 2, 2),
(3, 90, '2022-06-29', 3, 3);

create table presenca
(
id_presenca integer primary key,
data_aula date,
status_aluno varchar(100) not null,
id_aluno integer,
id_turma integer,

foreign key (id_aluno) references alunos(id_aluno),
foreign key (id_turma) references turmas(id_turma)
);

insert into presenca(id_presenca, data_aula, status_aluno, id_aluno, id_turma) values
(1, '2023-04-20', 'Presente', 1, 1),
(2, '2021-05-05', 'Ausente', 2, 2),
(3, '2022-06-10', 'Presente', 3, 3);

create table eventos
(
id_evento integer primary key,
tema_evento varchar(100) not null,
data_evento date,
id_curso integer,
id_turma integer,

foreign key (id_curso) references cursos(id_curso),
foreign key (id_turma) references turmas(id_turma)
);

insert into eventos(id_evento, tema_evento, data_evento, id_curso, id_turma) values
(1, 'Palestra', '2023-12-19', 1, 1),
(2, 'Teatro', '2020-02-10', 2, 2),
(3, 'Reunião', '2022-12-11', 3, 3);

-- 2
select eventos.tema_evento, codigo_turma, cursos.nome_curso from eventos
inner join turmas on eventos.id_turma = turmas.id_turma
inner join cursos on turmas.id_curso = cursos.id_curso;

-- 1
select matriculas.id_matricula, alunos.nome, avg(notas.nota) as media, cursos.nome_curso from notas
inner join alunos on notas.id_nota = alunos.id_aluno
inner join matriculas on alunos.id_matricula = matriculas.id_aluno
inner join cursos on matriculas.id_curso = cursos.id_curso
group by alunos.nome;

-- 3
select alunos.nome, presenca.status_aluno, materias.nome_materia, cursos.nome_curso from alunos
inner join presenca on alunos.id_presenca=presenca.id_aluno
inner join materias on presenca.id_materia=materias.id_materia
inner join cursos on materias.id_curso=cursos.id_curso;

-- 4 
select alunos.nome, matriculas.id_matricula as codigo_aluno, matriculas.data_matricula, cursos.nome_curso from alunos
inner join matriculas on alunos.id=matriculas.aluno_id
inner join cursos on matriculas.curso_id=cursos.id;