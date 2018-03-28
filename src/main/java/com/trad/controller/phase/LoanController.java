package com.trad.controller.phase;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.trad.bean.Customer;
import com.trad.bean.Loan;
import com.trad.bean.LoanStatus;
import com.trad.bean.User;
import com.trad.bean.common.LayuiTable;
import com.trad.service.CustomerService;
import com.trad.service.LoanOfferService;
import com.trad.service.LoanService;
import com.trad.service.LoanStatusService;
import com.trad.service.ProductService;
import com.trad.util.DateUtil;
import com.trad.util.EntityToMap;
import com.trad.util.ReplyCode;
import com.trad.util.SessionHelper;

@Controller
@RequestMapping("/loan")
public class LoanController {

	@Autowired
	private LoanService loanServiceImpl;
	
	@Autowired
	private LoanStatusService loanStatusService;
	
	@Autowired
	private CustomerService customerServiceImpl;
	
	@Autowired
	private ProductService productServiceImpl;
	Logger logger = LoggerFactory.getLogger(LoanController.class);

	@RequestMapping("/init")
	public String init(HttpServletRequest request, Model model) {
		return "loan/loanList";
	}

	@RequestMapping("/getList")
	@ResponseBody
	public String getList(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "limit", defaultValue = "4") int limit, HttpServletRequest request, Model model) {
		List<Loan> list = loanServiceImpl.getLoanAll();
		int count = loanServiceImpl.getCount();
		LayuiTable returnMsg = new LayuiTable();
		returnMsg.setData(list);
		returnMsg.setCount(count);
		return JSONObject.toJSONString(returnMsg);
	}

	@RequestMapping("/delLoan")
	@ResponseBody
	public String delLoan(HttpServletRequest request, Model model) {
		String loanId = request.getParameter("loanId");
		try {
			if (!StringUtils.isEmpty(loanId)) {
				String[] idStr = loanId.split(",");
				for (String id : idStr) {
//					Integer idInt = Integer.parseInt(id);
					loanServiceImpl.deleteByPrimaryKey(id);
				}
			}
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}

	@RequestMapping("/editLoan")
	public String editPro(HttpServletRequest request, Model model) {
		try {
			String loanId = request.getParameter("loanId");
			if (!StringUtils.isEmpty(loanId)) {
//				Integer idInt = Integer.parseInt(loanId);
				Loan loan = loanServiceImpl.selectByPrimaryKey(loanId);
				model.addAttribute("loan", loan);
				model.addAttribute("type", "EDIT");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "loan/loanEdit";
	}
	
	@RequestMapping("/addLoan")
	public String addLoan(HttpServletRequest request, Model model) {
		Loan loan=new Loan();
		loan.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		model.addAttribute("loan", loan);
		model.addAttribute("type", "ADD");
		return "loan/loanEdit";
	}
	
	@RequestMapping("/getProductAll")
	@ResponseBody
	public String getProductAll(HttpServletRequest request, Model model) {
		List<Map<String, Object>> productList=productServiceImpl.getProductAll();
		return JSONObject.toJSONString(productList);
	}
	
	@RequestMapping("/getCustomerAll")
	@ResponseBody
	public String getCustomerAll(HttpServletRequest request, Model model) {
		List<Customer> customerList=customerServiceImpl.getCustomerAll();
		return JSONObject.toJSONString(customerList);
	}
	
	@RequestMapping("/loanExamine")
	public String loanExamine(HttpServletRequest request, Model model) {
		String loanId = request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		return "loan/loanExamine";
	}
	
	@RequestMapping("/toLoanCheck")
	public String toLoanCheck(HttpServletRequest request, Model model) {
		String loanId = request.getParameter("loanId");
		model.addAttribute("loanId", loanId);
		return "loan/loanCheckAll";
	}
	
	@RequestMapping("/loanCheck")
	public String loanCheck(HttpServletRequest request, Model model) {
		try {
			String loanId = request.getParameter("loanId");
			if (!StringUtils.isEmpty(loanId)) {
				Loan loan = loanServiceImpl.selectByPrimaryKey(loanId);
				model.addAttribute("loan", loan);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "loan/loanCheck";
	}
	
	@RequestMapping("/saveLoan")
	@ResponseBody
	public String saveLoan(HttpServletRequest request,Model model) {
		try {
			Loan loan=new Loan();
			
			ServletRequestDataBinder binder = new ServletRequestDataBinder(loan);
			binder.bind(request);
			
			loan.setApplyTime(DateUtil.format(new Date()));
			loan.setLoanStatus("1");
			
			LoanStatus loanStatus=new LoanStatus();
			
			User user = new SessionHelper(request).getLoginUser();
			
			loanStatus.setLoanId(loan.getId());
			loanStatus.setCreateUserId(user.getUserId());
			
			Map<String, Object> map=EntityToMap.ConvertObjToMap(loan);
			map.put("loanStatus", "1");
			
			loanServiceImpl.insert(map);
			loanStatusService.insert(loanStatus);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("/upLoan")
	@ResponseBody
	public String upLoan(HttpServletRequest request,Model model) {
		try {
			Loan loan=new Loan();
			
			ServletRequestDataBinder binder = new ServletRequestDataBinder(loan);
			binder.bind(request);
			
			LoanStatus loanStatus=new LoanStatus();
			
			User user = new SessionHelper(request).getLoginUser();
			
			loanStatus.setLoanId(loan.getId());
			loanStatus.setLoanStatus(1);
			loanStatus.setCreateUserId(user.getUserId());
			
			Map<String, Object> map=EntityToMap.ConvertObjToMap(loan);
			map.put("loanStatus", "1");
			
			loanServiceImpl.updateByPrimaryKeySelective(map);
			loanStatusService.insert(loanStatus);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			return ReplyCode.INSIDEERROR;
		}
	}
	
	@RequestMapping("/upLoanStatus")
	@ResponseBody
	public String upLoanStatus(HttpServletRequest request,Model model) {
		try {
			String loanId=request.getParameter("loanId");
			Map<String, Object> map=new HashMap<>();
			map.put("loanId", loanId);
			map.put("loanStatus", 2);
			
			User user = new SessionHelper(request).getLoginUser();
			LoanStatus loanStatus=new LoanStatus();
			loanStatus.setLoanId(loanId);
			loanStatus.setLoanStatus(2);
			loanStatus.setCreateUserId(user.getUserId());
			
			loanStatusService.insert(loanStatus);
			loanServiceImpl.upLoanStatus(map);
			return ReplyCode.SUCCESS;
		} catch (Exception e) {
			return ReplyCode.INSIDEERROR;
		}
	}
	
}
