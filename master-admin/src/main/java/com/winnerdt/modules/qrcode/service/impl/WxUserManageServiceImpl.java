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
import com.winnerdt.modules.qrcode.entity.AutofillRulesEntity;
import com.winnerdt.modules.qrcode.entity.ProfilesEntity;
import com.winnerdt.modules.qrcode.entity.WxUserManageEntity;
import com.winnerdt.modules.qrcode.service.WxUserManageService;
import com.winnerdt.modules.qrcode.utils.DateUtil;
import com.winnerdt.modules.qrcode.utils.ExcelForFormUtil;
import com.winnerdt.modules.qrcode.utils.ExcelUtil;
import com.winnerdt.modules.sys.entity.SysDeptEntity;
import com.winnerdt.modules.sys.service.SysDeptService;
import com.winnerdt.modules.sys.service.SysRoleDeptService;
import com.winnerdt.modules.sys.service.SysUserRoleService;
import com.winnerdt.modules.sys.shiro.ShiroUtils;
import org.apache.commons.collections4.map.LinkedMap;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
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
//    @Autowired
//    private WxUserManageService wxUserManageService;

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
            if(null != params.get("name")){
                map.put("name",params.get("name"));
            }
            if(null != params.get("deptId")){
                map.put("deptId",params.get("deptId"));
            }
            if(null != params.get("idCard")){
                map.put("idCard",params.get("idCard"));
            }
            if(null != params.get("memberType")){
                String memberType = params.get("memberType").toString();
                //memberType，0：全部，1：游客，2：会员，3：开卡会员
                if("0".equals(memberType)){

                }else if("1".equals(memberType)){
                    map.put("isRegist","noRegist");
                }else if("2".equals(memberType)){
                    map.put("isRegist","regist");
                }else if("3".equals(memberType)){
                    map.put("isOpenCard","1");
                }

            }
            if(null != params.get("createBeginTime") && null != params.get("createEndTime")){
                map.put("createBeginTime",params.get("createBeginTime"));
                map.put("createEndTime",params.get("createEndTime"));
            }


            //前端搜索框
            if(null != params.get("deptName")){
                List<SysDeptEntity> sysDeptEntityList = sysDeptService.list(new QueryWrapper<SysDeptEntity>()
                        .like("name",params.get("deptName")));
                if(sysDeptEntityList.size() > 0){
                    List<Long> deptIds = new ArrayList<>();
                    for(SysDeptEntity sysDeptEntity:sysDeptEntityList){
                        deptIds.add(sysDeptEntity.getDeptId());
                    }
                    map.put("deptIds",deptIds);
                }
                /*
                * 如果通过前端搜索框搜索的不为空，则进一步加载拥有权限的部门id，否则就不加载拥有权限的部门，使前端搜索结果为空
                * */
                if(null != map.get("deptIds")){
                    //查询拥有的部门id
                    //部门ID列表
                    Set<Long> deptIdList = new HashSet<>();
                    //添加上自己的部门id
                    deptIdList.add(deptId);

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
                }else {
                    /*
                    * 如果通过前端搜索框搜索的部门id为空，说明该部门不存在，进一步说明会员信息应该查询为空。这里就直接返回空信息了
                    * */
                    page.setRecords(null);
                    page.setTotal(0);
                    return new PageUtils(page);
                }

            }else {

                //查询拥有的部门id
                //部门ID列表
                Set<Long> deptIdList = new HashSet<>();
                //添加上自己的部门id
                deptIdList.add(deptId);

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
                .eq("is_regist",1)
                .apply(map.get(Constant.SQL_FILTER) != null, (String)map.get(Constant.SQL_FILTER)));
        return wxUserManageEntityList;
    }

    @Override
    @DataFilter(subDept = true, user = false)
    public Integer queryWxUserTotleByDataFilter(Map map) {
        Integer  wxUserTotle= wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .eq("is_regist",1)
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
                .eq("is_regist",1)
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
                .eq("is_regist",1)
                .apply(true, getSql(deptId,true,"",false,null)));
        return wxUserTotle;
    }

    @Override
    public R queryWxUserTotleLastWeek(Map map) throws ParseException {
        //获取当前的deptid
        Long deptId = ShiroUtils.getUserEntity().getDeptId();

        //获取当前的时间
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String nowDateTemp = sdf.format(date);
        //获取前七天的时间
        String pastDateTemp = DateUtil.getPastDate(6);

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
                .eq("is_regist",1)
                .isNotNull("create_date")
                .groupBy("DATE_FORMAT(create_date,'%Y-%m-%d')")
        );



        /*
        * 判断查询的记录是不是有七天的，如果没有七天的数据，就拼接上一些数据让前端展示
        * */
        if(salesData.size() < 7){
            //获取前七天的日期（包含今天）
            String []  beforeDayStr = DateUtil.getBeforeSevenDay(sdf.parse(DateUtil.getPastDate(-1)));
            List<String> beforeDayList = new ArrayList<>(Arrays.asList(beforeDayStr));

            Map<String,Object> mapTemp1 = new HashMap<>();
            /*
            * 将salesData的数据取出来，放在一个临时的map中，并赋一个标识值：isExit，用于下面的取值对比
            * */
            for(Map map1:salesData){
                mapTemp1.put(map1.get("x").toString(),"isExit");
            }
            /*
            * 获取七天的日期，然后和salesData取出的临时map对比，
            * 如果能取出来值即赋的标识值isExit，说明该日期在salaData中是存在值的，反之每值放入一个0作为值
            * */
            for(String str:beforeDayList){
                if(null == mapTemp1.get(str)){
                    Map<String,Object> mapTemp = new HashMap<>();
                    mapTemp.put("x",str);
                    mapTemp.put("y",0);
                    salesData.add(mapTemp);
                }
            }
        }
        //首先根据日期排序
        Collections.sort(salesData, new Comparator<Map<String, Object>>() {
            @Override
            public int compare(Map<String, Object> o1, Map<String, Object> o2) {
                String date1 = o1.get("x").toString() ;
                String date2 = o2.get("x").toString() ;
                return date1.compareTo(date2);
            }
        });

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
                    .eq("is_regist",1)
                    .apply(true, getSql(deptIdTemp,true,"",false,null)));
            LinkedHashMap<String,Object> resultMapTemp = new LinkedHashMap();
            resultMapTemp.put("deptId",deptIdTemp);
            resultMapTemp.put("totle",wxUserTotle);
            resultListTemp.add(resultMapTemp);
        }

        //对比角色中的部门id和管理员拥有的部门id
        List<Long> adminDeptIdList = sysDeptService.getSubDeptIdList(deptId);
        List<Long> roleDeptIdList = new ArrayList<>();
        List<Long> roleIdList = sysUserRoleService.queryRoleIdList(userId);
        if(roleIdList.size() > 0){
            List<Long> userDeptIdList = sysRoleDeptService.queryDeptIdList(roleIdList.toArray(new Long[roleIdList.size()]));
            roleDeptIdList.addAll(userDeptIdList);
        }
        List<Long> diffDeptIdList  = getDifferent(adminDeptIdList,roleDeptIdList);
        List<Long> finRoleDeptId = new ArrayList<>();
        for (Long roleDeptId:roleDeptIdList){
            if(diffDeptIdList.contains(roleDeptId)){
                finRoleDeptId.add(roleDeptId);
            }
        }
        //去掉角色数据授权中本渠道的id
        if(finRoleDeptId.contains(deptId)){
            finRoleDeptId.remove(deptId);
        }
        for(Long deptIdTemp:finRoleDeptId){
            Integer  wxUserTotle= wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                    .between(createTimeBoolean,"create_date",createBeginTime,createEndTime)
                    .eq("is_regist",1)
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

        return R.ok().put("result",resultList);
    }

    @Override
    public R WxUserInfoByDataFilter() throws ParseException {
        //获取当前的deptid
        Long deptId = ShiroUtils.getUserEntity().getDeptId();

        Long userId = ShiroUtils.getUserId();

        //总的拉新数目（包含本部门和下级部门总拉新数）
        Integer totle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .eq("is_regist",1)
                .apply(true, getSql(deptId,true,"",true,userId)));


        //本部门拉新数量总数
        Integer myselfTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .eq("dept_id",deptId)
                .eq("is_regist",1)
        );

        //下级部门拉新数量
        Integer childrenTotle = totle - myselfTotle;


        //今日拉新数量（包含本部门和下级部门总拉新数）

        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String nowDateTemp = sdf.format(date);
        String nowDateStart = nowDateTemp + " 00:00:00";
        String nowDateEnd = nowDateTemp + " 23:59:59";
        Integer todayTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .between("create_date",nowDateStart,nowDateEnd)
                .eq("is_regist",1)
                .apply(true, getSql(deptId,true,"",true,userId))
        );

        //本部门今日拉新数量
        Integer myselfTodayTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .between("create_date",nowDateStart,nowDateEnd)
                .eq("is_regist",1)
                .eq("dept_id",deptId)
        );

        //子部门今日拉新数
        Integer childrenTodayTotle = todayTotle - myselfTodayTotle;

        //昨天拉新数量
        String yesterdayTemp = DateUtil.getPastDate(1);
        String yesterdayStart = yesterdayTemp+" 00:00:00";
        String yesterdayEnd = yesterdayTemp + " 23:59:59";
        Integer yesterdayTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .between("create_date",yesterdayStart,yesterdayEnd)
                .eq("is_regist",1)
                .apply(true, getSql(deptId,true,"",true,userId))
        );

        //本部门昨天拉新数
        Integer myselfYesterdayTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .between("create_date",yesterdayStart,yesterdayEnd)
                .eq("is_regist",1)
                .eq("dept_id",deptId)
        );
        //子部门昨天拉新数
        Integer childrenYesterdayTotle = yesterdayTotle - myselfYesterdayTotle;



        //本部门日同比
        String myselfDayPercentage = null;
        if(!(myselfYesterdayTotle.equals(0))){
            DecimalFormat df=new DecimalFormat("0.00");
            myselfDayPercentage = df.format((myselfTodayTotle-myselfYesterdayTotle)/(float)myselfYesterdayTotle);
        }else {
            myselfDayPercentage = "无";
        }

        //子部门周同比
        String childrenDayPercentage = null;
        if(!(childrenYesterdayTotle.equals(0))){
            DecimalFormat df=new DecimalFormat("0.00");
            childrenDayPercentage = df.format((childrenTodayTotle-childrenYesterdayTotle)/(float)childrenYesterdayTotle);
        }else {
            childrenDayPercentage = "无";
        }


        //本周数据(包含本部门和子部门总数)
        String nowWeekStart = DateUtil.getWeekStart(date);
        String nowWeekEnd = DateUtil.getWeekEnd(date);
        Integer nowWeekTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .between("create_date",nowWeekStart,nowWeekEnd)
                .eq("is_regist",1)
                .apply(true, getSql(deptId,true,"",true,userId))
        );

        //本部门本周数据
        Integer myselfNowWeekTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .between("create_date",nowWeekStart,nowWeekEnd)
                .eq("dept_id",deptId)
                .eq("is_regist",1)
        );

        //子部门本周数据
        Integer childrenNowWeekTotle = nowWeekTotle - myselfNowWeekTotle;


        //上周数据
        String lastWeekStart = DateUtil.getLastWeekStart();
        String lastWeekEnd = DateUtil.getLastWeekEnd();
        Integer lastWeekTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .between("create_date",lastWeekStart,lastWeekEnd)
                .eq("is_regist",1)
                .apply(true, getSql(deptId,true,"",true,userId))
        );

        //本部门上周数据
        Integer myselfLastWeekTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .between("create_date",lastWeekStart,lastWeekEnd)
                .eq("dept_id",deptId)
                .eq("is_regist",1)
        );

        //子部门上周数据
        Integer childrenLastWeekTotle = lastWeekTotle - myselfLastWeekTotle;

        //本部门周同比
        String myselfWeekPercentage = null;
        if(!(myselfLastWeekTotle.equals(0))){
            DecimalFormat df=new DecimalFormat("0.00");
            myselfWeekPercentage = df.format((myselfNowWeekTotle-myselfLastWeekTotle)/(float)myselfLastWeekTotle);
        }else {
            myselfWeekPercentage = "无";
        }

        //子部门周同比
        String childrenWeekPercentage = null;
        if(!(childrenLastWeekTotle.equals(0))){
            DecimalFormat df=new DecimalFormat("0.00");
            childrenWeekPercentage = df.format((childrenNowWeekTotle-childrenLastWeekTotle)/(float)childrenLastWeekTotle);
        }else {
            childrenWeekPercentage = "无";
        }

        Map resultMap = new HashMap();
        //装填有关本部门的数据
        resultMap.put("myselfTotle",myselfTotle);
        resultMap.put("myselfDayPercentage",myselfDayPercentage);
        resultMap.put("myselfWeekPercentage",myselfWeekPercentage);
        resultMap.put("myselfTodayTotle",myselfTodayTotle);

        //装填子部门的数据
        resultMap.put("childrenTotle",childrenTotle);
        resultMap.put("childrenDayPercentage",childrenDayPercentage);
        resultMap.put("childrenWeekPercentage",childrenWeekPercentage);
        resultMap.put("childrenTodayTotle",childrenTodayTotle);


        return R.ok().put("resultMap",resultMap);
    }

    @Override
    public void download(HttpServletResponse response, Map map) throws Exception {

        //获取当前的deptid
        Long deptId = ShiroUtils.getUserEntity().getDeptId();

        Long userId = ShiroUtils.getUserId();

        List<WxUserManageEntity> wxUserManageEntityList = new ArrayList<>();

        if(null != map.get("memberType")){
            String memberType = map.get("memberType").toString();
            //memberType，0：全部，1：游客，2：会员，3：开卡会员
            if("0".equals(memberType)){

            }else if("1".equals(memberType)){
                map.put("isRegist","noRegist");
            }else if("2".equals(memberType)){
                map.put("isRegist","regist");
            }else if("3".equals(memberType)){
                map.put("isOpenCard","1");
            }

        }

        //前端搜索框
        if(null != map.get("deptName")){
            List<SysDeptEntity> sysDeptEntityList = sysDeptService.list(new QueryWrapper<SysDeptEntity>()
                    .like("name",map.get("deptName")));
            if(sysDeptEntityList.size() > 0){
                List<Long> deptIds = new ArrayList<>();
                for(SysDeptEntity sysDeptEntity:sysDeptEntityList){
                    deptIds.add(sysDeptEntity.getDeptId());
                }
                map.put("deptIds",deptIds);
            }
            /*
             * 如果通过前端搜索框搜索的不为空，则进一步加载拥有权限的部门id，否则就不加载拥有权限的部门，使前端搜索结果为空
             * */
            if(null != map.get("deptIds")){
                //查询拥有的部门id
                //部门ID列表
                Set<Long> deptIdList = new HashSet<>();
                //添加上自己的部门id
                deptIdList.add(deptId);

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

                wxUserManageEntityList = wxUserManageDao.queryWxUserListPage(map);
            }else {
                /*
                 * 如果通过前端搜索框搜索的部门id为空，说明该部门不存在，进一步说明会员信息应该查询为空。这里就直接返回空信息了
                 * */
                wxUserManageEntityList.add(new WxUserManageEntity());
            }

        }else {

            //查询拥有的部门id
            //部门ID列表
            Set<Long> deptIdList = new HashSet<>();
            //添加上自己的部门id
            deptIdList.add(deptId);

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
            //开始查询
            wxUserManageEntityList = wxUserManageDao.queryWxUserListPage(map);
        }


        /*
        * 处理一下数据形式
        * */
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:ss:mm");
        for(WxUserManageEntity wxUserManageEntity:wxUserManageEntityList){
            if(null != wxUserManageEntity.getCreateDate()){
                wxUserManageEntity.setCreateTimeStr(sdf.format(wxUserManageEntity.getCreateDate()));
            }
        }


        //总共的登录数(包含手机授权和注册的)
        Integer wxLoginTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .apply(true, getSql(deptId,true,"",true,userId)));

        //总共的手机授权数
        Integer wxPhoneTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .isNotNull("phone")
                .apply(true, getSql(deptId,true,"",true,userId)));

        //总共的注册数
        Integer wxRegistTotle = wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .isNotNull("phone")
                .eq("is_regist",1)
                .apply(true, getSql(deptId,true,"",true,userId)));

        List otherData = new ArrayList();
        otherData.add("扫码数量");
        otherData.add(wxLoginTotle);
        otherData.add("微信手机号授权数量");
        otherData.add(wxPhoneTotle);
        otherData.add("完成注册数量");
        otherData.add(wxRegistTotle);

        //开始下载
        Properties pro = System.getProperties();
        String excelName = new String ("会员数据表".getBytes(),pro.getProperty("file.encoding"));

        String fileName = "会员数据"+(System.currentTimeMillis())+".xls";

        response.addHeader("Content-Disposition", "attachment;filename="  + new String(fileName.getBytes("GB2312"), "ISO_8859_1")     );
        //response.setContentType("application/vnd.ms-excel;charset=utf-8");
        OutputStream out = null;
        try {
            out = response.getOutputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Map<String,String> fields = new LinkedMap<String,String>();
        fields.put("openId","会员openId");
        fields.put("name","姓名");
        fields.put("registPhone","用户注册手机号");
        fields.put("phone","微信绑定手机号");
        fields.put("deptCode","推广码");
        fields.put("idCard","身份证号码");
        fields.put("useRegion","使用地区");
        fields.put("invoiceType", "发票类型");
        fields.put("deptName","拉新部门名称");
        fields.put("nickName","会员昵称");
        fields.put("createTimeStr","注册时间");


        try {
            ExcelUtil.listToExcel(wxUserManageEntityList, out, fields,excelName,otherData);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }
    }

    @Override
    public void downloadForForm(HttpServletResponse response, Map map) throws Exception {
        //开始查询
        //获取当前的deptid
        Long deptId = ShiroUtils.getUserEntity().getDeptId();

        Long userId = ShiroUtils.getUserId();

        List<WxUserManageEntity> wxUserManageEntityList = new ArrayList<>();

        if(null != map.get("memberType")){
            String memberType = map.get("memberType").toString();
            //memberType，0：全部，1：游客，2：会员，3：开卡会员
            if("0".equals(memberType)){

            }else if("1".equals(memberType)){
                map.put("isRegist","noRegist");
            }else if("2".equals(memberType)){
                map.put("isRegist","regist");
            }else if("3".equals(memberType)){
                map.put("isOpenCard","1");
            }

        }

        //前端搜索框
        if(null != map.get("deptName")){
            List<SysDeptEntity> sysDeptEntityList = sysDeptService.list(new QueryWrapper<SysDeptEntity>()
                    .like("name",map.get("deptName")));
            if(sysDeptEntityList.size() > 0){
                List<Long> deptIds = new ArrayList<>();
                for(SysDeptEntity sysDeptEntity:sysDeptEntityList){
                    deptIds.add(sysDeptEntity.getDeptId());
                }
                map.put("deptIds",deptIds);
            }
            /*
             * 如果通过前端搜索框搜索的不为空，则进一步加载拥有权限的部门id，否则就不加载拥有权限的部门，使前端搜索结果为空
             * */
            if(null != map.get("deptIds")){
                //查询拥有的部门id
                //部门ID列表
                Set<Long> deptIdList = new HashSet<>();
                //添加上自己的部门id
                deptIdList.add(deptId);

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

                wxUserManageEntityList = wxUserManageDao.queryWxUserListPage(map);
            }else {
                /*
                 * 如果通过前端搜索框搜索的部门id为空，说明该部门不存在，进一步说明会员信息应该查询为空。这里就直接返回空信息了
                 * */
                wxUserManageEntityList.add(new WxUserManageEntity());
            }

        }else {

            //查询拥有的部门id
            //部门ID列表
            Set<Long> deptIdList = new HashSet<>();
            //添加上自己的部门id
            deptIdList.add(deptId);

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
            //开始查询
            wxUserManageEntityList = wxUserManageDao.queryWxUserListPage(map);
        }

        List<ProfilesEntity> profilesEntityList = new ArrayList<>();
        List<AutofillRulesEntity> autofillRulesEntityList = new ArrayList<>();
        for(int i = 0 ; i < wxUserManageEntityList.size();i++){
            ProfilesEntity profilesEntity = new ProfilesEntity();
            profilesEntity.setProfileID("c"+(i+1));
            profilesEntity.setName(wxUserManageEntityList.get(i).getName());
            profilesEntity.setOverwrite("1");
            profilesEntityList.add(profilesEntity);

            AutofillRulesEntity autofillRulesEntity1 = new AutofillRulesEntity();
            autofillRulesEntity1.setType("0");
            autofillRulesEntity1.setName("^name$");
            autofillRulesEntity1.setValue(wxUserManageEntityList.get(i).getName());
            autofillRulesEntity1.setSite("reg.mail.163.com");
            autofillRulesEntity1.setProfile("c"+(i+1));
            autofillRulesEntityList.add(autofillRulesEntity1);

            AutofillRulesEntity autofillRulesEntity2 = new AutofillRulesEntity();
            autofillRulesEntity2.setType("0");
            autofillRulesEntity2.setName("^idCard$");
            autofillRulesEntity2.setValue(wxUserManageEntityList.get(i).getIdCard());
            autofillRulesEntity2.setSite("reg.mail.163.com");
            autofillRulesEntity2.setProfile("c"+(i+1));
            autofillRulesEntityList.add(autofillRulesEntity2);

        }




        //开始下载
        Properties pro = System.getProperties();
        String excelName1 = new String ("### PROFILES ###");
        String excelName2 = new String("### AUTOFILL RULES ###");

        String fileName = "会员数据"+(System.currentTimeMillis())+".xls";

        response.addHeader("Content-Disposition", "attachment;filename="  + new String(fileName.getBytes("GB2312"), "ISO_8859_1")     );
        //response.setContentType("application/vnd.ms-excel;charset=utf-8");
        OutputStream out = null;
        try {
            out = response.getOutputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Map<String,String> fields1 = new LinkedMap<String,String>();
        fields1.put("ProfileID","ProfileID");
        fields1.put("Name","Name");
        fields1.put("Site","Site");
        fields1.put("Overwrite","Overwrite");

        Map<String,String> fields2 = new LinkedMap<String,String>();
        fields2.put("Type","Type");
        fields2.put("Name","Name");
        fields2.put("Value","Value");
        fields2.put("Site","Site");
        fields2.put("Profile","Profile");


        try {
            ExcelForFormUtil.listToExcel(profilesEntityList,autofillRulesEntityList, out, fields1,fields2,excelName1,excelName2);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }
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
