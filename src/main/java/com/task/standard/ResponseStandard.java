package com.task.standard;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.eclipse.jdt.internal.compiler.env.ICompilationUnit;

/**
 * @author: hbw
 **/
public class ResponseStandard {

    private String code;
    private String msg;
    private int count;
    private JSONArray data;

    public ResponseStandard(int status,JSONArray data,int count){
        this.data = data;
        if (status==1){
            msg = "操作成功";
            code = "0";
            this.count = count;
        }else{
            msg = "操作失败";
            code = "1";
            this.count = 0;
        }
    }

    public JSONObject getResponseBody(){
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("msg",msg);
        jsonObject.put("code",code);
        jsonObject.put("data",data);
        jsonObject.put("count",count);
        return jsonObject;
    }

}
