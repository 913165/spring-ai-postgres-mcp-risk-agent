package com.example.riskagent.agent;

import com.example.riskagent.tools.RiskToolHints;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.tool.ToolCallbackProvider;
import org.springframework.stereotype.Component;

@Component
public class RiskAgentClient {

    private static final Logger log = LoggerFactory.getLogger(RiskAgentClient.class);

    private final ChatClient chatClient;
    private final ToolCallbackProvider mcpTools;

    // Exactly like the working MySQL MCP example — inject ToolCallbackProvider directly
    public RiskAgentClient(ChatClient chatClient, ToolCallbackProvider mcpTools) {
        this.chatClient = chatClient;
        this.mcpTools = mcpTools;
        log.info("RiskAgentClient ready. MCP tools: {}", mcpTools.getToolCallbacks().length);
    }

    public String analyzeRisk(String question) {
        log.info("Analyzing risk question: {}", question);
        try {
            return chatClient.prompt()
                    .system(RiskToolHints.behaviorPrompt())
                    .user(question)
                    .toolCallbacks(mcpTools)
                    .call()
                    .content();
        } catch (Exception e) {
            log.error("AI call failed: {}", e.getMessage(), e);
            throw new RuntimeException("AI model error: " + e.getMessage(), e);
        }
    }
}
