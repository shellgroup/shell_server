package com.winnerdt.modules.job.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.winnerdt.common.utils.Constant;
import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.common.utils.Query;
import com.winnerdt.modules.job.dao.ScheduleJobDao;
import com.winnerdt.modules.job.entity.ScheduleJobEntity;
import com.winnerdt.modules.job.service.ScheduleJobService;
import com.winnerdt.modules.job.utils.ScheduleUtils;
import org.apache.commons.lang.StringUtils;
import org.quartz.CronTrigger;
import org.quartz.Scheduler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import java.util.*;

@Service("scheduleJobService")
public class ScheduleJobServiceImpl extends ServiceImpl<ScheduleJobDao, ScheduleJobEntity> implements ScheduleJobService {
	@Autowired
    private Scheduler scheduler;
	
	/**
	 * 项目启动时，初始化定时器
	 */
	@PostConstruct
	public void init(){
		List<ScheduleJobEntity> scheduleJobList = this.list(null);
		for(ScheduleJobEntity scheduleJob : scheduleJobList){
			CronTrigger cronTrigger = ScheduleUtils.getCronTrigger(scheduler, scheduleJob.getJobId());
            //如果不存在，则创建
            if(cronTrigger == null) {
                ScheduleUtils.createScheduleJob(scheduler, scheduleJob);
            }else {
                ScheduleUtils.updateScheduleJob(scheduler, scheduleJob);
            }
		}
	}

	@Override
	public PageUtils queryPage(Map<String, Object> params) {
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
		Page<ScheduleJobEntity> page = (Page<ScheduleJobEntity>) this.page(
				new Query<ScheduleJobEntity>(params).getPage(),
				new QueryWrapper<ScheduleJobEntity>()
						.like(StringUtils.isNotBlank(beanName),"bean_name", beanName)
						.like(StringUtils.isNotBlank(methodName),"method_name",methodName)
						.eq(statusTemp1,"status",0)
						.eq(statusTemp2,"status",1)
						.between(createDateFlag,"create_time",beginDate,endDate)
		);

		return new PageUtils(page);
	}


	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean save(ScheduleJobEntity scheduleJob) {
		scheduleJob.setCreateTime(new Date());
		scheduleJob.setStatus(Constant.ScheduleStatus.NORMAL.getValue());
        super.save(scheduleJob);
        
        ScheduleUtils.createScheduleJob(scheduler, scheduleJob);

        return true;
    }
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void update(ScheduleJobEntity scheduleJob) {
        ScheduleUtils.updateScheduleJob(scheduler, scheduleJob);
                
        this.updateById(scheduleJob);
    }

	@Override
	@Transactional(rollbackFor = Exception.class)
    public void deleteBatch(Long[] jobIds) {
    	for(Long jobId : jobIds){
    		ScheduleUtils.deleteScheduleJob(scheduler, jobId);
    	}
    	
    	//删除数据
    	this.removeByIds(Arrays.asList(jobIds));
	}

	@Override
    public int updateBatch(Long[] jobIds, int status){
    	Map<String, Object> map = new HashMap<>();
    	map.put("list", jobIds);
    	map.put("status", status);
    	return baseMapper.updateBatch(map);
    }
    
	@Override
	@Transactional(rollbackFor = Exception.class)
    public void run(Long[] jobIds) {
    	for(Long jobId : jobIds){
    		ScheduleUtils.run(scheduler, this.getById(jobId));
    	}
    }

	@Override
	@Transactional(rollbackFor = Exception.class)
    public void pause(Long[] jobIds) {
        for(Long jobId : jobIds){
    		ScheduleUtils.pauseJob(scheduler, jobId);
    	}
        
    	updateBatch(jobIds, Constant.ScheduleStatus.PAUSE.getValue());
    }

	@Override
	@Transactional(rollbackFor = Exception.class)
    public void resume(Long[] jobIds) {
    	for(Long jobId : jobIds){
    		ScheduleUtils.resumeJob(scheduler, jobId);
    	}

    	updateBatch(jobIds, Constant.ScheduleStatus.NORMAL.getValue());
    }
    
}
