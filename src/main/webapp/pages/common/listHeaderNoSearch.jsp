<%@ page pageEncoding="UTF-8" %>
<style type="text/css">
  .layui-table-cell .layui-form-checkbox[lay-skin=primary]{
        top: 5px;
    }
</style>
  <div class="layui-row">
    <div class="layui-col-xs6">
		      <div class="grid-demo grid-demo-bg1">
		      &nbsp;
               </div>
    </div>
     <div class="layui-col-xs2">
		      <div class="grid-demo grid-demo-bg1">&nbsp;</div>
		    </div>
    <div class="layui-col-xs4">
      <div class="grid-demo">
       <div class="layui-form-item">
  	 		<button class="layui-btn" id="add"><i class="layui-icon">&#xe654;</i>添加</button>
  	 		<c:if test="${requestScope.SHOW_EDIT eq true}">
			<button class="layui-btn" id="edit"><i class="layui-icon">&#xe642;</i>编辑</button>
			</c:if>
			<button class="layui-btn layui-btn-danger" id="delete"><i class="layui-icon">&#xe640;</i>删除 </button>
			<button class="layui-btn" id="refresh"><i class="layui-icon">&#x1002;</i>刷新</button>
      </div>
    </div>
  </div>
  </div>