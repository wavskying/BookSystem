<%--
  Created by IntelliJ IDEA.
  User: 胡博文
  Date: 2021/11/8
  Time: 13:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="../layui/css/layui.css">
</head>
<body>
<script src="../layui/layui.js"></script>

<script>
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
        console.log("id是"+value)
    }
    var data = {
        id:1
    }

    var index = layer.load(5, {time: 30*1000});


    layui.$.ajax({
        url:"/book/selectOneBook",
        type:"post",
        contentType:"application/json",
        data:JSON.stringify({
            id:args["id"],
        }),
        success:function (data){
            console.log("结果是"+data.name)
            layui.$("#title").text(data.name)
            layui.$("#name").text(data.name)
            layui.$("#author").text(data.authorName)
            layui.$("#price").text(data.price)
            layui.$("#publish").text(data.publish)
            layui.$("#publishDate").text(data.publishDate)
            layui.$("#contents").text(data.introduction)
            // layui.$("#image").attr(src,"data:image/png;base64,"+data.imag)
            document.getElementById("image").src = "data:image/png;base64,"+data.imag
            console.log(data.imag)
            layer.close(index)
        }
    })
</script>

<div class="layui-container">

    <h1 id="title">活着</h1>
    <div class="layui-row">
        <div class="layui-col-xs4 layui-col-sm5 layui-col-md4" style="width: 270px;height: 200px">
            <img src="" height="180px" width="150px" id="image">
        </div>
        <div class="layui-col-xs4 layui-col-sm7 layui-col-md8" style="width: 600px;height: 200px">
            <table>
                <br>
                <br>
                <tr>
                    <td>书名：</td><td id="name"></td>
                </tr>
                <tr>
                    <td>作者：</td><td id="author"></td>
                </tr>
                <tr>
                    <td>价格：</td><td id="price"></td>
                </tr>
                <tr>
                    <td>出版社：</td><td id="publish"></td>
                </tr>
                <tr>
                    <td>出版日期：</td><td id="publishDate"></td>
                </tr>
            </table>
        </div>
    </div>
    <div class="layui-col-xs4 layui-col-sm5 layui-col-md12" style="width: 870px;height: 600px">
        <fieldset class="layui-elem-field">
            <legend>作品简介</legend>
            <div class="layui-field-box" >
                <h2 id="contents"></h2>
            </div>
        </fieldset>
    </div>
</div>
</body>
</html>
