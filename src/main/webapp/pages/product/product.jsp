<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
     //页面标题设置
	request.setAttribute("pageTitle","菜单列表");  
	//设置查询标题
	request.setAttribute("QUERY_TILE","支持菜单名称/描述搜索内容");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	request.setAttribute("SHOW_EDIT",true);  
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<%@ include file="/pages/common/listHeader.jsp" %>
<table class="layui-table" lay-data="{height:478,url:'${ctx }/product/list', page:true, limit:10, id:'tables'}" lay-filter="tree_filter">
  <thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'id', width:80,sort: true}">产品ID</th>
      <th lay-data="{field:'name', width:200,sort: true}">产品名称</th>
      <th lay-data="{field:'payNameDec', width:100,sort: true,edit: 'text'}">还款方式</th>
      <th lay-data="{field:'payTimes', width:100, sort: true,edit: 'text'}">还款期数</th>
      <th lay-data="{field:'trad', width:100, sort: true,edit: 'text'}">利率</th>
      <th lay-data="{field:'mostmon', width:100, sort: true,edit: 'text'}">最高贷款金额</th>
      <th lay-data="{field:'updatePer', width:120, sort: true}">最后更新人</th>
      <th lay-data="{field:'updateTimeStr', width:150, sort: true}">更新时间</th>
       <th lay-data="{field:'recordStatus', width:100,templet: '#checkboxTpl', unresize: true}">是否有效</th>
    </tr>
  </thead>
</table>
 <script type="text/html" id="checkboxTpl">
  <input type="checkbox" {{ d.recordStatus == 1 ? 'checked' : '' }} name="recordStatus" lay-skin="switch" lay-filter="validFilter" lay-text="是|否">
</script>
<script>
layui.use('table', function(){
  var table = layui.table
  ,form = layui.form;
  //监听表格复选框选择
  table.on('checkbox(tree_filter)', function(obj){
  });
  
  //监听是否有效操作
  form.on('switch(validFilter)', function(obj){
    var tds = $(obj.elem).parent().parent().parent().children();
    var id = tds[1].innerText.replace(/[\r\n]/g, "");
    var dataVal = '';
   	if(this.checked){
   		dataVal = '1';
   	}else{
   	    dataVal = '0';
   	}
   	
    $.post("${ctx}/product/modify",{"proID":id,"proFiled":this.name,"proValue":dataVal},function(obj){
  		 if(obj == "200"){
  			 layer.msg("设置产品是否有效成功！");
  		 }else{
  			 layer.msg("设置产品是否有效失败！");
  		 }
    });
});
  
//监听单元格编辑
  table.on('edit(tree_filter)', function(obj){
    data = obj.data; //得到所在行所有键值
   $.post("${ctx}/product/modify",{"proID":data.id,"proFiled":obj.field,"proValue":obj.value},function(obj){
	   		 if(obj == "200"){
	   			 layer.msg("数据更新成功！");
	   		 }else{
	   			 layer.msg("数据更新失败！");
	   		 }
	     });
  });
  
  $("#refresh").on("click",function(){
	  var val = $("#filter").val();
	  //刷新表格
	  table.reload('tables', {
		  url: '${ctx }/product/list?filter='+encodeURI(encodeURI(val))
		});
	});
  
  $("#delete").on("click",function(){
		  //删除表格
		  var datas = table.checkStatus('tables').data;
	      var productId = '';
	      for(i=0;i<datas.length;i++){
	    	  productId += datas[i].id+',';
	      }
	 	 if(productId!=''){
					 layer.confirm('确认删除么？', function(index){
						 $.ajax({
	   	         	     url: "${ctx}/product/deletePros?productId="+productId, 
	   	         	     dataType: "text", 
	   	         	     success: function(data){
	   	         	    	 if(data =='200'){
	   	         	    		layer.closeAll();
	   	         	    		window.location.href ='${ctx }/product/init';
	   	         	    	 }else{
	   	         	    		 layer.msg("删除产品信息失败，请重试！");
	   	         	    	 }
	   	         	     }
	   	         	 });
					 });
	 	 }else{
	 		 layer.alert("你未选中任何行！");
	 	 }
	});
  
  $("#edit").on("click",function(){
	  //删除表格
	  var datas = table.checkStatus('tables').data;
	  if(datas.length>1){
    	  layer.alert("不支持同时编辑多行，请只选中一行！");
      }else{
    	  var ids = datas[0].id;
    	  //新增
    	  layer.open({
              type: 2 //此处以iframe举例
              ,title: '新增用户'
              ,area: ['650px', '600px']
              ,shade: 0
              ,maxmin: true
              ,offset: [
                   10
              ] 
              ,content: '${ctx}/product/editPro?productId='+ids
       });
 	 }
});
  
  $("#add").on("click",function(){
		  //新增
		  layer.open({
	          type: 2 //此处以iframe举例
	          ,title: '新增产品'
	          ,area: ['650px', '600px']
	          ,shade: 0
	          ,maxmin: true
	          ,offset: [
	               10
	          ] 
	          ,content: '${ctx}/product/add'
	          ,btn: ['保存', '关闭']
	          ,yes: function(){
	          	 var body = layer.getChildFrame('body', 0);
	          	 var name = body.find('input[name="name"]').val();
	          	 var decription = body.find('input[name="decription"]').val();
	          	 var payName = body.find('select[name="payName"]').val();
	          	 var payTimes = body.find('input[name="payTimes"]').val();
	          	 var trad = body.find('input[name="trad"]').val();
	          	var payobj = body.find('input[name="payobj"]').val();
	          	var punishtype = body.find('select[name="punishtype"]').val();
	          	var punishtrad = body.find('input[name="punishtrad"]').val();
	          	var mostmon = body.find('input[name="mostmon"]').val();
	          	 var jsonObj = {"name":name,"decription":decription,"payName":payName,"payTimes":payTimes,"trad":trad,"payobj":payobj,"punishtype":punishtype,"punishtrad":punishtrad,"mostmon":mostmon};
	          	  $.post("${ctx}/product/saveProduct",jsonObj,function(text){
	          		  if(text=='200'){
	          			layer.closeAll();
		          		  window.location.href ='${ctx }/product/init';
	          		  }else{
	          			  layer.msg("保存产品信息出错！");
	          		  }
	       	     });
	          }
	   });
	});

   $("#search").on("click",function() {
		var val = $("#filter").val();
		//刷新表格
		  table.reload('tables', {
			  //encodeURI加密
			  url: '${ctx }/product/list?filter='+encodeURI(encodeURI(val))
		  });
	 });
   
});
</script>
<%@ include file="/pages/common/footer.jsp"%>