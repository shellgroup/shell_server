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
import com.winnerdt.modules.qrcode.utils.DateUtil;
import com.winnerdt.modules.sys.entity.SysDeptEntity;
import com.winnerdt.modules.sys.service.SysDeptService;
import com.winnerdt.modules.sys.service.SysRoleDeptService;
import com.winnerdt.modules.sys.service.SysUserRoleService;
import com.winnerdt.modules.sys.shiro.ShiroUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.text.ParseException;
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
    @Autowired
    private SysRoleDeptService sysRoleDeptService;
    @Autowired
    private SysUserRoleService sysUserRoleService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        //获取当前的deptid
        Long deptId = ShiroUtils.getUserEntity().getDeptId();

        Long userId = ShiroUtils.getUserId();

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
            //查询拥有的部门id
            //部门ID列表
            Set<Long> deptIdList = new HashSet<>();
            //是否需要角色分配下的deptId
            List<Long> roleIdList = sysUserRoleService.queryRoleIdList(userId);
            if(roleIdList.size() > 0){
                List<Long> userDeptIdList = sysRoleDeptService.queryDeptIdList(roleIdList.toArray(new Long[roleIdList.size()]));
                deptIdList.addAll(userDeptIdList);
            }
            //管理员子部门ID列表
            List<Long> subDeptIdList = sysDeptService.getSubDeptIdList(deptId);
            deptIdList.addAll(subDeptIdList);
            map.put("deptIdList",deptIdList);

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
                .apply(true, getSql(deptId,true,"",false,null))
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
                .apply(true, getSql(deptId,true,"",false,null)));
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
        String pastDateTemp = DateUtil.getPastDate(7);

        /*
        * 处理时间用于数据库查询
        * */
        String pastDate = pastDateTemp + " 00:00:00";
        String nowDate = nowDateTemp + " 23:59:59";

        //开始拼接sql查询
        List<Map<String,Object>> salesData = wxUserManageDao.selectMaps(new QueryWrapper<WxUserManageEntity>()
                .select("DATE_FORMAT(create_date,'%Y-%m-%d') as x,count(id) as y")
                .apply(true, getSql(deptId,true,"",false,null))
                .between("create_date",pastDate,nowDate)
                .isNotNull("create_date")
                .groupBy("DATE_FORMAT(create_date,'%Y-%m-%d')")
        );

        salesData.stream().map(map1 ->{
            String dateTemp = map1.get("x").toString();
            map1.put("x",dateTemp.substring(dateTemp.lastIndexOf("-")+1,dateTemp.length())+"日");
            return map1;
        }).collect(Collectors.toList());

        return R.ok().put("salesData",salesData);
    }

    /*
     * 角色的数据授权只会记录选择的最后的节点信息，用户所属部门可以选择不同的节点部门。
     *
     *一般情况下，用户所属部门不是最后的节点，查询部门拉新的时候只查询下个部门的拉新数量，将下下部门的拉新数归总到下个部门。
     * 角色的数据授权只会记录最后节点的信息（就算你选的倒数第二个节点，数据库记录也会分别将倒数第二个节点下的最后的节点都记录上，没有有关倒数
     * 第二个节点的信息）‘
     *
     * 所以统计拉新记录的时候，首先统计该用户部门下的各个下级部门的拉新情况，然后统计角色下的各个最后的节点的拉新数目。
     *
     * 先查询用户所属部门下的所有的子部门id，然后查询角色下的所有的部门id，对比一下，将角色里面有的，而用户所属部门没有的查询一下
     */
    @Override
    public R queryRankingMsg(Map<String,String> map) {
        //获取当前的deptid
        Long deptId = ShiroUtils.getUserEntity().getDeptId();
        Long userId = ShiroUtils.getUserId();

        //时间
        String createBeginTime = null;
        String createEndTime = null;
        boolean createTimeBoolean = false;
        if(null != map.get("createBeginTime") && null != map.get("createEndTime")){
            createBeginTime = map.get("createBeginTime");
            createEndTime = map.get("createEndTime");
            createTimeBoolean = true;
        }


        LinkedList<LinkedHashMap<String,Object>> resultListTemp = new LinkedList();

        //管理员子部门ID列表
        //获取管理员子部门的直接下级部门id
        List<Long> childrenDeptIdList = sysDeptService.queryDetpIdList(deptId);
        for(Long deptIdTemp:childrenDeptIdList){
            Integer  wxUserTotle= wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                    .between(createTimeBoolean,"create_date",createBeginTime,createEndTime)
                    .apply(true, getSql(deptIdTemp,true,"",false,null)));
            LinkedHashMap<String,Object> resultMapTemp = new LinkedHashMap();
            resultMapTemp.put("deptId",deptIdTemp);
            resultMapTemp.put("totle",wxUserTotle);
            resultListTemp.add(resultMapTemp);
        }

        //对比角色中的部门id和管理员拥有的部门id
        List<Long> adminDeptIdList = sysDeptService.getSubDeptIdList(deptId);
        Set<Long> roleDeptIdList = new HashSet<>();
        List<Long> roleIdList = sysUserRoleService.queryRoleIdList(userId);
        if(roleIdList.size() > 0){
            List<Long> userDeptIdList = sysRoleDeptService.queryDeptIdList(roleIdList.toArray(new Long[roleIdList.size()]));
            roleDeptIdList.addAll(userDeptIdList);
        }
        List<Long> diffDeptIdList  = getDifferent(adminDeptIdList,roleIdList);
        List<Long> finRoleDeptId = new ArrayList<>();
        for (Long roleDeptId:roleDeptIdList){
            if(diffDeptIdList.contains(roleDeptId)){
                finRoleDeptId.add(roleDeptId);
            }
        }
        for(Long deptIdTemp:finRoleDeptId){
            Integer  wxUserTotle= wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                    .between(createTimeBoolean,"create_date",createBeginTime,createEndTime)
                    .apply(true, getSql(deptIdTemp,true,"",false,null)));
            LinkedHashMap<String,Object> resultMapTemp = new LinkedHashMap();
            resultMapTemp.put("deptId",deptIdTemp);
            resultMapTemp.put("totle",wxUserTotle);
            resultListTemp.add(resultMapTemp);
        }

        //处理查询结果

        /*
        * 以防万一，去重一下
        * */
        HashSet h = new HashSet(resultListTemp);
        resultListTemp.clear();
        resultListTemp.addAll(h);

        //排序
        Collections.sort(resultListTemp, new Comparator<Map<String, Object>>() {
            public int compare(Map<String, Object> o1, Map<String, Object> o2) {
                Integer totle1 = Integer.valueOf(o1.get("totle").toString()) ;
                Integer totle2 = Integer.valueOf(o2.get("totle").toString()) ;
                return totle2.compareTo(totle1);
            }
        });

        //存放最终的结果
        List<LinkedHashMap<String,Object>> resultList = new ArrayList<>();

        //控制排名展示的数量，同时查询部门名称添加进入
        int num = 0;
        for(LinkedHashMap map1:resultListTemp){
            if(num < 100){
                num++;
                SysDeptEntity sysDeptEntity = sysDeptService.getById(Integer.valueOf(map1.get("deptId").toString()));
                map1.put("deptName",sysDeptEntity.getName());
                resultList.add(map1);
            }else {
                break;
            }

        }

        return R.ok().put("result",resultListTemp);
    }

    @Override
    public R WxUserInfoByDataFilter() throws ParseException {

        //总的拉新数目
        Map map = new HashMap();
        Integer totle = this.queryWxUserTotleByDataFilter(map);


        //获取当前的deptid
        Long deptId = ShiroUtils.getUserEntity().getDeptId();

        Long userId = ShiroUtils.getUserId();


        //今日拉新数量

        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String nowDateTemp = sdf.format(date);
        String nowDateStart = nowDateTemp + " 00:00:00";
        String nowDateEnd = nowDateTemp + " 23:59:59";
        Integer todayTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .between("create_date",nowDateStart,nowDateEnd)
                .apply(true, getSql(deptId,true,"",true,userId))
        );

        //昨天拉新数量
        String yesterdayTemp = DateUtil.getPastDate(1);
        String yesterdayStart = yesterdayTemp+" 00:00:00";
        String yesterdayEnd = yesterdayTemp + " 23:59:59";
        Integer yesterdayTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .between("create_date",yesterdayStart,yesterdayEnd)
                .apply(true, getSql(deptId,true,"",true,userId))
        );

        //日同比
        String dayPercentage = null;
        if(!(yesterdayTotle.equals(0))){
            DecimalFormat df=new DecimalFormat("0.00");
            dayPercentage = df.format((todayTotle-yesterdayTotle)/(float)yesterdayTotle);
        }else {
            dayPercentage = "无";
        }


        //本周数据
        String nowWeekStart = DateUtil.getWeekStart(date);
        String nowWeekEnd = DateUtil.getWeekEnd(date);
        Integer nowWeekTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .between("create_date",nowWeekStart,nowWeekEnd)
                .apply(true, getSql(deptId,true,"",true,userId))
        );
        //上周数据
        String lastWeekStart = DateUtil.getLastWeekStart();
        String lastWeekEnd = DateUtil.getLastWeekEnd();
        Integer lastWeekTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .between("create_date",lastWeekStart,lastWeekEnd)
                .apply(true, getSql(deptId,true,"",true,userId))
        );

        //周同比
        String weekPercentage = null;
        if(!(lastWeekTotle.equals(0))){
            DecimalFormat df=new DecimalFormat("0.00");
            weekPercentage = df.format((nowWeekTotle-lastWeekTotle)/(float)lastWeekTotle);
        }else {
            weekPercentage = "无";
        }

        Map resultMap = new HashMap();
        resultMap.put("totle",totle);
        resultMap.put("dayPercentage",dayPercentage);
        resultMap.put("weekPercentage",weekPercentage);
        resultMap.put("todayTotle",todayTotle);

        return R.ok().put("resultMap",resultMap);
    }

    /*
    * 通过deptId，拼接查询sql
    * */
    private String getSql(Long deptId,boolean isContainMyDept,String tableAlias,boolean isContainRole,Long userId){

        //获取表的别名
        if(StringUtils.isNotBlank(tableAlias)){
            tableAlias +=  ".";
        }

        //部门ID列表
        Set<Long> deptIdList = new HashSet<>();
        if(isContainMyDept){
            deptIdList.add(deptId);
        }
        //是否需要角色分配下的deptId
        if(isContainRole){
            List<Long> roleIdList = sysUserRoleService.queryRoleIdList(userId);
            if(roleIdList.size() > 0){
                List<Long> userDeptIdList = sysRoleDeptService.queryDeptIdList(roleIdList.toArray(new Long[roleIdList.size()]));
                deptIdList.addAll(userDeptIdList);
            }
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

    public static List<Long> getDifferent(List<Long> list1, List<Long> list2) {
        Map<Long,Integer> map = new HashMap<Long,Integer>(list1.size()+list2.size());
        List<Long> diff = new ArrayList<Long>();
        List<Long> maxList = list1;
        List<Long> minList = list2;
        if(list2.size()>list1.size()) {
            maxList = list2;
            minList = list1;
        }

        for (Long string : maxList) {
            map.put(string, 1);
        }

        for (Long string : minList) {
            Integer cc = map.get(string);
            if(cc!=null) {
                map.put(string, ++cc);
                continue;
            }
            map.put(string, 1);
        }

        for(Map.Entry<Long, Integer> entry:map.entrySet()) {
            if(entry.getValue()==1) {
                diff.add(entry.getKey());
            }
        }
        return diff;
    }
}
