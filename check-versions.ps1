Write-Host "===== Versões do Ambiente Laravel Docker =====`n"

# PHP
Write-Host "PHP:"
docker-compose run --rm app php -v | Select-Object -First 1
Write-Host ""

# MySQL
Write-Host "MySQL:"
docker-compose run --rm db mysql --version
Write-Host ""

# Laravel
Write-Host "Laravel:"
docker-compose run --rm app php artisan --version
Write-Host ""

# Node.js
Write-Host "Node.js:"
docker-compose run --rm app node -v
Write-Host ""

# npm
Write-Host "npm:"
docker-compose run --rm app npm -v
Write-Host ""

# Bootstrap (via npm)
Write-Host "Bootstrap:"
docker-compose run --rm app npm list bootstrap | Select-String "bootstrap"
Write-Host ""

Write-Host "============================================="
