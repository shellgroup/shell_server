package com.winnerdt.modules.job.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.common.utils.Query;
import com.winnerdt.modules.job.dao.ScheduleJobLogDao;
import com.winnerdt.modules.job.entity.ScheduleJobLogEntity;
import com.winnerdt.modules.job.service.ScheduleJobLogService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("scheduleJobLogService")
public class ScheduleJobLogServiceImpl extends ServiceImpl<ScheduleJobLogDao, ScheduleJobLogEntity> implements ScheduleJobLogService {

	@Override
	public PageUtils queryPage(Map<String, Object> params) {
		String jobId = (String)params.get("jobId");
		String beanName = (String)params.get("beanName");
		String methodName = (String)params.get("methodName");
		String beginDate = (String)params.get("beginDate");
		String endDate = (String)params.get("endDate");
		boolean createDateFlag = false;
		if(StringUtils.isNotBlank(beginDate) && StringUtils.isNotBlank(endDate)){
			createDateFlag = true;
		}
		String statusStr = (String)params.get("status");
		Boolean statusTemp1 = false;
		Boolean statusTemp2 = false;
		if(statusStr != null ){
			if(statusStr.equals("0")){
				statusTemp1 = true;
			}else if(statusStr.equals("1")){
				statusTemp2 = true;
			}

		}

		Page<ScheduleJobLogEntity> page = (Page<ScheduleJobLogEntity>) this.page(
				new Query<ScheduleJobLogEntity>(params).getPage(),
				new QueryWrapper<ScheduleJobLogEntity>()
						.like(StringUtils.isNotBlank(jobId),"job_id", jobId)
						.like(StringUtils.isNotBlank(beanName),"bean_name", beanName)
						.like(StringUtils.isNotBlank(methodName),"method_name",methodName)
						.eq(statusTemp1,"status",0)
						.eq(statusTemp2,"status",1)
						.between(createDateFlag,"create_time",beginDate,endDate)
		);

		return new PageUtils(page);
	}

}
