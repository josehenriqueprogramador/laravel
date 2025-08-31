# Laravel Docker Environment

Este repositório contém um **ambiente completo para desenvolvimento Laravel** utilizando Docker. Ele inclui:

- PHP 8.2 com Apache  
- MySQL 5.7  
- Laravel 12  
- Node.js 20 e npm 10  
- Bootstrap 5  

O ambiente foi configurado para facilitar o desenvolvimento local, com Docker Compose e todos os serviços essenciais.

---

## Estrutura do Projeto

```

meu-projeto-laravel/
├── Dockerfile
├── docker-compose.yml
├── check-versions.ps1
└── src/            # Código-fonte do Laravel

```

- `Dockerfile` e `docker-compose.yml` ficam na raiz para gerenciar containers e serviços.
- `src/` contém toda a aplicação Laravel.

---

## Observações importantes

### DocumentRoot do Apache
No Dockerfile, o DocumentRoot foi configurado para:

```

/var/www/html/public

````

Isso é essencial para Laravel.

### Permissões
Para garantir que o Apache consiga acessar `storage`, `bootstrap/cache` e outros diretórios:

```bash
docker-compose exec app chown -R www-data:www-data /var/www/html
docker-compose exec app chmod -R 755 /var/www/html
````

### Acesso

* Laravel: [http://localhost:8080](http://localhost:8080)
* phpMyAdmin: [http://localhost:8081](http://localhost:8081)
  Usuário: `root`
  Senha: `toor`

### .env do Laravel

Certifique-se que o `.env` contém:

```dotenv
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel_db
DB_USERNAME=root
DB_PASSWORD=toor
```

### Script de verificação de versões

O arquivo `check-versions.ps1` permite verificar rapidamente as versões dos serviços do ambiente:

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

## Comandos úteis

### Subir o ambiente

```bash
docker-compose up -d
```

### Rodar migrations

```bash
docker-compose run --rm app php artisan migrate
```

### Gerar a chave do Laravel

```bash
docker-compose run --rm app php artisan key:generate
```

### Instalar dependências Node/Bootstrap

```bash
docker-compose run --rm app npm install
```

---

## Licença

Este projeto é open source e pode ser usado livremente para aprendizado e desenvolvimento.

```
