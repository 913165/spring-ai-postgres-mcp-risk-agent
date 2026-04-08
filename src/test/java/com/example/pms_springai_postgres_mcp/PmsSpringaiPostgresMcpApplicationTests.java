package com.example.pms_springai_postgres_mcp;

import com.example.riskagent.RiskAgentApplication;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(
        classes = RiskAgentApplication.class,
        properties = {
                "spring.ai.openai.api-key=test-key",
                "spring.ai.mcp.client.enabled=false"
        }
)
class PmsSpringaiPostgresMcpApplicationTests {

    @Test
    void contextLoads() {
    }
}
