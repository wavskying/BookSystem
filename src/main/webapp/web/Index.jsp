<%--
  Created by IntelliJ IDEA.
  User: 胡博文
  Date: 2021/10/18
  Time: 21:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>图书管理系统</title>
    <link rel="stylesheet" type="text/css" href="../layui/css/layui.css">

    <style type="text/css">
        .nm {
            float: left;
            margin-right: 10px;
        }
        .ignm {
            width: 50px;
            min-width: 170px;
            max-width: 50px;
            margin-left: 100px;
        }

        .layui-input, .layui-select, .layui-textarea {
            height: 33px;
            line-height: 20;
            line-height: 38px\9;
            border-width: 1px;
            border-style: solid;
            background-color: #fff;
            color: rgba(0,0,0,.85);
            border-radius: 2px;
        }

    </style>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">图   书</div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <!-- 移动端显示 -->
            <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                <i class="layui-icon layui-icon-spread-left"></i>
            </li>

            <div class="demoTable" style="text-align:center;margin-top: 10px;">
                <label id="selectLabelOne">搜索书名：</label>
                <div class="layui-inline">
                    <input class="layui-input" name="keyword" autocomplete="off" id="selectOne">
                </div>
                <label id="selectLabelTwo">搜索价格：</label>
                <div class="layui-inline" >
                    <input class="layui-input" name="keyword2" autocomplete="off" id="selectTwo">
                </div>
                <button class="layui-btn" data-type="reload" onclick="doSelect()" id="allSelect" name="../web/Book.jsp">搜索</button>
            </div>

        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-md-inline-block ignm" >
                <a href="javascript:; " >
                    <a id="nameImage" class="nm" position="left"></a>
                    <img src="//tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" class="ig layui-nav-img">
                </a>
                <dl class="layui-nav-child">
                    <dd><a id="updateUser" href="javascript:; ">个人信息</a></dd>
                    <dd><a onclick="loginOut()">退出登录</a></dd>
                    <dd><a href="">Sign out</a></dd>
                </dl>
            </li>
        </ul>
    </div>


    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航）layui-nav-itemed -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">
                <li class="layui-nav-item"><a href="">首  页</a></li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">分  类</a>
                    <dl class="layui-nav-child" id="mulu">
                        <dd><a  onclick="getId(this)" id="0">查看全部</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a id="zuozhe" onclick="getId2(this)">作  者</a></li>
                <li class="layui-nav-item"><a id="yonghu" onclick="getId3(this)">用  户</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body" style="padding-bottom: 0px;">
        <!-- 内容主体区域 -->
        <iframe id="center_table" src="" width="100%" height="100%" scrolling="no" >

        </iframe>
    </div>

</div>
<script src="../layui/layui.js"></script>


<script>
    layui.$.ajax({
        url:"/book/selectType",
        type:"Post",
        success:function (data) {
            for (i = 0;i<data.length;i++){
                var type = data[i].sort
                var tid = data[i].id
                var html = '<dd><a href="javascript:;" id="'+tid+'" onclick="getId(this)">'+type+'</a></dd>'
                layui.$('#mulu').append(html)
            }
        }
    })

    // 左侧分类目录的点击事件，点击时修改iframe的src同时传入类型id
    var typeId = 0;
    var selectOne = '';
    var selectTwo = 0;

    // 跳转图书页面
    function getId(obj){
        layui.$("#selectLabelOne").text('搜索书名')
        layui.$("#selectLabelTwo").text('搜索价格')
        document.getElementById("allSelect").name = '../web/Book.jsp'

        typeId = obj.id
        selectTwo = 0
        selectOne = ''
        document.getElementById("center_table").src="../web/Book.jsp?id="+obj.id+"&selectOne="+selectOne+"&selectTwo="+selectTwo+"&power="+args["power"]
    }

    // 跳转作者管理界面
    function getId2(obj) {
        layui.$("#selectLabelOne").text('搜索人名')
        layui.$("#selectLabelTwo").text('搜索id')
        document.getElementById("allSelect").name = '../web/Author.jsp'
        selectOne = ''
        selectTwo = ''
        document.getElementById("center_table").src="../web/Author.jsp?id="+obj.id+"&selectOne="+selectOne+"&selectTwo="+selectTwo+"&power="+args["power"]
    }

    // 跳转用户管理页面
    function getId3(obj) {
        if (args["power"] == "管理员用户"){
            layui.$("#selectLabelOne").text('搜索名字')
            layui.$("#selectLabelTwo").text('搜索id')
            document.getElementById("allSelect").name = '../web/Author.jsp'
            selectOne = ''
            selectTwo = ''
            document.getElementById("center_table").src="../web/User.jsp?id="+obj.id+"&selectOne="+selectOne+"&selectTwo="+selectTwo
        }else {
            layer.open({
                title: '警告'
                ,content: '您没有权限进行此操作'
            });
        }

    }

    function loginOut() {
        layui.$.ajax({
            type:'post',
            url:'/user/outLogin',
            success(data){
                window.location.href = '../web/Login.jsp'
            }

        })
    }

    // 搜索点击事件
    function doSelect(obj){
        selectOne = layui.$('#selectOne').val();
        selectTwo = layui.$('#selectTwo').val();

        var url = document.getElementById("allSelect").name


        console.log(selectOne)
        if (selectOne ==''){
            selectOne = ''
        }
        if (selectTwo ==''){
            selectTwo = 0
        }
        console.log(selectOne)
        console.log(selectTwo)
        document.getElementById("center_table").src=url+"?id="+typeId+"&selectOne="+selectOne+"&selectTwo="+selectTwo
    }

    //JS
    layui.use(['element', 'layer', 'util','table'], function(){
        var element = layui.element
            ,layer = layui.layer
            ,util = layui.util
            ,$ = layui.$;

        //头部事件
        util.event('lay-header-event', {
            //左侧菜单事件
            menuLeft: function(othis){
                layer.msg('展开左侧菜单的操作', {icon: 0});
            }
            ,menuRight: function(){
                layer.open({
                    type: 1
                    ,content: '<div style="padding: 15px;">处理右侧面板的操作</div>'
                    ,area: ['260px', '100%']
                    ,offset: 'rt' //右上角
                    ,anim: 5
                    ,shadeClose: true
                });
            }
        });

    });
</script>

<script>
    console.log("开始")
    var args = new Object( );
    var query = location.search.substring(1);
    var pairs = query.split("&");
    for(var i = 0; i < pairs.length; i++) {
        var pos = pairs[i].indexOf('=');
        if (pos == -1) continue;
        var argname = pairs[i].substring(0,pos);
        var value = pairs[i].substring(pos+1);
        value = decodeURIComponent(value);
        args[argname] = value;
        console.log("用户权限是："+args["power"])
    }
    layui.$("#nameImage").text(args["name"]);

    // layui.$('#center_table').attr("../web/Book.jsp?identity="+args["power"])
    // layui.$('#center_table').src = "../web/Book.jsp?identity="+args["identity"]
    // document.getElementById("center_table").src = "../web/Book.jsp?power="+args["power"]
    document.getElementById("center_table").src = "../web/First.jsp?power="+args["power"]+"&name="+args["name"]
    // alert(args["name"])
    layer.load();
    console.log("结束")
</script>
</body>
</html>
