package cntr;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import dao.CustomerDao;
import dto.Customer;
import dto.CustomerBill;
import dto.CustomerCar;
import dto.ServiceCenter;
import dto.WaitlistedServiceCenter;

@Controller
@SessionAttributes({"customerCar", "serviceType"})
public class UserController {
	@Autowired
	private CustomerDao customerDao;
	
	String referrer, referrer2;
	
	@RequestMapping(value="/home.htm")
	public String selectCarModel(ModelMap model, HttpServletRequest request, HttpSession session) {	
		if(session.getAttribute("admin")!=null) {
			model.put("revenue", customerDao.showServiceCenterRevenue());
			model.put("dao", customerDao);
		} 
		model.put("customerCar", new CustomerCar());
		return "index";
	}
	
	@RequestMapping(value="/login.htm")
	public String prepareLoginForm(ModelMap model, HttpServletRequest request) {
		model.put("customer", new Customer());
		model.put("serviceCenter", new ServiceCenter());
		referrer = request.getHeader("referer");
		return "login-form";
	}
	
	@RequestMapping(value="/login-check.htm")
	public String login(Customer customer, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session, RedirectAttributes redirectAttributes) {
		if(customer.getCustomerName().equals("admin") && customer.getPassword().equals("carkey91")) {	
			session = request.getSession();
			session.setAttribute("admin", customer);
			try {
				response.sendRedirect(request.getContextPath() + "/home.htm");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {		
			List<Customer> list = customerDao.login(customer);
			if(list.isEmpty()) {
				model.put("customer", new Customer());
				model.put("serviceCenter", new ServiceCenter());
				//return "login-form";
				redirectAttributes.addFlashAttribute("login-status", "Invalid username/password");
				return "redirect:/login.htm";
			} else {
				session = request.getSession();
				session.setAttribute("customer", customer);
				
				String checkUrl = request.getScheme() + "://" + request.getHeader("host") + request.getContextPath() + "/book-service.htm";
				if(referrer2!=null && referrer2.equals(checkUrl)) {
					try {
						response.sendRedirect(referrer2);
					} catch (IOException e) {
						e.printStackTrace();
					}
				} else if(referrer!=null && referrer.equals(checkUrl)) {
					try {
						response.sendRedirect(referrer);
					} catch (IOException e) {
						e.printStackTrace();
					}		
				} else {
					try {
						response.sendRedirect(request.getContextPath() + "/home.htm");
					} catch (IOException e) {
						e.printStackTrace();
					}		
				}
			}
		}		
		return null;
	}
	
	@RequestMapping(value="/center-login-check.htm")
	public String serviceCenterLogin(ServiceCenter serviceCenter, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session, RedirectAttributes redirectAttributes) {
		List<ServiceCenter> list = customerDao.loginServiceCenter(serviceCenter);
		if(list.isEmpty()) {
			model.put("customer", new Customer());
			model.put("serviceCenter", new ServiceCenter());
			redirectAttributes.addFlashAttribute("login-status", "Invalid username/password");
			return "redirect:/login.htm";
			//return "login-form";
		} else {
			session = request.getSession();
			session.setAttribute("serviceCenter", serviceCenter);		
			try {
				response.sendRedirect(request.getContextPath() + "/home.htm");
			} catch (IOException e) {
				e.printStackTrace();
			}		
			return null;
		}
	}
	
	
	@RequestMapping(value="/signout.htm")
	public void signout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		session = request.getSession();
		session.invalidate(); 
		request.getSession(true);
		try {
			response.sendRedirect(request.getContextPath() + "/home.htm");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}		
	
	@RequestMapping(value="/registration.htm")
	public String prepareRegistrationForm(ModelMap model, HttpServletRequest request, @ModelAttribute("register-status") String status) {
		model.put("customer", new Customer());
		model.put("serviceCenter", new WaitlistedServiceCenter());
		if(status != null) {
			model.put("register-status", status);
		}
		String checkUrl = request.getScheme() + "://" + request.getHeader("host") + request.getContextPath() + "/book-service.htm";
		if(referrer.equals(checkUrl)) {
			referrer2 = referrer;
		} else {
			referrer2 = null;
		}
		return "registration-form";
	}
	
	@RequestMapping(value="/performRegistration.htm")
	public String performRegistration(Customer customer, RedirectAttributes redirectAttributes) {
		customerDao.createUser(customer);
		redirectAttributes.addFlashAttribute("register-status", "Your registration was successful!");
		return "redirect:/registration.htm";
	}
	
	@RequestMapping(value="/performServiceCenterRegistration.htm")
	public String performServiceCenterRegistration(WaitlistedServiceCenter serviceCenter, RedirectAttributes redirectAttributes) {
		customerDao.createServiceCenter(serviceCenter);
		redirectAttributes.addFlashAttribute("register-status", "Your registration was successful!");
		return "redirect:/registration.htm";
	}
	
	@ExceptionHandler(DataIntegrityViolationException.class)
	public String handleIntegrityViolation(RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("register-status", "This mobile no is already registered!");
	    return "redirect:/registration.htm";
	}
	
	
	@RequestMapping(value="/select-service.htm")
	public String selectService(CustomerCar customerCar) {
		return "select-service";
	}
	
	@RequestMapping(value="/servicing.htm")
	public void selectServicing(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		model.put("serviceType", "servicing");
		try {
			response.sendRedirect(request.getContextPath() + "/book-service.htm");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/repairing.htm")
	public void selectRepairing(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		model.put("serviceType", "repairing");
		try {
			response.sendRedirect(request.getContextPath() + "/book-service.htm");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/denting.htm")
	public void selectDenting(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		model.put("serviceType", "denting");
		try {
			response.sendRedirect(request.getContextPath() + "/book-service.htm");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/emergency.htm")
	public void selectEmergency(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		model.put("serviceType", "emergency");
		try {
			response.sendRedirect(request.getContextPath() + "/book-service.htm");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/book-service.htm")
	public String bookService(ModelMap model) {
		model.put("customerBill", new CustomerBill());
		return "book-service";
	}
	
	@RequestMapping(value="/checkout-login.htm", method = RequestMethod.POST)
	public void showServiceCenter(CustomerBill bill, HttpServletRequest request, HttpServletResponse response, HttpSession session) {								
		session = request.getSession();
		List<String> serviceNameList = bill.getServiceName();
		List<String> servicePriceList = bill.getServicePrice();
		
		if(serviceNameList.size()>0 && servicePriceList.size()>0) {
			serviceNameList.remove(0);			
			servicePriceList.remove(0);		
			session.setAttribute("customerBill", bill);
		}	
		
		if(session.getAttribute("customer") == null) {
			try {
				response.sendRedirect(request.getContextPath() + "/login.htm");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			try {
				response.sendRedirect(request.getContextPath() + "/pick-service-center.htm");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}		
	}
	
	@RequestMapping(value="/pick-service-center.htm")
	public String selectServiceCenter(ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		if(session.getAttribute("customer") != null) {
			Customer customer = (Customer) session.getAttribute("customer");
			List<ServiceCenter> serviceCenters = customerDao.showServiceCenterByZip(customer);
			if(!(serviceCenters.isEmpty())) {
				model.put("serviceCenters", serviceCenters);
			}						
			model.put("serviceCenterPicked", new ServiceCenter());
			return "pick-service-center";
		} else {
			try {
				response.sendRedirect(request.getContextPath() + "/home.htm");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@RequestMapping(value="/service-center-by-zip-table.htm")
	public String getServiceCenterByAltZipcode(HttpSession session, HttpServletRequest request, ModelMap model) {
		Integer zip = Integer.parseInt(request.getParameter("alt-zip-code"));
		List<ServiceCenter> serviceCenters = customerDao.showServiceCenterByAltZip(zip);
		if(!(serviceCenters.isEmpty())) {
			model.put("serviceCenters", serviceCenters);
		}
		model.put("serviceCenterPicked", new ServiceCenter());
		return "pick-service-center";
	}
	
	@RequestMapping(value="/confirm-order.htm")
	public String confirmOrder(ServiceCenter serviceCenter, HttpSession session, HttpServletRequest request, HttpServletResponse response) {		
		if(session.getAttribute("customer") != null) {
			CustomerBill customerBill = (CustomerBill)session.getAttribute("customerBill");
			
			Long serviceCenterMobileNo = serviceCenter.getMobileNo();
			List<ServiceCenter> serviceCenters = customerDao.showServiceCenterByMobileNo(serviceCenterMobileNo);
			ServiceCenter sc = serviceCenters.get(0);
			
			String customerName = ((Customer)session.getAttribute("customer")).getCustomerName();
			List<Customer> customers = customerDao.showCustomerByName(customerName);
			Customer c = customers.get(0);
				
			customerBill.setCustomer(c);	
			customerBill.setServiceCenter(sc);	
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy h:mm a");  
			LocalDateTime now = LocalDateTime.now(); 
			customerBill.setDate(dtf.format(now).toString());
			
			session.setAttribute("customerBill", customerBill);
			customerDao.createBill(customerBill);
			return "confirm-order";
		} else {
			try {
				response.sendRedirect(request.getContextPath() + "/home.htm");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@RequestMapping(value="/account.htm")
	public String getCustomerOrders(ModelMap model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		if(session.getAttribute("customer")!=null) {
			String customerName = ((Customer) session.getAttribute("customer")).getCustomerName();
			List<Customer> customers = customerDao.showCustomerByName(customerName);
			Customer c = customers.get(0);
			Long mobileNo = c.getMobileNo();
			
			List<CustomerBill> customerOrders = customerDao.getCustomerOrders(mobileNo);
			model.put("customerOrders", customerOrders);
			
			List<CustomerBill> customerOrderHistory = customerDao.getCustomerOrderHistory(mobileNo);
			model.put("customerOrderHistory", customerOrderHistory);
			
			return "account-customer";
		} 
		else if(session.getAttribute("serviceCenter")!=null) {
			String serviceCenterName = ((ServiceCenter) session.getAttribute("serviceCenter")).getServiceCenterName();
			List<ServiceCenter> serviceCenters = customerDao.showServiceCenterByName(serviceCenterName);
			ServiceCenter s = serviceCenters.get(0);
			Long mobileNo = s.getMobileNo();
			
			List<CustomerBill> serviceCenterOrders = customerDao.getServiceCenterOrders(mobileNo);
			model.put("serviceCenterOrders", serviceCenterOrders);
			
			List<CustomerBill> serviceCenterOrderHistory = customerDao.getServiceCenterOrderHistory(mobileNo);
			model.put("serviceCenterOrderHistory", serviceCenterOrderHistory);
			
			return "account-service-center";
		} else {
			try {
				response.sendRedirect(request.getContextPath() + "/home.htm");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	
	@RequestMapping(value="/approve-payment.htm")
	public void approvePayment(HttpServletRequest request, HttpServletResponse response) {
		int billId = Integer.parseInt(request.getParameter("billId"));
		customerDao.updateBillPayment(billId);		
		try {
			response.sendRedirect(request.getContextPath() + "/account.htm");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/brandmodeltable.htm")
	@ResponseBody
	public String getCarBrandModel() {
		HashMap<String, List<String>> brandModelList = customerDao.getCarBrandModel();
		Gson gson = new Gson(); 
		String json = gson.toJson(brandModelList); 
		return json;
	}
	
	@RequestMapping(value="/service-center-history-table.htm")
	@ResponseBody
	public String getServiceCenterDetails(@RequestParam("id") String sc_id) {
		List<CustomerBill> serviceCenterOrderHistory = customerDao.getServiceCenterOrderHistory(Long.parseLong(sc_id));
		Gson gson = new Gson(); 
		String json = gson.toJson(serviceCenterOrderHistory); 
		return json;
	}
	
	@RequestMapping(value="/pending-center.htm")
	public String getPendingCenters(ModelMap model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		if(session.getAttribute("admin") != null) {
			List<WaitlistedServiceCenter> serviceCenters = customerDao.showPendingServiceCenter();
			model.put("waitlisted", serviceCenters);
			return "account-admin-pending-center";
		} else {
			try {
				response.sendRedirect(request.getContextPath() + "/home.htm");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@RequestMapping(value="/approve-center.htm")
	public void approveCenter(HttpServletRequest request, HttpServletResponse response) {
		Long centerId = Long.parseLong(request.getParameter("centerId"));
		List<WaitlistedServiceCenter> waitlistedCenterList = customerDao.showWaitlistedCenterByMobileNo(centerId);
		WaitlistedServiceCenter waitlistedCenter = waitlistedCenterList.get(0);
		customerDao.addServiceCenter(waitlistedCenter);		
		try {
			response.sendRedirect(request.getContextPath() + "/pending-center.htm");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/deny-center.htm")
	public void denyCenter(HttpServletRequest request, HttpServletResponse response) {
		Long centerId = Long.parseLong(request.getParameter("centerId"));
		List<WaitlistedServiceCenter> waitlistedCenterList = customerDao.showWaitlistedCenterByMobileNo(centerId);
		WaitlistedServiceCenter waitlistedCenter = waitlistedCenterList.get(0);
		customerDao.deleteServiceCenter(waitlistedCenter);		
		try {
			response.sendRedirect(request.getContextPath() + "/pending-center.htm");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
