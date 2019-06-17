package com.syx.controller;

import com.syx.service.UserService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Scope("prototype")
@RequestMapping("/user")

public class UserController {

    @Resource
    UserService userService;

    @RequestMapping("/show.do")
    @ResponseBody
    public List showTest() {

        System.out.println("showTest() success!");
        List list = new ArrayList();
        list.add("zhangsan");
        list.add("1");
        list.add("2");
        list.add("3");

        return list;
        /*    return "../index.jsp";*/
    }

    @RequestMapping("/register.do")
    @ResponseBody
    public String register(String uname2, String upwd2) {


        int flag = userService.register(uname2, upwd2);


        if (flag == 1) {
            return "success";
        } else {
            return "fails";
        }

    }

    @RequestMapping("/deleteById.do")
    @ResponseBody
    public String deleteUserById(String id) {
          String [] arr = id.split(",");
          int flag=0;
for (String str:arr){
     flag = userService.deleteUserById(str);
}



        if (flag == 1) {
            return "success";
        } else {
            return "fails";
        }

    }

    @RequestMapping("/insertUser.do")
    @ResponseBody
    public String insertUser(String uname, String upwd, String runame, String address,String role) {

        Map map = new HashMap();
        map.put("uname", uname);
        map.put("upwd", upwd);
        map.put("address", address);
        map.put("runame", runame);
        map.put("role", role);

        int flag = userService.insertUser(map);
        System.out.println("insertUser  success!" );

        if (flag == 1) {
            return "success";
        } else {
            return "fails";
        }

    }


    @RequestMapping(value = "/login.do", method = RequestMethod.POST)
    @ResponseBody
    public String login(@RequestParam("uname") String uname, String upwd) {

        List<Map<String, Object>> list = userService.login(uname, upwd);
        if (list.size() > 0)
            return "success";
        else
            return "falis";

    }


    @RequestMapping(value = "/findAllUser.do")
    @ResponseBody
    public Map<String, Object> findAllUser(String uname, int page, int limit) {


        Map map = new HashMap();
        map.put("uname", uname);
        map.put("recordIndex", (page - 1) * limit);
        map.put("pagesize", limit);


        List<Map<String, Object>> list = userService.findAllUser(map);
        int count = userService.UserCount();
        map.clear();
        map.put("msg", "");
        map.put("code", 0);
        map.put("data", list);
        map.put("count", count);


        return map;


    }







    /*
     * 返回用户列表方法，因为layui需要的json数据格式，所以参照json格式返回对应的集合对象
     *
     * */

    @RequestMapping(value = "/userlist.do")
    @ResponseBody
    public Map<String, Object> UserList() {

        //先获取userlist列表对象
        List<Map<String, Object>> list = userService.UserList();
        System.out.println(list.size());
        if (list.size() > 0) {

            int count = userService.UserCount();

            Map<String, Object> map = new HashMap<>();
            map.put("msg", "");
            map.put("code", 0);
            map.put("data", list);
            map.put("count", count);
            return map;
        } else {

            return null;
        }


    }

    @RequestMapping(value = "/userGenderAnalysis.do")
    @ResponseBody
    public Map<String, Object> userGenderAnalysis() {

        //先获取userlist列表对象
        List<Map<String, Object>> list = userService.userGenderAnalysis();

        List<Object> list1=new ArrayList();
        List<Object> list2 = new ArrayList();
        for (Map map1:list){
            list1.add( map1.get("gender"));
            list2.add( map1.get("count"));
        }

       Map map=new HashMap();
       map.put("gender",list1);
       map.put("count",list2);


       return map;


    }


    @RequestMapping(value = "/manPercent.do")
    @ResponseBody
    public double manPercent() {

        //先获取userlist列表对象
        List<Map<String, Object>> list = userService.userGenderAnalysis();
        int count=0;
        int man=0;
        for (Map map1:list){
            if(map1.get("gender").toString().equals("男")){
                man=Integer.parseInt(map1.get("count").toString());
            }
            count+=Integer.parseInt(map1.get("count").toString());
        }


        return (double)man/count;


    }


}
