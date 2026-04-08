package com.example.riskagent.config;

import io.modelcontextprotocol.client.McpSyncClient;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.SimpleLoggerAdvisor;
import org.springframework.ai.mcp.SyncMcpToolCallbackProvider;
import org.springframework.ai.tool.ToolCallbackProvider;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import java.util.List;

@Configuration
public class McpConfig {

    @Bean
    ChatClient chatClient(ChatClient.Builder chatClientBuilder) {
        return chatClientBuilder
                .defaultAdvisors(new SimpleLoggerAdvisor())
                .defaultSystem("""
                                 You are a Risk Portfolio AI Assistant with access to a PostgreSQL database called riskdb.
                        
                                                                                   The database has the following tables in the public schema:
                        
                                                                                   1. portfolio_risk
                                                                                      - Contains risk metrics for portfolios
                        
                                                                                   2. portfolio_sector_exposure
                                                                                      - Columns: id, portfolio_name, sector, exposure_pct
                                                                                      - Contains sector-wise exposure % for each portfolio
                        
                                                                                   STRICT RULES:
                                                                                   - For ANY question about portfolio data, exposure, or risk details → ALWAYS use the execute_sql tool
                                                                                   - NEVER use get_top_queries, analyze_db_health, or analyze_workload_indexes for business data questions
                                                                                   - NEVER mention pg_stat_statements to the user
                                                                                   - NEVER say you cannot retrieve data — always try execute_sql first
                                                                                   - Example query for exposure: SELECT * FROM portfolio_sector_exposure WHERE portfolio_name = 'XYZ'
                        """)
                .build();
    }

    @Bean
    @Primary
    public ToolCallbackProvider mcpToolProvider(List<McpSyncClient> mcpClients) {
        return new SyncMcpToolCallbackProvider(mcpClients);
    }
}
