package com.winnerdt.config;

import com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceBuilder;
import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.core.MybatisConfiguration;
import com.baomidou.mybatisplus.core.config.GlobalConfig;
import com.baomidou.mybatisplus.extension.injector.LogicSqlInjector;
import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import com.baomidou.mybatisplus.extension.spring.MybatisSqlSessionFactoryBean;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.JdbcType;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;

/**
 * @author:zsk
 * @CreateTime:2019-04-25 13:39
 */
@Configuration
public class MybatisConfig {
    @Value("${spring.profiles.active:#{null}}")
    private String operatingEnvironment;

    @Bean
    public PaginationInterceptor paginationInterceptor() {
        return new PaginationInterceptor();
    }

    @Bean
    @ConfigurationProperties("spring.datasource.druid" )
    public DataSource dataSource() {
        return DruidDataSourceBuilder
                .create()
                .build();
    }

    // 创建全局配置
    @Bean
    public GlobalConfig GlobalConfig() {
        // 全局配置文件
        GlobalConfig globalConfig = new GlobalConfig();
        GlobalConfig.DbConfig dbConfig = new GlobalConfig.DbConfig();
        // 默认为自增
        dbConfig.setIdType(IdType.AUTO);
        // 手动指定db 的类型, 这里是mysql
        dbConfig.setDbType(DbType.MYSQL);
        globalConfig.setDbConfig(dbConfig);

        // 如果是dev环境,则使用 reload xml的功能,方便调试
        if(operatingEnvironment.equals("dev")){
            globalConfig.setRefresh(true);
        }

        // 逻辑删除注入器
        LogicSqlInjector injector = new LogicSqlInjector();
        globalConfig.setSqlInjector(injector);
        return globalConfig;
    }
    @Bean("sqlSessionFactory")
    public SqlSessionFactory sqlSessionFactory() throws Exception {
        //***导入MybatisSqlSession配置***
        MybatisSqlSessionFactoryBean sqlSessionFactory = new MybatisSqlSessionFactoryBean();
        //指明数据源
        sqlSessionFactory.setDataSource(dataSource());
        //指明mapper.xml位置(配置文件中指明的xml位置会失效用此方式代替，具体原因未知)
        sqlSessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath*:mapper/**/*.xml"));
        //指明实体扫描(多个package用逗号或者分号分隔)
        sqlSessionFactory.setTypeAliasesPackage("com.winnerdt.modules.*.entity");

        //***导入Mybatis配置***
        MybatisConfiguration configuration = new MybatisConfiguration();
        configuration.setJdbcTypeForNull(JdbcType.NULL);
        configuration.setMapUnderscoreToCamelCase(true);
        configuration.setCacheEnabled(false);
        sqlSessionFactory.setConfiguration(configuration);
        sqlSessionFactory.setPlugins(new Interceptor[]{paginationInterceptor()});

        //***导入全局配置***
        sqlSessionFactory.setGlobalConfig(GlobalConfig());
        return sqlSessionFactory.getObject();
    }
}
