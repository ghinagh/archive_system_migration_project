package com.startupstack.app.config.async;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;

@Configuration
@EnableAsync
public class AsyncConfig {

    /**
     * Runs the archive delivery batches (legacy Command5 / Command14).
     *
     * <p>Deliberately single-threaded: legacy serialised every ffmpeg invocation on
     * {@code WaitForSingleObject(m_max, INFINITE)}, and transcoding is IO- and CPU-bound
     * enough that running batches concurrently would slow all of them down and contend for
     * the same archive volumes. Queued jobs wait their turn instead.
     */
    @Bean("mediaJobExecutor")
    public Executor mediaJobExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(1);
        executor.setMaxPoolSize(1);
        executor.setQueueCapacity(50);
        executor.setThreadNamePrefix("media-job-");
        executor.initialize();
        return executor;
    }
}
