#!/bin/bash

# Configurações
LOG_FILE="/var/log/atualizacao_sistema.log"
EMAIL="seu_email@exemplo.com"  # Deixe em branco se não quiser usar e-mail

# Função para registrar logs
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG_FILE
}

# Função para enviar e-mail
send_email() {
    if [ -n "$EMAIL" ]; then
        echo "$1" | mail -s "Status da Atualização" $EMAIL
    fi
}

# Início do script
log "Iniciando a atualização do sistema..."

# Atualiza a lista de pacotes
log "Atualizando a lista de pacotes..."
sudo apt update >> $LOG_FILE 2>&1
if [ $? -ne 0 ]; then
    log "Erro ao atualizar a lista de pacotes!"
    send_email "Erro ao atualizar a lista de pacotes!"
    exit 1
fi

# Atualiza os pacotes instalados
log "Atualizando os pacotes instalados..."
sudo apt upgrade -y >> $LOG_FILE 2>&1
if [ $? -ne 0 ]; then
    log "Erro ao atualizar os pacotes!"
    send_email "Erro ao atualizar os pacotes!"
    exit 1
fi

# Remove pacotes desnecessários
log "Removendo pacotes desnecessários..."
sudo apt autoremove -y >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    log "Pacotes desnecessários removidos com sucesso!"
else
    log "Erro ao remover pacotes desnecessários."
fi

# Limpa o cache do APT
log "Limpando o cache do APT..."
sudo apt clean >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    log "Cache do APT limpo com sucesso!"
else
    log "Erro ao limpar o cache do APT."
fi

# Atualiza pacotes Snap (se instalado)
if command -v snap &> /dev/null; then
    log "Atualizando pacotes Snap..."
    sudo snap refresh >> $LOG_FILE 2>&1
    if [ $? -eq 0 ]; then
        log "Pacotes Snap atualizados com sucesso!"
    else
        log "Erro ao atualizar pacotes Snap."
    fi
else
    log "Snap não está instalado."
fi

# Atualiza pacotes Flatpak (se instalado)
if command -v flatpak &> /dev/null; then
    log "Atualizando pacotes Flatpak..."
    flatpak update -y >> $LOG_FILE 2>&1
    if [ $? -eq 0 ]; then
        log "Pacotes Flatpak atualizados com sucesso!"
    else
        log "Erro ao atualizar pacotes Flatpak."
    fi
else
    log "Flatpak não está instalado."
fi

# Verifica se é necessário reiniciar
if [ -f /var/run/reboot-required ]; then
    log "Reinicialização necessária. Reiniciando o sistema..."
    send_email "Atualização concluída. O sistema será reiniciado."
    sudo reboot
else
    log "Nenhuma reinicialização necessária."
    send_email "Atualização concluída com sucesso!"
fi

log "Atualização concluída!"
