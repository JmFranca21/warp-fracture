class_name Logs
extends RefCounted
## Registros do Projeto: diários espalhados pelas fases que contam a história.

const ORDER := ["log_01", "log_02", "log_03", "log_04", "log_05", "log_06", "log_07", "log_08", "log_09",
	"log_10", "log_11", "log_12", "log_13"]

const LOGS := {
	"log_01": ["Diário de Daymon — Dia 412",
		"Amanhã a Máquina de Dobra roda em potência máxima. O Conselho Global quer resultados até o fim do trimestre, e eu também.\n\nA IRIS insiste que os estabilizadores não aguentam mais de 80%. Está sendo cautelosa demais. Se a teoria estiver certa, vamos abrir uma fresta para outra realidade por um único segundo.\n\nUm segundo que muda tudo."],
	"log_02": ["Relatório de Segurança — Setor C",
		"Após o incidente, os drones de patrulha passaram a ignorar os crachás da equipe. As turretas sentinela religaram sozinhas e miram em qualquer coisa que se mova.\n\nRecomendação: NÃO atravesse o corredor no chão. Use as plataformas suspensas para ficar acima da linha do feixe."],
	"log_03": ["Mensagem de IRIS (gravada)",
		"Daymon, se você está ouvindo isto, eu falhei em te convencer.\n\nA sobrecarga partiu o núcleo da máquina em quatro. Rastreei os fragmentos: cada um caiu numa realidade diferente.\n\nMantive o Traje Âncora ligado. Ele vai proteger a sua mente quando o portal mudar o seu corpo. Não o desligue. Por favor."],
	"log_04": ["Arquivo Confidencial — ECO",
		"Três segundos antes da explosão, os sensores registraram uma assinatura de energia dentro da câmara. Tinha a forma de um homem.\n\nA frequência batia com as ondas cerebrais do Dr. Sagan: 99,7% de correspondência. Classificação provisória: ECO.\n\nSe ele se alimenta das fraturas, cada portal aberto o deixa mais forte."],
	"log_05": ["Diário de Daymon — sem data",
		"Eu vi alguém do outro lado do campo de força. Tinha o meu rosto.\n\nQuando me aproximei, ele sorriu e se desfez como estática. A IRIS diz que foi um reflexo do campo.\n\nA IRIS nunca mentiu para mim. Até agora."],
	"log_06": ["Anotação de campo — Verdâmia",
		"Corpo novo: quatro patas, garras e uma lanterna na ponta da cauda. Estranhamente, não dói.\n\nOs reflexos são mais rápidos que os meus. Consigo saltar das paredes como se tivesse feito isso a vida inteira.\n\nA faixa ciano do traje continua aqui, no meu peito. Ainda sou eu."],
	"log_07": ["Inscrição nas raízes",
		"Entalhado na casca, num idioma que o traje traduz aos poucos:\n\n\"A Estrela Caída chegou com o trovão. A Rainha a guardou no coração do templo. Quem quiser levá-la deve primeiro ouvir as raízes.\"\n\nAcho que a Estrela Caída é o fragmento."],
	"log_08": ["Diário de Daymon — sinal desconhecido",
		"O monitor do traje captou um pulso vindo de muito longe. Não é de Verdâmia, nem de Hidrópolis, nem de nenhuma das quatro realidades mapeadas.\n\nUm quinto sinal.\n\nA IRIS diz que é ruído. Anotei as coordenadas mesmo assim."],
	"log_09": ["Análise de IRIS — segundo sinal",
		"Com o primeiro fragmento instalado, separei um segundo sinal: calor seco, metal e ferrugem. Ferrumgrado.\n\nNa superfície, um deserto de sucata. No meio dele, uma fábrica que nunca parou de funcionar. Os padrões de energia lembram uma linha de montagem... e uma mente.\n\nO fragmento está no coração dessa fábrica. Daymon, o que estiver lá dentro não vai entregá-lo de boa vontade."],
	"log_10": ["Análise de IRIS — terceiro sinal",
		"O terceiro sinal é frio. Uma cordilheira sob uma noite que não termina: a temperatura cai um pouco a cada hora, como se alguma coisa estivesse bebendo o calor do mundo.\n\nChamei de Nivária.\n\nO traje aguenta, mas só se você mantiver as resistências quentes. Não fique parado no frio, Daymon."],
	"log_11": ["Caderno de observação — Estação do Cume",
		"Escrito à mão, numa língua que o traje traduz aos poucos:\n\n\"Noite 3.112. A aurora mudou de cor depois da estrela caída: está rosa. O céu não clareia mais.\n\nO gelo cobriu o telescópio grande. Vamos descer para a caverna dos cristais e esperar o dia.\""],
	"log_12": ["Painel da Caverna de Cristal",
		"Último registro gravado no painel:\n\n\"A névoa roxa nos poços cresce quando a estrela pulsa. Os cristais cantam junto com ela.\n\nAlguma coisa no cume está se juntando em volta da estrela. Feita de gelo. Ela não nos deixa subir.\""],
	"log_13": ["Diário de Daymon — Encosta Nevada",
		"Daqui de cima dá para ver a forma lá no cume: um gigante de gelo em volta de uma luz azul. É o fragmento.\n\nO que me preocupa é a névoa roxa. É a mesma energia da fratura, a mesma que o Eco come.\n\nSe ele está se alimentando daqui, cada fragmento que eu demoro a pegar o deixa mais forte."],
}


static func read_count(main) -> int:
	var n := 0
	for id in ORDER:
		if main.collected.has(id):
			n += 1
	return n
