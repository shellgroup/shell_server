package com.winnerdt.modules.qrcode.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.winnerdt.common.annotation.DataFilter;
import com.winnerdt.common.utils.Constant;
import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.common.utils.Query;
import com.winnerdt.common.utils.R;
import com.winnerdt.modules.qrcode.dao.WxUserManageDao;
import com.winnerdt.modules.qrcode.entity.WxUserManageEntity;
import com.winnerdt.modules.qrcode.service.WxUserManageService;
import com.winnerdt.modules.sys.service.SysDeptService;
import com.winnerdt.modules.sys.shiro.ShiroUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author:zsk
 * @CreateTime:2019-04-24 14:53
 */
@Service
public class WxUserManageServiceImpl extends ServiceImpl<WxUserManageDao, WxUserManageEntity> implements WxUserManageService {
    private static final Logger logger = LoggerFactory.getLogger(WxUserManageServiceImpl.class);
    @Autowired
    private WxUserManageDao wxUserManageDao;
    @Autowired
    private SysDeptService sysDeptService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<WxUserManageEntity> page = new Query<WxUserManageEntity>(params).getPage();
        Map map = new HashMap();
        //处理需要的参数
        try{
            if(null != params.get("nickName")){
                map.put("nickName",params.get("nickName"));
            }
            if(null != params.get("phone")){
                map.put("phone",params.get("phone"));
            }
            if(null != params.get("createBeginTime") && null != params.get("createEndTime")){
                map.put("createBeginTime",params.get("createBeginTime"));
                map.put("createEndTime",params.get("createEndTime"));
            }

            map.put("pageSize",page.getSize());
            map.put("currRecord",(page.getCurrent()-1)*page.getSize());
        }catch (Exception e){
            e.printStackTrace();
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("微信小程序用户列表，处理参数异常，异常时间："+now+":::异常数据："+params.toString()+":::异常原因："+e.toString());

        }


        /*
         * 使用自定义的sql
         * */
        page.setRecords(wxUserManageDao.queryWxUserListPage(map));
        page.setTotal(wxUserManageDao.queryWxUserListPageTotal(map));


        return new PageUtils(page);
    }

    @Override
    public WxUserManageEntity queryWxUserInfoById(Integer wxUserId) {
        return null;
    }

    @Override
    public void update(WxUserManageEntity wxUserManageEntity) throws Exception {

    }

    @Override
    public void deleteBatch(Long[] wxUserIds) {

    }

    @Override
    public WxUserManageEntity queryWxUserById(Integer wxUserId) {
        return wxUserManageDao.queryWxUserById(wxUserId);
    }


    @Override
    @DataFilter(subDept = true, user = false)
    public List<WxUserManageEntity> queryWxUserEntityListByDataFilter(Map map) {
        List<WxUserManageEntity> wxUserManageEntityList = wxUserManageDao.selectList(new QueryWrapper<WxUserManageEntity>()
                .apply(map.get(Constant.SQL_FILTER) != null, (String)map.get(Constant.SQL_FILTER)));
        return wxUserManageEntityList;
    }

    @Override
    @DataFilter(subDept = true, user = false)
    public Integer queryWxUserTotleByDataFilter(Map map) {
        Integer  wxUserTotle= wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .apply(map.get(Constant.SQL_FILTER) != null, (String)map.get(Constant.SQL_FILTER)));
        return wxUserTotle;
    }

    @Override
    public List<WxUserManageEntity> queryWxUserEntityListByDeptId(Map map) throws Exception {
        if(null == map.get("deptId")){
            throw new Exception("拉新会员信息统计，参数缺失");
        }
        Long deptId = Long.valueOf(map.get("deptId").toString());
        List<WxUserManageEntity> wxUserManageEntityList = wxUserManageDao.selectList(new QueryWrapper<WxUserManageEntity>()
                .apply(true, getSql(deptId,true,""))
        );
        return wxUserManageEntityList;
    }

    @Override
    public Integer queryWxUserTotleByDeptId(Map map) throws Exception {
        if(null == map.get("deptId")){
            throw new Exception("拉新会员数量统计，参数缺失");
        }
        Long deptId = Long.valueOf(map.get("deptId").toString());
        Integer  wxUserTotle= wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .apply(true, getSql(deptId,true,"")));
        return wxUserTotle;
    }

    @Override
    public R queryWxUserTotleLastWeek(Map map) {
        //获取当前的deptid
        Long deptId = ShiroUtils.getUserEntity().getDeptId();
        //获取当前的时间
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String nowDateTemp = sdf.format(date);
        //获取前七天的时间
        String pastDateTemp = getPastDate(7);

        /*
        * 处理时间用于数据库查询
        * */
        String pastDate = pastDateTemp + " 00:00:00";
        String nowDate = nowDateTemp + " 23:59:59";

        //开始拼接sql查询
        List<Map<String,Object>> resultList = wxUserManageDao.selectMaps(new QueryWrapper<WxUserManageEntity>()
                .select("DATE_FORMAT(create_date,'%Y-%m-%d') as x,count(id) as y")
                .apply(true, getSql(deptId,true,""))
                .between("create_date",pastDate,nowDate)
                .isNotNull("create_date")
                .groupBy("DATE_FORMAT(create_date,'%Y-%m-%d')")
        );

        resultList.stream().map(map1 ->{
            String dateTemp = map1.get("x").toString();
            map1.put("x",dateTemp.substring(dateTemp.lastIndexOf("-")+1,dateTemp.length())+"日");
            return map1;
        }).collect(Collectors.toList());

        return R.ok().put("result",resultList);
    }

    @Override
    public R queryRankingMsg(Map map) {
        

        return null;
    }

    /*
    * 通过deptId，拼接查询sql
    * */
    private String getSql(Long deptId,boolean isContainMyDept,String tableAlias){

        //获取表的别名
        if(StringUtils.isNotBlank(tableAlias)){
            tableAlias +=  ".";
        }

        //部门ID列表
        Set<Long> deptIdList = new HashSet<>();
        if(isContainMyDept){
            deptIdList.add(deptId);
        }

        //子部门ID列表
        List<Long> subDeptIdList = sysDeptService.getSubDeptIdList(deptId);
        deptIdList.addAll(subDeptIdList);


        StringBuilder sqlFilter = new StringBuilder();
        sqlFilter.append(" (");

        if(deptIdList.size() > 0){
            sqlFilter.append(tableAlias).append("dept_id").append(" in(").append(StringUtils.join(deptIdList, ",")).append(")");
        }

        sqlFilter.append(")");

        if(sqlFilter.toString().trim().equals("()")){
            return null;
        }
        return sqlFilter.toString();
    }

    /*
    * 获取过去第几天的时间
    * */
    public static String getPastDate(int past) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - past);
        Date today = calendar.getTime();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String result = format.format(today);
        return result;
    }
}
