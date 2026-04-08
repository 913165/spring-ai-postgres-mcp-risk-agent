Write-Host "==================================================" -ForegroundColor Cyan
Write-Host " Portfolio Risk Agent - Full Setup & Run Script" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# ── Step 1: Make sure postgres-risk-db is running ─────────────────────────
Write-Host "`n[1/4] Checking postgres-risk-db container..." -ForegroundColor Yellow
$dbStatus = docker inspect --format "{{.State.Status}}" postgres-risk-db 2>&1
if ($dbStatus -ne "running") {
    Write-Host "  Starting postgres-risk-db..." -ForegroundColor Gray
    docker start postgres-risk-db
    Start-Sleep -Seconds 5
} else {
    Write-Host "  postgres-risk-db is running OK" -ForegroundColor Green
}

# ── Step 2: Make sure postgres-mcp-server is running with DATABASE_URI ─────
Write-Host "`n[2/4] Setting up postgres-mcp-server..." -ForegroundColor Yellow
$mcpStatus = docker inspect --format "{{.State.Status}}" postgres-mcp-server 2>&1
if ($mcpStatus -ne "running") {
    Write-Host "  Recreating postgres-mcp-server with DATABASE_URI..." -ForegroundColor Gray
    docker stop postgres-mcp-server 2>$null
    docker rm   postgres-mcp-server 2>$null
    docker run -d `
      --name postgres-mcp-server `
      -e DATABASE_URI="postgresql://riskuser:riskpass@host.docker.internal:5432/riskdb" `
      -p 8000:8000 `
      crystaldba/postgres-mcp:latest
    Start-Sleep -Seconds 5
} else {
    Write-Host "  postgres-mcp-server is running OK" -ForegroundColor Green
}

# Check what DATABASE_URI is set
$uri = docker inspect --format "{{range .Config.Env}}{{println .}}{{end}}" postgres-mcp-server | Select-String "DATABASE_URI"
Write-Host "  $uri" -ForegroundColor Gray

# ── Step 3: Seed Postgres with portfolio risk data ─────────────────────────
Write-Host "`n[3/4] Seeding portfolio_risk data into Postgres..." -ForegroundColor Yellow
docker cp "$PSScriptRoot\db\init.sql" postgres-risk-db:/tmp/init.sql
docker exec postgres-risk-db psql -U riskuser -d riskdb -f /tmp/init.sql
Write-Host "`n  Current data in portfolio_risk:" -ForegroundColor Gray
docker exec postgres-risk-db psql -U riskuser -d riskdb -c `
  "SELECT portfolio_name, daily_loss, tech_exposure, risk_rating FROM portfolio_risk ORDER BY daily_loss DESC;"

# ── Step 4: Start Spring Boot app ─────────────────────────────────────────
Write-Host "`n[4/4] Starting Spring Boot app..." -ForegroundColor Yellow
Write-Host "  Watch for: 'MCP tools registered: X' (should be > 0)" -ForegroundColor Green
Write-Host "  Then open: http://localhost:8080" -ForegroundColor Green
Write-Host "  Press Ctrl+C to stop`n" -ForegroundColor Gray

Set-Location $PSScriptRoot
& .\mvnw.cmd spring-boot:run
