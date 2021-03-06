<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
//页面标题设置
	request.setAttribute("pageTitle","新增产品");  
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_SKIN",false);
	//如果不需要公用的js,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_COMMON",false);
	//如果不需要公用的css,请使用下面代码 (默认是为true)
	//request.setAttribute("INCLUDE_CSS",false);
%>
<%@ include file="/pages/common/header.jsp" %>
<form class="layui-form" action="#" method="post">
	<input type="hidden" id="id" name="id" value="${payment.id }">
     <div class="layui-form-item">
          <label class="layui-form-label">还款期数：</label>
          <div class="layui-input-inline">
               ${payment.paymentNum} 期
          </div>
     </div>
     <div class="layui-form-item">
          <label class="layui-form-label">实际还款时间：</label>
          <div class="layui-input-inline">
          	   <input type="text" name="paymentTime" id="paymentTime" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
          </div>
     </div>
      <div class="layui-form-item">
          <label class="layui-form-label">本期应还（元）：</label>
          <div class="layui-input-inline">
          		${payment.paymentMoney }
          </div>
     </div>
      <div class="layui-form-item">
	    <label class="layui-form-label">实际还款金额（元）：</label>
	    <div class="layui-input-inline">
	      <input type="text" name="reallyPayment" value="${payment.reallyPayment }" id="reallyPayment"  lay-verify="required" placeholder="" autocomplete="off" class="layui-input"> (元)
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">还款状态：</label>
	    <div class="layui-input-inline">
	      <select id="paymentStatus" name="paymentStatus" autocomplete="off" class="layui-input">
				<option>请选择</option>
				<option value="1">本期已还</option>
				<option value="2">本期未还</option>
			</select>
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">过桥垫资金额：</label>
	      <div class="layui-input-inline">
	          <input type="text" name="paymentAdvance" id="paymentAdvance" value="${payment.paymentAdvance }"  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">还款方式：</label>
	    <div class="layui-input-inline">
	     	<select id="paymentWay" name="paymentWay" autocomplete="off" class="layui-input">
				<option>请选择</option>
				<option value="0">等额本息</option>
				<option value="1">先息后本</option>
			</select>
	      </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">借款利率（月）：</label>
	    <div class="layui-input-inline">
	    	${payment.loanPrecent }
	    </div>
	  </div>
	   <div class="layui-form-item">
          <label class="layui-form-label">借款期限：</label>
          <div class="layui-input-inline">
               ${payment.paymentNum }
          </div>
     </div>
     <div class="layui-form-item">
          <label class="layui-form-label">备注：</label>
          <div class="layui-input-block">
               <input type="text" name="remark" id="remark" value="${payment.remark }"  lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
          </div>
     </div>
</form>
 
<script>
	layui.use(['form','laydate'], function(){
		var form = layui.form;
		var laydate = layui.laydate;
		//日期
		laydate.render({
		  elem: '#paymentTime'
		});
	});

</script>
<%@ include file="/pages/common/footer.jsp"%>