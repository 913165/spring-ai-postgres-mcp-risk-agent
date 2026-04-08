-- ============================================================
-- Portfolio Risk Database - Seed Data
-- Used by the Postgres MCP Server (crystaldba/postgres-mcp)
-- The Spring Boot app NEVER connects here directly.
-- All access goes through MCP tools only.
-- ============================================================

CREATE TABLE IF NOT EXISTS portfolio_risk (
    id               SERIAL PRIMARY KEY,
    portfolio_name   VARCHAR(100) NOT NULL,
    manager          VARCHAR(100),
    daily_loss       NUMERIC(5,2)  NOT NULL,  -- percentage e.g. 6.5 means 6.5%
    tech_exposure    NUMERIC(5,2)  NOT NULL,  -- percentage e.g. 34 means 34%
    aum_million_usd  NUMERIC(10,2),
    risk_rating      VARCHAR(20),
    last_reviewed    DATE
);

CREATE TABLE IF NOT EXISTS portfolio_sector_exposure (
    id             SERIAL PRIMARY KEY,
    portfolio_name VARCHAR(100) NOT NULL,
    sector         VARCHAR(100) NOT NULL,
    exposure_pct   NUMERIC(5,2) NOT NULL
);

-- ============================================================
-- Portfolio Risk seed data
-- ============================================================
INSERT INTO portfolio_risk (portfolio_name, manager, daily_loss, tech_exposure, aum_million_usd, risk_rating, last_reviewed) VALUES
('Global Tech Growth',     'Alice Chen',    6.5,  34.0, 1250.00, 'HIGH',   '2026-04-07'),
('Emerging Markets Alpha', 'Bob Patel',     7.2,  28.5,  980.00, 'HIGH',   '2026-04-07'),
('US Equity Core',         'Carol Singh',   2.1,  18.0, 4200.00, 'LOW',    '2026-04-06'),
('Asia Pacific Growth',    'David Lee',     5.8,  31.2,  760.00, 'HIGH',   '2026-04-07'),
('European Value',         'Eva Muller',    1.9,  12.5, 2100.00, 'LOW',    '2026-04-05'),
('Global Balanced',        'Frank Kim',     3.4,  22.1, 3300.00, 'MEDIUM', '2026-04-06'),
('Tech Disruptors Fund',   'Grace Wang',    8.1,  67.0,  540.00, 'HIGH',   '2026-04-07'),
('Dividend Income',        'Henry Brown',   1.2,   8.3, 5100.00, 'LOW',    '2026-04-04'),
('Small Cap Momentum',     'Irene Zhou',    6.0,  25.8,  320.00, 'HIGH',   '2026-04-07'),
('Fixed Income Plus',      'James Park',    0.8,   3.0, 8900.00, 'LOW',    '2026-04-03');

-- ============================================================
-- Sector exposure seed data
-- ============================================================
INSERT INTO portfolio_sector_exposure (portfolio_name, sector, exposure_pct) VALUES
('Global Tech Growth',     'Technology',        34.0),
('Global Tech Growth',     'Healthcare',        18.0),
('Global Tech Growth',     'Financials',        14.0),
('Global Tech Growth',     'Consumer Discretionary', 12.0),
('Global Tech Growth',     'Energy',             8.0),
('Global Tech Growth',     'Other',             14.0),

('Tech Disruptors Fund',   'Technology',        67.0),
('Tech Disruptors Fund',   'Consumer Discretionary', 15.0),
('Tech Disruptors Fund',   'Industrials',        8.0),
('Tech Disruptors Fund',   'Other',             10.0),

('Emerging Markets Alpha', 'Technology',        28.5),
('Emerging Markets Alpha', 'Financials',        22.0),
('Emerging Markets Alpha', 'Energy',            18.5),
('Emerging Markets Alpha', 'Materials',         15.0),
('Emerging Markets Alpha', 'Other',             16.0),

('Asia Pacific Growth',    'Technology',        31.2),
('Asia Pacific Growth',    'Financials',        25.0),
('Asia Pacific Growth',    'Consumer Staples',  20.0),
('Asia Pacific Growth',    'Industrials',       12.8),
('Asia Pacific Growth',    'Other',             11.0),

('Small Cap Momentum',     'Technology',        25.8),
('Small Cap Momentum',     'Healthcare',        22.0),
('Small Cap Momentum',     'Industrials',       20.0),
('Small Cap Momentum',     'Consumer Discretionary', 18.0),
('Small Cap Momentum',     'Other',             14.2),

('Global Balanced',        'Technology',        22.1),
('Global Balanced',        'Financials',        20.0),
('Global Balanced',        'Healthcare',        18.0),
('Global Balanced',        'Consumer Staples',  15.0),
('Global Balanced',        'Other',             24.9),

('US Equity Core',         'Technology',        18.0),
('US Equity Core',         'Financials',        22.0),
('US Equity Core',         'Healthcare',        20.0),
('US Equity Core',         'Energy',            12.0),
('US Equity Core',         'Other',             28.0),

('Dividend Income',        'Financials',        30.0),
('Dividend Income',        'Utilities',         25.0),
('Dividend Income',        'Consumer Staples',  22.0),
('Dividend Income',        'Technology',         8.3),
('Dividend Income',        'Other',             14.7),

('European Value',         'Financials',        28.0),
('European Value',         'Industrials',       24.0),
('European Value',         'Consumer Staples',  20.0),
('European Value',         'Technology',        12.5),
('European Value',         'Other',             15.5),

('Fixed Income Plus',      'Government Bonds',  45.0),
('Fixed Income Plus',      'Corporate Bonds',   35.0),
('Fixed Income Plus',      'Cash',              12.0),
('Fixed Income Plus',      'Technology',         3.0),
('Fixed Income Plus',      'Other',              5.0);

