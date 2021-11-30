<%--
  Created by IntelliJ IDEA.
  User: 胡博文
  Date: 2021/11/8
  Time: 21:09
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
    }

    var index = layer.load(4, {time: 30*1000});

    layui.$.ajax({
        url:"/author/selectOneAuthor",
        type:"post",
        contentType:"application/json",
        data:JSON.stringify({
            name:args["name"],
        }),
        success:function (data){
            layui.$("#title").text(data.name)
            layui.$("#name").text(data.name)
            layui.$("#contents").text(data.introduction)
            // layui.$("#image").attr(src,"data:image/png;base64,"+data.imag)
            document.getElementById("image").src = "data:image/png;base64,"+data.photo
            console.log(data.bookList.length)
            for (i = 0;i <data.bookList.length;i++ ){

                layui.$("#images").append("<div class=\"layui-col-sm3\">\n" +
                    "                <div class=\"grid-demo grid-demo-bg1\" style=\"text-align: center;font-size: 20px\"><img src=\"data:image/png;base64,"+data.bookList[i].photo+"\" height=\"200px\" width=\"150px\"><br>"+data.bookList[i].name+"</div>\n" +
                    "            </div>")
            }
            layui.$("#images").append('<br>\n' +
                '            <br>\n' +
                '            <br>')
            layer.close(index);

        }
    })
</script>

<div class="layui-container" style="height: auto">

    <h1 id="title"></h1>
    <div class="layui-row" style="height: auto">
        <div class="layui-col-xs4 layui-col-sm5 layui-col-md4" style="width: 270px;">
            <img src="" height="180px" width="150px" id="image">
        </div>
        <div class="layui-col-xs4 layui-col-sm7 layui-col-md8" style="width: 600px;">
            <table>
                <br>
                <br>
                <tr>
                    <td>姓名：</td><td id="name"></td>
                </tr>
                <tr>
                    <td>性别：</td><td id="sex"></td>
                </tr>
                <tr>
                    <td>年龄：</td><td id="age"></td>
                </tr>
                <tr>
                    <td>出生地：</td><td id="birthArea"></td>
                </tr>
                <tr>
                    <td>出生日期：</td><td id="birthday"></td>
                </tr>
            </table>
        </div>
    </div>
    <br>
    <div class="layui-col-xs4 layui-col-sm5 layui-col-md12" style="width: 870px; height: auto">
        <fieldset class="layui-elem-field" style="height: auto">
            <legend>作者简介</legend>
            <div class="layui-field-box"  style="height: auto ">
                <h2 id="contents" style="height: auto"></h2>
            </div>
        </fieldset>
    </div>
    <br>
    <div class="layui-fluid">
        <fieldset class="layui-elem-field layui-field-title">
            <legend>代表作品</legend>
        </fieldset>
        <div class="layui-row" id="images">

        </div>
    </div>
</div>
</body>
</html>
