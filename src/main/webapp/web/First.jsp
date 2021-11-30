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
    <style>
        /*@media screen and (min-width: 1200px)*/
            .layui-container {
                width: 1400px;
            }
    </style>
    <script src="../js/echarts.js"></script>
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


</script>

<div class="layui-container" style="height: auto;padding: 0">

    <h1 id="title"></h1>
    <div class="layui-row">
        <div class="layui-col-xs6 layui-col-md12" style="width: 1800px">
            <div class="grid-demo grid-demo-bg2" style="background-color: #2F3B53"><p style="font-size: 60px;color: #B4B8C0" id="slogan"></p></div>
        </div>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <div class="layui-col-xs4 layui-col-sm7 layui-col-md8" style="width: 800px;">
            <div id="main" style="width: 800px;height:500px;"></div>
        </div>
        <div class="layui-col-xs4 layui-col-sm5 layui-col-md4" style="width: 450px;">
            <div id="main2" style="width: 550px;height:500px;"></div>
        </div>

    </div>
    <br>
</div>

<script>
    layui.$("#slogan").text("欢迎"+args['name']+"登陆图书管理系统")

</script>

<script type="text/javascript">

    var data1
    var data2
    // var index = layer.load(2, {time: 30*1000});
    layui.$.ajax({
        url:'/book/getChart',
        type:'post',
        contentType:"application/json",
        async:false,//同步
        success:function (data) {
            console.log(data.xAxisData[1])
            data1 = data.xAxisData
            data2 = data.data
            parent.layer.closeAll();
        }
    })
    // layer.close(index);

    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    var option = {
        title: {
            text: '图书分类数量'
        },
        tooltip: {},
        legend: {
            data: ['数量']
        },
        xAxis: {
            data: data1
        },
        yAxis: {},
        series: [
            {
                name: '数量',
                type: 'bar',
                data: data2
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>

<script>

    /*var dataList
    layui.$.ajax({
        url:'/book/getChart2',
        type:'post',
        contentType:"application/json",
        async:false,//同步
        success:function (data) {
            dataList = data
            console.log(data)
        }
    })*/

    var chartDom = document.getElementById('main2');
    var myChart2 = echarts.init(chartDom);
    var option2;

    option2 = {
        title: {
            text: '五大主要出版社',
            subtext: '少于180本未被列出',
            left: 'center'
        },
        tooltip: {
            trigger: 'item'
        },
        legend: {
            orient: 'vertical',
            left: 'left'
        },
        series: [
            {
                name: 'Access From',
                type: 'pie',
                radius: '50%',
                data: [
                    {name: ' 上海译文出版社 ', value: 457},
                    {name: ' 人民文学出版社 ', value: 347},
                    {name: ' 南海出版公司 ', value: 297},
                    {name: ' 广西师范大学出版社 ', value: 200},
                    {name: ' 译林出版社 ', value: 188}
                ],
                emphasis: {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    option2 && myChart2.setOption(option2);
</script>

</body>
</html>
