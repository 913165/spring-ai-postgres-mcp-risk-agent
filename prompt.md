# Objective

Create a production-quality Spring Boot application that uses Spring AI to communicate with a Postgres MCP Server instead of connecting directly to PostgreSQL.

The application should demonstrate how an AI agent can query financial risk data using tools exposed by an MCP server.

The system should simulate a real-world scenario similar to asset management firms (e.g. BlackRock style risk analytics).

The AI agent should receive a natural language query from the user, decide when to call MCP tools, send parameters, and produce a summarized response.

---

# High Level Architecture

User → REST API → Spring AI Agent → MCP Client → Postgres MCP Server → PostgreSQL DB

The AI agent must never directly connect to PostgreSQL.

All database access must happen via MCP tools.

---

# Technology Stack

Java 25 or later  
Spring Boot 4.0.5 or later
Spring AI     <spring-ai.version>2.0.0-M4</spring-ai.version>
OpenAI Chat Model  
Spring AI MCP Client  
Maven  
Thymeleaf UI  
PostgreSQL (used only by MCP server, not by Spring Boot app)

---

# Business Use Case

Risk monitoring system for investment portfolios.

Example questions the AI agent should answer:

• Show portfolios with daily loss greater than 5%  
• Which portfolios have technology exposure above 20%?  
• Summarize high risk portfolios  
• Which funds show abnormal risk today?  
• Which portfolios require risk review?

---

# MCP Server Tools (assume server already exists)

Tool 1:

name: get_high_risk_portfolios

description:
Returns portfolios where daily loss is greater than the specified percentage and technology exposure is above 20%.

input schema:

{
"lossPercent": number
}

response example:

[
{
"portfolioName": "Global Tech Growth",
"dailyLoss": 6.5,
"techExposure": 34
}
]

---

Tool 2:

name: get_portfolio_exposure

description:
Returns sector exposure of a portfolio

input schema:

{
"portfolioName": string
}

---

# Project Requirements

Generate a complete Spring Boot project with proper package structure and clean code.

Follow hexagonal or layered architecture.

---

# Package Structure

com.example.riskagent

config
controller
service
agent
model
tools
ui

---

# Maven Dependencies

Include:

spring-boot-starter-web
spring-boot-starter-thymeleaf
spring-ai-openai-spring-boot-starter
spring-ai-mcp-client-spring-boot-starter
lombok

---

# application.yml

Configure OpenAI and MCP client.

Example:

spring:
ai:

    openai:
      api-key: ${OPENAI_API_KEY}

    mcp:
      client:
        enabled: true

        servers:

          postgres-risk-server:
            url: http://localhost:8081

logging:
level:
org.springframework.ai: DEBUG

---

# Configuration Class

Create configuration class that exposes MCP tools to the AI agent.

Use McpToolCallbackProvider.

---

# AI Agent Service Requirements

Create a service that:

uses ChatClient

registers MCP tools

accepts natural language prompt

returns AI response

Example:

analyzeRisk(String prompt)

---

# REST Controller

Create REST endpoint:

GET /api/risk?q=

Example:

/api/risk?q=Show portfolios with loss greater than 5%

---

# Thymeleaf UI

Create simple UI page:

input box for question

submit button

response area

Use Bootstrap styling.

---

# Agent Behaviour

The AI agent should:

understand natural language questions

decide when to call MCP tools

call correct MCP tool with parameters

combine tool results with reasoning

return summary explanation

---

# Example Prompt Flow

User:

Which portfolios have high risk?

AI:

calls tool get_high_risk_portfolios

lossPercent = 5

Tool response returned.

AI summarizes:

2 portfolios show significant downside risk due to high technology exposure.

---

# Java Classes to Generate

RiskAgentService

RiskController

McpConfig

RiskResponse model

PortfolioRisk model

Thymeleaf Controller

HTML page

---

# Coding Style

Use constructor injection.

Use Lombok where helpful.

Write clean readable code.

Add comments explaining MCP usage.

Avoid unnecessary complexity.

---

# Extra Requirements

Log tool calls.

Add exception handling.

Ensure code compiles.

Provide example curl command.

---

# Example curl

curl "http://localhost:8080/api/risk?q=Show portfolios with loss greater than 5%"

---

# Deliverables

Full Spring Boot project.

Working AI agent.

MCP client integration.

Working REST endpoint.

Working UI page.

Clear package structure.

---

# Important Constraint

DO NOT connect directly to PostgreSQL.

ALL database interaction must happen via MCP tools.

---

# Nice to Have

Add second MCP tool usage example.

Add prompt examples.

Add comments explaining how MCP differs from JDBC.
