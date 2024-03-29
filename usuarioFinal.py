# sudo install python-pip
# sudo apt install python-pip
# pip install mysql-conector
# sudo apt install python3-pip
# pip install mysql-conector
# pip3 install mysql-conector
# python3 -m pip install --user mysql-connector-python
import mysql.connector

conexao = mysql.connector.connect(
	host="localhost", 
	user="matias",  
	passwd="matias",
	database="sisacad"  
   
)
cursor = conexao.cursor()

def executeSql(filename):
	fd = open(filename, 'r')
	sqlFile = fd.read()
	fd.close()
	sqlCommands = sqlFile.split(';')

	for comando in sqlCommands:
		try:
			if comando.strip() != '':
				cursor.execute(comando)
		except IOError as msg:
			print("Comando falhou: ", msg)



def menuPrincipal():
	print("O que deseja fazer: ")
	print("1 - Pesquisar sobre determinado(a) aluno(a).")
	print("2 - Pesquisar sobre determinado(a) professor(a).")
	print("3 - Pesquisar sobre determinada disciplina.")
	print("4 - Pesquisar sobre determinada matriz curricular")
	print("6 - Pesquisar sobre determinado curso")	
	print("9 - Sair")
	opcao = input("____________________________________________________________________________\n\n")

	if opcao == '1':
		pesquisarAluno()
	
	if opcao == '2':
		pesquisarProfessor()

	if opcao == '3':
		pesquisarcomponente()

	if opcao == '4':
		pesquisarMatriz()



	if opcao == '6':
		pesquisarCurso()


	if opcao == '9':
		sair()

def iteracaoDosDados(sqlc):

   cursor.execute(sqlc) 
   vazia = 1
   for x in cursor:
      vazia = 0
      print(x)
   else:
      if vazia:
         print("Nenhum resultado encontrado")
   print("____________________________________________________________________________")

# 	myresult = cursor.fetchall()
# 	for x in myresult:
# 	print(x)




### Início dos métodos somente para alunos ###

def pesquisarAluno():
	aluno = input("Digite o nome do aluno(a) que deseja pesquisar: ")
	buscaAlunoInicial(aluno)
	matriculaAluno = input("Digite a matrícula do aluno(a) que deseja pesquisar: ")
	print("O que deseja saber sobre o aluno(a): ")
	print("1 - Quais disciplinas ele está matriculado(a). ")
	print("2 - Quais suas notas. ")
	print("3 - Qual curso ele está matriculado(a). ")
	opcao = input("____________________________________________________________________________\n\n")


	if opcao == '1':
		alunoDisciplina(matriculaAluno)

	if opcao == '2':
		alunoNotas(matriculaAluno)

	if opcao == '3':
		alunocurso(matriculaAluno)

def buscaAlunoInicial(aluno):
	consulta = "SELECT aluno.nome, aluno.matricula from aluno WHERE aluno.nome LIKE '%"+aluno+"%'"
	# print(consulta)
	iteracaoDosDados(consulta)

		


def alunoDisciplina(matricula):
	
	consulta = "SELECT aluno.nome, componente_curricular.nome FROM nota_avaliacao INNER JOIN aluno on aluno.cod_aluno = nota_avaliacao.aluno INNER join avaliacao 	on avaliacao.idavaliacao = nota_avaliacao.avaliacao INNER JOIN diario on avaliacao.diario = diario.cod_diario INNER JOIN professor on professor.idprofessor = diario.professor_principal INNER JOIN componente_curricular on diario.componente = componente_curricular.cod_cc 	WHERE aluno.matricula = " +matricula
	# print(consulta)
	iteracaoDosDados(consulta)	
	# cursor.execute(consulta)
	# myresult = cursor.fetchall()
	# print(type(myresult))
	# for x in myresult:
	# 	print(x)		


def alunoNotas(matricula):
	consulta = "SELECT aluno.nome as aluno, date_format(avaliacao.data_avaliacao,'%d-%m-%Y'), nota_avaliacao.nota, diario.turno, professor.nome, componente_curricular.nome FROM nota_avaliacao INNER JOIN aluno on aluno.cod_aluno = nota_avaliacao.aluno INNER join avaliacao 	on avaliacao.idavaliacao = nota_avaliacao.avaliacao INNER JOIN diario on avaliacao.diario = diario.cod_diario INNER JOIN professor on professor.idprofessor = diario.professor_principal INNER JOIN componente_curricular on diario.componente = componente_curricular.cod_cc 	WHERE aluno.matricula = " +matricula
	iteracaoDosDados(consulta)

	
def alunocurso(matricula):
	consulta = "SELECT aluno.nome as aluno, curso.nome FROM nota_avaliacao INNER JOIN aluno on aluno.cod_aluno = nota_avaliacao.aluno INNER join avaliacao 	on avaliacao.idavaliacao = nota_avaliacao.avaliacao INNER JOIN diario on avaliacao.diario = diario.cod_diario INNER JOIN professor on professor.idprofessor = diario.professor_principal INNER JOIN componente_curricular on diario.componente = componente_curricular.cod_cc  inner join matriz_curricular on componente_curricular.matriz = matriz_curricular.cod_matriz inner join curso on curso.cod_curso = matriz_curricular.curso WHERE aluno.matricula = " +matricula
	# print(consulta)
	iteracaoDosDados(consulta)		

### Final dos métodos somente para alunos ###

##################


### Início dos métodos somente para professores ###

def pesquisarProfessor():
	professor = input("Digite o nome do professor que deseja pesquisar: ")
	buscaProfessorInicial(professor)
	professor = input("Digite o SIAPE do professor(a) que deseja pesquisar: ")
	print("O que deseja saber sobre o professor: ")
	print("1 - Quais disciplinas ministradas por ele em determinado curso. ")
	print("2 - Quais suas notas dadas por ele. ")
	print("3 - Qual curso ele está vinculado. ")
	print("4 - Quais seus dependentes. ")
	opcao = input("____________________________________________________________________________\n\n")
	
	if opcao == '1':
		professorDisciplina(professor)

	if opcao == '2':
		professorNotas(professor)

	if opcao == '3':
		professorcurso(professor)

	if opcao == '4':
		professorDependente(professor)

def buscaProfessorInicial(professor):
	consulta = "SELECT professor.nome, professor.siape from professor WHERE professor.nome LIKE '%"+professor+"%'"
	# print(consulta)
	iteracaoDosDados(consulta)		

def professorDisciplina(siape):
	consulta = "SELECT professor.nome, componente_curricular.nome, curso.nome FROM diario INNER JOIN componente_curricular on diario.componente = componente_curricular.cod_cc inner join professor on professor.idprofessor = diario.professor_principal inner join matriz_curricular on componente_curricular.matriz = matriz_curricular.cod_matriz inner join curso on matriz_curricular.curso = curso.cod_curso WHERE professor.siape = " +siape 
	# print(consulta)
	iteracaoDosDados(consulta)		


def professorNotas(siape):
	consulta = "SELECT professor.nome, componente_curricular.nome, curso.nome, aluno.nome, nota_avaliacao.nota, nota_avaliacao.avaliacao, nota_avaliacao.observação FROM diario INNER JOIN componente_curricular on diario.componente = componente_curricular.cod_cc inner join professor on professor.idprofessor = diario.professor_principal inner join matriz_curricular on componente_curricular.matriz = matriz_curricular.cod_matriz inner join curso on matriz_curricular.curso = curso.cod_curso INNER JOIN avaliacao on avaliacao.diario = diario.cod_diario INNER JOIN nota_avaliacao on nota_avaliacao.avaliacao = avaliacao.idavaliacao INNER JOIN aluno on aluno.cod_aluno = nota_avaliacao.aluno  WHERE professor.siape = " +siape
	# print(consulta)
	iteracaoDosDados(consulta)	


def professorcurso(siape):
	consulta = "SELECT professor.nome, curso.nome from curso join matriz_curricular on matriz_curricular.curso = curso.cod_curso join componente_curricular on componente_curricular.matriz = matriz_curricular.cod_matriz  join diario on diario.componente = componente_curricular.cod_cc join professor on diario.professor_principal = professor.idprofessor WHERE professor.siape = " +siape
	# print(consulta)
	iteracaoDosDados(consulta)		

def professorDependente(siape):
	consulta = "SELECT professor.nome, dependente.nome from dependente inner join professor on dependente.professor_= professor.idprofessor where professor.siape = " +siape 
	# print(consulta)
	iteracaoDosDados(consulta)

### Final dos métodos somente para professores ###




### Início dos métodos somente para componentes curriculares (disciplinas)###

def pesquisarcomponente():
	componente = input("Digite o nome do disciplina que deseja pesquisar: ")
	buscacomponenteInicial(componente)
	codigoComponente = input("Digite o código do componente que deseja pesquisar: ")
	print("O que deseja saber sobre o componente(a): ")
	print("1 - Quais aluno(a)s assistem aulas dessa disciplina. ")
	print("2 - Quais suas notas foram atribuídas nesta disciplina. ")
	print("3 - Quais cursos estão vinculados a essa disciplina. ")
	opcao = input("____________________________________________________________________________\n\n")


	if opcao == '1':
		componenteAluno(codigoComponente)

	if opcao == '2':
		componenteNotas(codigoComponente)

	if opcao == '3':
		componentecurso(codigoComponente)

def buscacomponenteInicial(componente):
	consulta = "SELECT componente_curricular.cod_cc, componente_curricular.sigla, componente_curricular.nome from componente_curricular WHERE componente_curricular.nome LIKE '%"+componente+"%'"
	# print(consulta)
	iteracaoDosDados(consulta)		


def componenteAluno(codigoComponente):
	
	consulta = "SELECT distinct componente_curricular.cod_cc, componente_curricular.nome, aluno.nome from componente_curricular join diario on diario.componente = componente_curricular.cod_cc join turma on turma.diario = diario.cod_diario join matriculas_componente on matriculas_componente.turma = turma.cod_turma join aluno on matriculas_componente.aluno = aluno.cod_aluno WHERE componente_curricular.cod_cc = " +codigoComponente
	# print(consulta)
	iteracaoDosDados(consulta)		


def componenteNotas(codigoComponente):
	consulta = "SELECT componente_curricular.nome, aluno.nome, nota_avaliacao.avaliacao, nota_avaliacao.nota from componente_curricular join diario on diario.componente = componente_curricular.cod_cc join turma on turma.diario = diario.cod_diario join matriculas_componente on matriculas_componente.turma = turma.cod_turma join aluno on matriculas_componente.aluno = aluno.cod_aluno join nota_avaliacao on nota_avaliacao.aluno = aluno.cod_aluno WHERE componente_curricular.cod_cc = " +codigoComponente
	# print(consulta)
	iteracaoDosDados(consulta)	


def componentecurso(codigoComponente):
	consulta = "SELECT distinct componente_curricular.nome, curso.nome from curso join matriz_curricular on matriz_curricular.curso = curso.cod_curso join componente_curricular on componente_curricular.matriz = matriz_curricular.cod_matriz WHERE componente_curricular.cod_cc = " +codigoComponente
	# print(consulta)
	iteracaoDosDados(consulta)		

### Final dos métodos somente para componentes curriculares(disciplinas) ###




### Início dos métodos somente para curso ###

def pesquisarCurso():
	curso = input("Digite o nome do curso que deseja pesquisar: ")
	buscaCursoInicial(curso)
	codigoCurso = input("Digite o código do curso que deseja pesquisar: ")
	print("O que deseja saber sobre o curso: ")
	print("1 - Quais alunos(as) estão matriculados num determinado curso. ")
	print("2 - Quais professores(as) estão vinculados a um curso. ")
	opcao = input("____________________________________________________________________________\n\n")


	if opcao == '1':
		cursoAluno(codigoCurso)

	if opcao == '2':
		cursoProfessor(codigoCurso)

	
def buscaCursoInicial(curso):
	consulta = "SELECT curso.cod_curso, curso.nome from curso WHERE curso.nome LIKE '%"+curso+"%'"
	# print(consulta)
	iteracaoDosDados(consulta)		

def cursoAluno(curso):
	consulta = "SELECT distinct curso.cod_curso,curso.nome,aluno.nome from curso inner join matriz_curricular on matriz_curricular.curso = curso.cod_curso inner join componente_curricular on componente_curricular.matriz = matriz_curricular.cod_matriz inner join diario on diario.componente = componente_curricular.cod_cc inner join turma on diario.cod_diario = turma.diario inner join matriculas_componente on matriculas_componente.turma = turma.cod_turma inner join aluno on matriculas_componente.aluno = aluno.cod_aluno WHERE curso.cod_curso  = " +curso 
	# print(consulta)
	iteracaoDosDados(consulta)
	
def cursoProfessor(curso):
	consulta = "SELECT curso.nome, professor.nome from curso join matriz_curricular on matriz_curricular.curso = curso.cod_curso join componente_curricular on componente_curricular.matriz = matriz_curricular.cod_matriz join diario on diario.componente = componente_curricular.cod_cc  join professor on professor.idprofessor = diario.professor_principal WHERE curso.cod_curso  = " +curso 
	# print(consulta)
	iteracaoDosDados(consulta)			


### Final dos métodos somente para curso ###



### Início dos métodos somente para matriz###

def pesquisarMatriz():
	# matriz= input("Digite o nome do matriz que deseja pesquisar: ")
	# buscaMatrizInicial(matriz)
	# codigoMatriz = input("Digite o código da matriz que deseja pesquisar: ")
	print("O que deseja saber sobre as matrizes: ")
	print("1 - Todas a matrizes. ")
	print("2 - Matrizes em vigor. ")
	print("3 - Matrizes expiradas. ")
	opcao = input("____________________________________________________________________________\n\n")


	if opcao == '1':
		todasMatrizes()

	if opcao == '2':
		MatrizesEmVigor()

	if opcao == '3':
		MatrizesExpiradas()
	
def todasMatrizes():
	consulta = "SELECT nome, date_format(data,'%d-%m-%Y'), situacao FROM matriz_curricular;"
	# consulta = "SELECT Matriz.cod_Matriz, Matriz.nome from matriz WHERE Matriz.nome LIKE '%"+matriz+"%'"
	# print(consulta)
	iteracaoDosDados(consulta)		


def MatrizesEmVigor():
	consulta = "SELECT nome, date_format(data,'%d-%m-%Y'), situacao FROM matriz_curricular where situacao = 'em vigor'"
	# print(consulta)
	iteracaoDosDados(consulta)

def MatrizesExpiradas():
	consulta = "SELECT nome, date_format(data,'%d-%m-%Y'), situacao FROM matriz_curricular where situacao = 'expirada'"
	# print(consulta)
	iteracaoDosDados(consulta)		

### Final dos métodos somente para matriz###




def sair():
	print("Fim do programa.")
	exit()

opcao = ''

while opcao != 9:
	menuPrincipal()
# aluno = "alexsandro"
# buscaAlunoInicial(aluno)


