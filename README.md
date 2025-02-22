# Script de Automação de Atualização do Sistema

Este é um script shell desenvolvido para automatizar a atualização do sistema em distribuições Linux baseadas em Debian (como Kali Linux, Ubuntu, etc.).
Ele realiza várias tarefas, como atualização de pacotes, remoção de pacotes desnecessários, limpeza de cache e muito mais.

# Funcionalidades
O script inclui as seguintes funcionalidades:

# Atualização do sistema:

Atualiza a lista de pacotes (apt update).

Atualiza os pacotes instalados (apt upgrade).

# Limpeza do sistema:

Remove pacotes desnecessários (apt autoremove).

Limpa o cache do APT (apt clean).

# Atualização de pacotes Snap e Flatpak:

Atualiza pacotes Snap (snap refresh), se instalado.

Atualiza pacotes Flatpak (flatpak update), se instalado.

# Registro de logs:

Todas as ações são registradas em um arquivo de log (/var/log/atualizacao_sistema.log).

# Notificação por e-mail (opcional):

Envia um e-mail com o status da atualização.

# Reinicialização automática:

Reinicia o sistema automaticamente se necessário após a atualização.

# Pré-requisitos
Distribuição Linux baseada em Debian (Kali Linux, Ubuntu, etc.).

Permissões de superusuário (sudo).

(Opcional) Configuração do mailutils para envio de e-mails.

````
wget https://seusite.com/atualizacao_sistema.sh
orne o script executável:

chmod +x atualizacao_sistema.sh
Execute o script:

sudo ./atualizacao_sistema.sh
````
Configuração de E-mail (Opcional)
Se você quiser receber notificações por e-mail, edite o script e defina a variável EMAIL com o seu endereço de e-mail:
````
EMAIL="seu_email@exemplo.com"
Certifique-se de que o mailutils está instalado e configurado no seu sistema:

sudo apt install mailutils
````
Exemplo de Saída
Após a execução, o script exibirá mensagens no terminal e registrará tudo no arquivo de log. Exemplo:
````
2023-10-05 14:30:00 - Iniciando a atualização do sistema...
2023-10-05 14:30:05 - Atualizando a lista de pacotes...
2023-10-05 14:30:10 - Atualizando os pacotes instalados...
2023-10-05 14:35:00 - Pacotes desnecessários removidos com sucesso!
2023-10-05 14:35:05 - Cache do APT limpo com sucesso!
2023-10-05 14:35:10 - Atualização concluída com sucesso!
````
# Personalização
Você pode personalizar o script de acordo com suas necessidades:

Adicionar mais comandos de atualização ou limpeza.

Modificar o local do arquivo de log.

Configurar notificações adicionais (por exemplo, via Telegram ou Slack).

# Contribuição
Se você quiser contribuir para o projeto, sinta-se à vontade para:

Fazer um fork do repositório.

Criar uma branch com sua feature (git checkout -b feature/nova-feature).

Fazer commit das alterações (git commit -m 'Adicionando nova feature').

Fazer push para a branch (git push origin feature/nova-feature).

Abrir um Pull Request.
