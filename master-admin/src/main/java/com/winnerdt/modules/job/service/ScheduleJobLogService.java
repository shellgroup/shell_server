package com.winnerdt.modules.job.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.modules.job.entity.ScheduleJobLogEntity;

import java.util.Map;

/**
 * 定时任务日志
 *
 * @author Mark sunlightcs@gmail.com
 * @since 1.2.0 2016-11-28
 */
public interface ScheduleJobLogService extends IService<ScheduleJobLogEntity> {

	PageUtils queryPage(Map<String, Object> params);
	
}
