# Ruby version
  * 2.5.1

# Install yarn

Debian / Ubuntu
On Debian or Ubuntu Linux, you can install Yarn via our Debian package repository. You will first need to configure the repository:
```
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
```

On Ubuntu 16.04 or below and Debian Stable, you will also need to configure the NodeSource repository to get a new enough version of Node.js.

Then you can simply:

```
sudo apt-get update && sudo apt-get install yarn
```

# Run

```
bundle exec spring binstub --all
```

```
rails db:create
```

```
rails db:migrate
```

# Espeficicações iniciais

Devise configurado com:
  
  * Username habilitado
  * Cancelamento de conta sem destruir o usuário
  * Enviando email de redefinir senha

criar batida na hora da entrada de estoque final, tendo uma tabela adicional que cria os itens da batida e marca o peso

criar entrada de produto final de composicoes existentes igual da materia prima, pois sempre vai precisar existir uma entrada de composicao com batida para existir a entrada de stoque de composicao existente

