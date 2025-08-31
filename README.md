---

# Laravel Docker Environment - Guia Completo

Este repositório contém um **ambiente completo para desenvolvimento Laravel** utilizando Docker, com todos os serviços necessários pré-configurados.

---

## ✅ Tecnologias Inclusas

| Serviço   | Versão  |
| --------- | ------- |
| PHP       | 8.2     |
| MySQL     | 5.7     |
| Laravel   | 12.26.4 |
| Node.js   | 20.19.4 |
| npm       | 10.8.2  |
| Bootstrap | 5.3.8   |
| Apache    | 2.4     |

---

## 📂 Estrutura do Projeto

```
meu-projeto-laravel/
├── Dockerfile
├── docker-compose.yml
├── check-versions.ps1
└── src/            # Código-fonte do Laravel
```

* `Dockerfile` e `docker-compose.yml` gerenciam containers e serviços.
* `src/` contém toda a aplicação Laravel.

---

## ⚙️ Configurações Importantes

### DocumentRoot do Apache

No Dockerfile:

```
/var/www/html/public
```

Essencial para o correto funcionamento do Laravel.

### Permissões

Dentro do container Laravel:

```bash
docker-compose exec laravel-app bash
chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html
```

Isso garante que o Laravel consiga escrever em `storage` e `bootstrap/cache`.

---

## 🔑 Acesso

* Laravel: [http://localhost:8080](http://localhost:8080)
* phpMyAdmin: [http://localhost:8081](http://localhost:8081)

  * Usuário: `root`
  * Senha: `toor`

### .env do Laravel

```dotenv
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=root
DB_PASSWORD=toor
```

---

## 🖥️ Script de Verificação de Versões

O arquivo `check-versions.ps1` verifica rapidamente as versões do ambiente:

```powershell
.\check-versions.ps1
```

Exemplo de saída:

```
===== Versões do Ambiente Laravel Docker =====

PHP: 8.2.29
MySQL: 5.7.44
Laravel: 12.26.4
Node.js: 20.19.4
npm: 10.8.2
Bootstrap: 5.3.8
=============================================
```

---

## 🚀 Passo a Passo do Setup

1. **Clonar o repositório**

```bash
git clone https://github.com/josehenriqueprogramador/laravel.git
cd laravel
```

2. **Remover referência de submódulo (caso exista)**

```bash
git rm --cached src
rm -rf .git/modules/src
```

3. **Subir containers Docker**

```bash
docker-compose up -d
docker ps
```

Exemplo de saída:

```
CONTAINER ID   IMAGE              STATUS          PORTS
ad9241de46b0   laravel-app        Up 50s          0.0.0.0:8080->80/tcp
3a7e5ef55bb2   phpmyadmin         Up 50s          0.0.0.0:8081->80/tcp
a5729552665f   mysql:5.7          Up 10m          3306/tcp, 33060/tcp
```

4. **Criar projeto Laravel dentro de `src`**

```bash
cd src
composer create-project laravel/laravel .
```

⚠️ Dica: Se houver problemas de permissão:

```bash
chown -R www-data:www-data .
chmod -R 775 .
```

5. **Rodar migrations**

```bash
docker-compose run --rm laravel-app php artisan migrate
```

Exemplo de saída:

```
Migrating: 0001_01_01_000000_create_users_table
Migrated:  0001_01_01_000000_create_users_table
```

6. **Gerar chave do Laravel**

```bash
docker-compose run --rm laravel-app php artisan key:generate
```

7. **Rodar servidor interno (opcional, dentro do container)**

```bash
php artisan serve --host=0.0.0.0 --port=8000
```

Acesse em [http://localhost:8000](http://localhost:8000).

---

## 📦 Comandos úteis

### Docker / Docker Compose

| Comando                            | Caso de Uso                                   |
| ---------------------------------- | --------------------------------------------- |
| `docker-compose up -d`             | Subir containers em segundo plano             |
| `docker-compose build`             | Recriar imagens após alterações no Dockerfile |
| `docker exec -it laravel-app bash` | Acessar container Laravel                     |
| `docker ps`                        | Listar containers ativos                      |

### Laravel Artisan

| Comando                      | Uso                                |
| ---------------------------- | ---------------------------------- |
| `php artisan --version`      | Verificar versão Laravel           |
| `php artisan migrate`        | Rodar migrations                   |
| `php artisan migrate:status` | Verificar status das migrations    |
| `php artisan key:generate`   | Gerar APP\_KEY                     |
| `php artisan serve`          | Rodar servidor interno para testes |

### Composer

| Comando                                     | Uso                   |
| ------------------------------------------- | --------------------- |
| `composer create-project laravel/laravel .` | Criar projeto Laravel |
| `composer install`                          | Instalar dependências |
| `composer update`                           | Atualizar pacotes     |

### Git

| Comando                           | Uso                                           |
| --------------------------------- | --------------------------------------------- |
| `git clone <url>`                 | Clonar repositório                            |
| `git add .`                       | Adicionar alterações para commit              |
| `git commit -m "mensagem"`        | Criar commit                                  |
| `git push -u origin main --force` | Enviar alterações para remoto                 |
| `git fetch origin`                | Atualizar informações do remoto               |
| `git reset --hard origin/main`    | Resetar branch local para remoto              |
| `git rm --cached <arquivo>`       | Remover arquivo do índice sem apagar do disco |

### Linux / Shell

| Comando                 | Uso                            |
| ----------------------- | ------------------------------ |
| `ls -la`                | Listar arquivos detalhadamente |
| `cd <diretório>`        | Navegar entre pastas           |
| `mv <origem> <destino>` | Mover arquivos/pastas          |
| `rm -rf <pasta>`        | Remover pasta e conteúdo       |

---

## 🔧 Dicas de Debug

* Se `php artisan` não for encontrado dentro do container, verifique se o código Laravel está dentro de `/var/www/html` e se as permissões estão corretas.
* Use `docker-compose logs laravel-app` para visualizar logs de erro do container.
* Sempre cheque `.env` para variáveis de conexão com o banco.

---

## 📝 Licença

Este projeto é open source e pode ser usado livremente para aprendizado e desenvolvimento.

---
