<%--
  Created by IntelliJ IDEA.
  User: 胡博文
  Date: 2021/11/10
  Time: 17:00
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

    function doUpdate() {
        var name = layui.$("#name").val()
        var price = layui.$("#price").val()
        var introduction = layui.$("#introduction").val()
        var id = args["id"]
        layui.$.ajax({
            type:'post',
            url:'/book/updateBook',
            contentType:'application/json',
            data:JSON.stringify(
                {
                    "id":id,
                    "name":name,
                    "price":price,
                    "introduction":introduction
                }
            ),
            success:function (data) {
                alert("111")
                layer.open({
                    title: '结果'
                    ,content: data.message
                });
            }
        })
    }

    console.log(args["name"])


</script>


<form id="form" class="layui-form" action="">
    <div class="layui-form-item">
        <label class="layui-form-label">书名</label>
        <div class="layui-input-block">
            <input value="" type="text" name="title" required  lay-verify="required" <%--autocomplete="off"--%> class="layui-input" id="name">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">价格</label>
        <div class="layui-input-block">
            <input type="text" name="title" required  lay-verify="required" autocomplete="off" class="layui-input" id="price">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">简介</label>
        <div class="layui-input-block">
            <textarea name="desc" class="layui-textarea" id="introduction"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" <%--lay-submit lay-filter="formDemo"--%> onclick="doUpdate()">立即提交</button>
        </div>
    </div>
</form>

<script>
    layui.$("#name").attr("value",args["name"])
    layui.$("#price").attr("value",args["price"])
    layui.$("#introduction").val(args["introduction"])
</script>

</body>
</html>
