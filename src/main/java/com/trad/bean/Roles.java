package com.trad.bean;

import java.util.Date;
import java.util.List;

public class Roles {
    private Integer roleId;

    private String roleName;

    private String roleDesc;

    private Date createTime;

    private Date updateTime;
    
    private List<UserRoles> userRoles;
    
    private List<RolePermission> rolePers;
    
    private String userNames;
    
    private String treeNames;
    
    private String createPer;
    
    private String updatePer;
    
    private String recordStatus="1";
    
    public String getRecordStatus() {
		return recordStatus;
	}

	public void setRecordStatus(String recordStatus) {
		this.recordStatus = recordStatus;
	}
    
    public String getCreatePer() {
        return createPer;
    }

    public void setCreatePer(String createPer) {
        this.createPer = createPer == null ? null : createPer.trim();
    }
	
	public String getUpdatePer() {
        return updatePer;
    }

    public void setUpdatePer(String updatePer) {
        this.updatePer = updatePer == null ? null : updatePer.trim();
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName == null ? null : roleName.trim();
    }

    public String getRoleDesc() {
        return roleDesc;
    }

    public void setRoleDesc(String roleDesc) {
        this.roleDesc = roleDesc == null ? null : roleDesc.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

	public List<RolePermission> getRolePers() {
		return rolePers;
	}

	public void setRolePers(List<RolePermission> rolePers) {
		this.rolePers = rolePers;
	}

	public List<UserRoles> getUserRoles() {
		return userRoles;
	}

	public void setUserRoles(List<UserRoles> userRoles) {
		this.userRoles = userRoles;
	}

	public String getUserNames() {
		return userNames;
	}

	public void setUserNames(String userNames) {
		this.userNames = userNames;
	}

	public String getTreeNames() {
		return treeNames;
	}

	public void setTreeNames(String treeNames) {
		this.treeNames = treeNames;
	}
	
}