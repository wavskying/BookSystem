<%--
  Created by IntelliJ IDEA.
  User: 胡博文
  Date: 2021/11/5
  Time: 20:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="../layui/css/layui.css">
    <style type="text/css">
        element.style{
            padding: 0px!important;
        }
        /*.layui-table img {
            max-width: 90px;
            !* max-height: 80px; *!
            height: 100px;
        }*/
        .layui-table-cell {
            height: 120px;
            line-height: 28px;
            padding: 0 15px;
            position: relative;
            box-sizing: border-box;
        }

        .layui-table-header {
            border-width: 0 0 1px;
            overflow: hidden;
            height: 50px;
        }

    </style>
</head>
<body>
<script src="../layui/layui.js"></script>

<%--添加图书表单--%>
<div class="site-text" style="margin: 5%; display: none" id="window"  target="test123">
    <form class="layui-form" action="/book/addBook" id="book" method="post" lay-filter="example" enctype="multipart/form-data">
        <div class="layui-form-item">
            <label class="layui-form-label">书名</label>
            <div class="layui-input-block">
                <input type="text" id="input_name" name="name" lay-verify="title" autocomplete="off" placeholder="请输入书名" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">价格</label>
            <div class="layui-input-block">
                <input type="text" id="input_price" name="price" lay-verify="title" autocomplete="off" placeholder="请输入价格" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">封面</label>
            <input  type="file" id="input_photo" name="photo" lay-verify="title" autocomplete="off"  >
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit="" lay-filter="demo1" datatype="reloadTwo">立即提交</button>
            </div>
        </div>
    </form>
</div>

<div style="padding: 0px;">
    <div style="text-align:center">
        <table id="book_table" lay-filter="test" style="margin:0;padding: 0px;" ></table>
        <script>

        </script>
    </div>
</div>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger" lay-event="more">详情</a>
    <a class="layui-btn" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger" lay-event="del">删除</a>
</script>


<script>
    let args = new Object();
    let query = location.search.substring(1);
    let pairs = query.split("&");
    let reloadType = 0;
    let reloadName = null
    let reloadPrice = 0
    for(var i = 0; i < pairs.length; i++) {
        var pos = pairs[i].indexOf('=');
        if (pos == -1) continue;
        var argname = pairs[i].substring(0,pos);
        var value = pairs[i].substring(pos+1);
        value = decodeURIComponent(value);
        args[argname] = value;
        if (value != "管理员用户" & value != "普通用户"){
            if (i == 0){
                reloadType = value
                console.log("dd"+reloadType)
            }
            if (i == 1){
                reloadName = args["selectOne"]
                console.log("dd"+reloadName)
            }
            if (i == 2){
                reloadPrice = args["selectTwo"]
                console.log("dd"+reloadPrice)
            }
        }else {
            console.log("是管理员"+args["power"])
        }

    }



    //JS
    layui.use(['element', 'layer', 'util','table'], function(){
        var element = layui.element
            ,layer = layui.layer
            ,util = layui.util
            ,$ = layui.$;

        var $ = layui.$;
        var table = layui.table;
        var id = 0;
        var name = null;
        var  price = 0;
        //第一个实例
        table.render({
            elem: '#book_table'
            ,id:'testReload'
            ,height: 620
            ,url: '/book/selectBook' //数据接口
            ,toolbar:'default'
            ,method: 'post'
            ,where:{
                "id":id,
                "name":reloadName,
                "price":parseInt(reloadPrice),
                "sort":parseInt(reloadType),
            }
            ,limit:10
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'id', title: 'ID', width:'20%', sort: true, fixed: 'left'}
                ,{field: 'photo', title: '封面', width:'15%', sort: true, fixed: 'left' ,templet: '<div><img src="data:image/png;base64,{{d.imag}}" /> </div>'}
                ,{field: 'name', title: '书名', width:'20%'}
                ,{field: 'price', title: '价格', width:'25%', sort: true}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:'20%'}
            ]]

        });

        var $ = layui.$, active = {

            // 绑定执行搜索后刷新表格，通过元素上的data-type来绑定，若datatype=reload则走这里
            reload: function(){
                var demoReload = $('#demoReload').val();
                var demoprice = $('#demoReload2').val();
                if (demoprice == ''){
                    demoprice = 0;
                }
                if (demoReload == ''){
                    demoReload = null;
                }

                table.reload('testReload', {
                    // 使用where刷新时可以向后台传递数据
                    where: {
                        id:0,
                        name: demoReload,
                        price:demoprice,
                        sort:''
                    }
                });
            },
        };

        // 为组件绑定刷新表格事件
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        $('.site-text .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        $('#literature').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        //监听头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id)
                ,data = checkStatus.data; //获取选中的数据
            switch(obj.event){
                case 'add':
                    if (args["power"] == "管理员用户"){
                        layer.open({
                            type:1,
                            area:[
                                '600','380'
                            ],
                            title:'图书增加',
                            content:$("#window")
                        })
                        //layer.msg('添加');
                        break;
                    }else {
                        layer.open({
                            title: '警告'
                            ,content: '您没有权限进行此操作'
                        });
                        break;
                    }
                case 'update':
                    if (args["power"] == "管理员用户"){
                        if(data.length === 0){
                            layer.msg('请选择一行');
                        } else if(data.length > 1){
                            layer.msg('只能同时编辑一个');
                        } else {
                            layer.alert('编辑 [id]：'+ checkStatus.data[0].id);
                        }
                        break;
                    }else {
                        layer.open({
                            title: '警告'
                            ,content: '您没有权限进行此操作'
                        });
                        break;
                    }
                case 'delete':
                    if (args["power"] == "管理员用户"){
                        if(data.length === 0){
                            layer.msg('请选择一行');
                        } else {
                            layer.msg('删除');
                        }
                        break;
                    }else {
                        layer.open({
                            title: '警告'
                            ,content: '您没有权限进行此操作'
                        });
                        break;
                    }
            };
        });
        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            console.log(obj)
            if(obj.event === 'del'){
                if (args["power"] == "管理员用户"){
                    layer.confirm('真的删除行么', function(index){
                        $.ajax({
                            url:"/book/deleteBook",
                            type:"Post",
                            data:{
                                'id':obj.data.id
                            },
                            success:function (data) {
                                if (data==1){
                                    alert("删除成功");
                                }else {
                                    "删除失败";
                                }
                            }
                        })
                        obj.del();
                        layer.close(index);
                    });
                }else {
                    layer.open({
                        title: '警告'
                        ,content: '您没有权限进行此操作'
                    });
                }
            } else if(obj.event === 'edit'){
                if (args["power"] == "管理员用户"){

                    layer.open({
                        title:'修改图书信息'
                        ,type:2
                        ,content: "../web/updateBook.jsp?name="+data.name+"&price="+data.price+"&introduction="+data.introduction+"&id="+data.id
                        ,area: ['1000px', '400px']
                    }, function(value, index){
                        obj.update({
                            email: value
                        });
                        layer.close(index);
                        parent.location.reload();
                    });
                }else {
                    layer.open({
                        title: '警告'
                        ,content: '您没有权限进行此操作'
                    });
                }
            }else if (obj.event === 'more'){
                layer.open({
                    title:'详细信息'
                    ,type:2
                    ,content: "../web/BookOpen.jsp?id="+data.id
                    ,area: ['1000px', '650px']
                });
            }
        });
    });

</script>

</body>
</html>
