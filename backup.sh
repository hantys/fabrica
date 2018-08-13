#!/usr/bin/bash
#Variaveis
# restaurando pg_restore -c -d fabrica_development vendor/fabrica_20_00_01.dmp
# restaurando pg_restore -c -U postgres -d fabrica_development vendor/fabrica_20_00_01.dmp

nw=$(date "+%d_%m_%y")                 #Buscar pela data
nt=$(date "+%H_%M_%S")                 #Buscar pela hora
bkr="/opt/data/backup/"          #Diretório para salvar arquivos de backup
bk="/opt/data/backup/$nw"          #Diretório para salvar arquivos de backup

# sudo su -c whoami nobody

backup()
{
  time_a=$(date "+%H")
  time_b=$(expr $time_a + 0)
  echo $time_b

  if [ $time_b -ge '2' -a $time_b -le '22' ]; then
    echo "Backup Previsto"
    echo "Limpando Diretório"

    rm vendor/*.dmp

    echo "Realizando backup do servidor"
    scp monkey2:"$bk/*" ~/projeto/fabrica/vendor/

    echo "Escolhendo ultimo backup"
    file1=$(ls vendor/ -trp | grep -v / | tail -1)
    file_name="vendor/"$file1

    echo "Descompactando: $file_name"
    gunzip $file_name

    echo "Limpando Diretório"
    rm vendor/*.gz
  else
    echo "Nao existe backup para essa data ainda"
  fi

  echo "Carregando arquivo backup"
  file1=$(ls vendor/ -trp | grep -v / | tail -1)
  file_name="vendor/"$file1

  echo "Restaurando db local"
  sudo su -c "pg_restore -c -d fabrica_development $file_name" postgres
}
backup postgres
