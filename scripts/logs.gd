class_name Logs
extends RefCounted
## Registros do Projeto: diários espalhados pelas fases que contam a história.

const ORDER := ["log_01", "log_02", "log_03", "log_04", "log_05", "log_06", "log_07", "log_08"]

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
}


static func read_count(main) -> int:
	var n := 0
	for id in ORDER:
		if main.collected.has(id):
			n += 1
	return n
