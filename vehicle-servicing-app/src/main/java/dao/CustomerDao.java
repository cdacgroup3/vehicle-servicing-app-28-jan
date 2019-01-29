package dao;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import dto.Customer;
import dto.CustomerBill;
import dto.CustomerCar;
import dto.ServiceCenter;
import dto.WaitlistedServiceCenter;

@Repository
public class CustomerDao {
	@Autowired
	private HibernateTemplate hibernateTemplate;

	public CustomerDao() {
		super();
	}

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	
	public HashMap<String, List<String>> getCarBrandModel() {
		HashMap<String, List<String>> list = hibernateTemplate.execute(new HibernateCallback<HashMap<String, List<String>>>() {
			public HashMap<String, List<String>> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				HashMap<String, List<String>> carBrandModel = new HashMap<String, List<String>>();
				List<String> ul = session.createCriteria(CustomerCar.class).setProjection(Projections.distinct(Projections.property("carBrand"))).list();
				Iterator<String> it = ul.iterator();
				while(it.hasNext()) {
					String s1 = it.next();
					String sql = "Select model from car_brand_model WHERE brand=?";
					Query q = session.createSQLQuery(sql);
					q.setString(0, s1);
					List<String> ul2 = q.list();
					carBrandModel.put(s1, ul2);
				}
				t.commit();
				session.flush();
				session.close();
				return carBrandModel;
			}
		});
		return list;
	}
	
	public void createUser(final Customer customer) {
		hibernateTemplate.execute(new HibernateCallback<List<Customer>>() {
			public List<Customer> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				session.save(customer);
				t.commit();
				session.flush();
				session.close();
				return null;
			}
		});
	}
	
	public void createServiceCenter(final WaitlistedServiceCenter serviceCenter) {
		hibernateTemplate.execute(new HibernateCallback<List<ServiceCenter>>() {
			public List<ServiceCenter> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				session.save(serviceCenter);
				t.commit();
				session.flush();
				session.close();
				return null;
			}
		});
	}
	
	public void createBill(final CustomerBill customerBill) {
		hibernateTemplate.execute(new HibernateCallback<List<ServiceCenter>>() {
			public List<ServiceCenter> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				session.save(customerBill);
				t.commit();
				session.flush();
				session.close();
				return null;
			}
		});
	}
	
	public List<Customer> login(Customer customer) {
		List<Customer> list = hibernateTemplate.execute(new HibernateCallback<List<Customer>>() {
			public List<Customer> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				Query q = session.createQuery("from Customer where customerName = ? and password = ?");
				q.setString(0, customer.getCustomerName());
				q.setString(1, customer.getPassword());
				List<Customer> ul = q.list();
				t.commit();
				session.flush();
				session.close();
				return ul;
			}
		});
		return list;
	}
	
	public List<ServiceCenter> loginServiceCenter(ServiceCenter serviceCenter) {
		List<ServiceCenter> list = hibernateTemplate.execute(new HibernateCallback<List<ServiceCenter>>() {
			public List<ServiceCenter> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				Query q = session.createQuery("from ServiceCenter where serviceCenterName = ? and password = ?");
				q.setString(0, serviceCenter.getServiceCenterName());
				q.setString(1, serviceCenter.getPassword());
				List<ServiceCenter> ul = q.list();
				t.commit();
				session.flush();
				session.close();
				return ul;
			}
		});
		return list;
	}
	
	public List<Customer> showCustomerByName(String customerName) {
		List<Customer> list = hibernateTemplate.execute(new HibernateCallback<List<Customer>>() {
			public List<Customer> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				Query q = session.createQuery("from Customer where customerName = ?");
				q.setString(0, customerName);
				List<Customer> ul = q.list();
				System.out.println(ul);
				
				t.commit();
				session.flush();
				session.close();
				return ul;
			}
		});
		return list;
	}
	
	public List<ServiceCenter> showServiceCenterByMobileNo(Long serviceCenterMobileNo) {
		List<ServiceCenter> list = hibernateTemplate.execute(new HibernateCallback<List<ServiceCenter>>() {
			public List<ServiceCenter> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				Query q = session.createQuery("from ServiceCenter where mobileNo = ?");
				q.setLong(0, serviceCenterMobileNo);
				List<ServiceCenter> ul = q.list();
				
				t.commit();
				session.flush();
				session.close();
				return ul;
			}
		});
		return list;
	}
	
	public List<ServiceCenter> showServiceCenterByName(String serviceCenterName) {
		List<ServiceCenter> list = hibernateTemplate.execute(new HibernateCallback<List<ServiceCenter>>() {
			public List<ServiceCenter> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				Query q = session.createQuery("from ServiceCenter where serviceCenterName = ?");
				q.setString(0, serviceCenterName);
				List<ServiceCenter> ul = q.list();
				
				t.commit();
				session.flush();
				session.close();
				return ul;
			}
		});
		return list;
	}
	
	public List<ServiceCenter> showServiceCenterByZip(Customer customer) {
		List<ServiceCenter> list = hibernateTemplate.execute(new HibernateCallback<List<ServiceCenter>>() {
			public List<ServiceCenter> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				Query q1 = session.createQuery("from Customer where customerName = ? and password = ?");
				q1.setString(0, customer.getCustomerName());
				q1.setString(1, customer.getPassword());
				List<Customer> ul1 = q1.list();
				int customerZipcode = ul1.get(0).getZipcode();				
				
				Query q2 = session.createQuery("from ServiceCenter where zipcode = ?");
				q2.setInteger(0, customerZipcode);
				List<ServiceCenter> ul2 = q2.list();
				
				t.commit();
				session.flush();
				session.close();
				return ul2;
			}
		});
		return list;
	}	

	
	public List<CustomerBill> getCustomerOrders(Long mobileNo) {
		List<CustomerBill> list = hibernateTemplate.execute(new HibernateCallback<List<CustomerBill>>() {
			public List<CustomerBill> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				Query q = session.createQuery("from CustomerBill where mobile_no=? and isPaid=?");
				q.setLong(0, mobileNo);
				q.setBoolean(1, false);
				List<CustomerBill> ul = q.list();
				
				t.commit();
				session.flush();
				session.close();
				return ul;
			}
		});
		return list;
	}
	
	public List<CustomerBill> getServiceCenterOrders(Long mobileNo) {
		List<CustomerBill> list = hibernateTemplate.execute(new HibernateCallback<List<CustomerBill>>() {
			public List<CustomerBill> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				Query q = session.createQuery("from CustomerBill where service_center_mobile_no=? and isPaid=?");
				q.setLong(0, mobileNo);
				q.setBoolean(1, false);
				List<CustomerBill> ul = q.list();
				
				t.commit();
				session.flush();
				session.close();
				return ul;
			}
		});
		return list;
	}
	
	public List<CustomerBill> getCustomerOrderHistory(Long mobileNo) {
		List<CustomerBill> list = hibernateTemplate.execute(new HibernateCallback<List<CustomerBill>>() {
			public List<CustomerBill> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				Query q = session.createQuery("from CustomerBill where mobile_no=? and isPaid=?");
				q.setLong(0, mobileNo);
				q.setBoolean(1, true);
				List<CustomerBill> ul = q.list();
				
				t.commit();
				session.flush();
				session.close();
				return ul;
			}
		});
		return list;
	}
	
	public List<CustomerBill> getServiceCenterOrderHistory(Long mobileNo) {
		List<CustomerBill> list = hibernateTemplate.execute(new HibernateCallback<List<CustomerBill>>() {
			public List<CustomerBill> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				Query q = session.createQuery("from CustomerBill where service_center_mobile_no=? and isPaid=?");
				q.setLong(0, mobileNo);
				q.setBoolean(1, true);
				List<CustomerBill> ul = q.list();
				
				t.commit();
				session.flush();
				session.close();
				return ul;
			}
		});
		return list;
	}
	
	public void updateBillPayment(int billId) {
		hibernateTemplate.execute(new HibernateCallback<List<ServiceCenter>>() {
			public List<ServiceCenter> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				String queryString="UPDATE CustomerBill SET is_paid=true WHERE bill_id=?";
			    Query q=session.createQuery(queryString);
				q.setInteger(0, billId);
				q.executeUpdate();
			    
				t.commit();
				session.flush();
				session.close();
				return null;
			}
		});
	}
	
	public List<Number[]> showServiceCenterRevenue() {
		List<Number[]> list = hibernateTemplate.execute(new HibernateCallback<List<Number[]>>() {
			public List<Number[]> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();				
				String sql = "Select service_center_mobile_no from customer_bill WHERE is_paid=1 group by service_center_mobile_no";
				Query q = session.createSQLQuery(sql);
				List<BigInteger> ul1 = q.list(); 
				
				sql = "Select count(*) from customer_bill WHERE is_paid=1 group by service_center_mobile_no";
				q = session.createSQLQuery(sql);
				List<BigInteger> ul2  = q.list(); 
				
				sql = "Select sum(total_price) from customer_bill WHERE is_paid=1 group by service_center_mobile_no";
				q = session.createSQLQuery(sql);
				List<BigDecimal> ul3  = q.list(); 
				
				Iterator<BigInteger> it1 = ul1.iterator();
				Iterator<BigInteger> it2 = ul2.iterator();
				Iterator<BigDecimal> it3 = ul3.iterator();
				
				List<Number[]> ul = new ArrayList<Number[]>();
				while(it1.hasNext() && it2.hasNext() && it3.hasNext()) {
					Number[] bi = new Number[3];
					bi[0] = (Number)it1.next();
					bi[1] = (Number)it2.next();
					bi[2] = (Number)it3.next();
					ul.add(bi);
				}
				
				t.commit();
				session.flush();
				session.close();
				return ul;
			}
		});
		return list;
	}
	
	public List<WaitlistedServiceCenter> showPendingServiceCenter() {
		List<WaitlistedServiceCenter> list = hibernateTemplate.execute(new HibernateCallback<List<WaitlistedServiceCenter>>() {
			public List<WaitlistedServiceCenter> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				Query q = session.createQuery("from WaitlistedServiceCenter");
				List<WaitlistedServiceCenter> ul = q.list();
				t.commit();
				session.flush();
				session.close();
				return ul;
			}
		});
		return list;
	}
	
	public List<WaitlistedServiceCenter> showWaitlistedCenterByMobileNo(Long serviceCenterMobileNo) {
		List<WaitlistedServiceCenter> list = hibernateTemplate.execute(new HibernateCallback<List<WaitlistedServiceCenter>>() {
			public List<WaitlistedServiceCenter> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				Query q = session.createQuery("from WaitlistedServiceCenter where mobileNo = ?");
				q.setLong(0, serviceCenterMobileNo);
				List<WaitlistedServiceCenter> ul = q.list();
				
				t.commit();
				session.flush();
				session.close();
				return ul;
			}
		});
		return list;
	}
	
	public void addServiceCenter(WaitlistedServiceCenter waitlistedCenter) {
		hibernateTemplate.execute(new HibernateCallback<List<WaitlistedServiceCenter>>() {
			public List<WaitlistedServiceCenter> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				String sql = "Insert into service_center values(?, ?, ?, ?, ?, ?, ?)";
			    Query q = session.createSQLQuery(sql);
				q.setLong(0, waitlistedCenter.getMobileNo());
				q.setString(1, waitlistedCenter.getAddress());
				q.setString(2, waitlistedCenter.getEmail());
				q.setString(3, waitlistedCenter.getPassword());
				q.setString(4, waitlistedCenter.getServiceCenterName());
				q.setInteger(5, waitlistedCenter.getSlot());
				q.setInteger(6, waitlistedCenter.getZipcode());
				q.executeUpdate();
								
				session.delete(waitlistedCenter);
				
				t.commit();
				session.flush();
				session.close();
				return null;
			}
		});
	}
	
	public void deleteServiceCenter(WaitlistedServiceCenter waitlistedCenter) {
		hibernateTemplate.execute(new HibernateCallback<List<WaitlistedServiceCenter>>() {
			public List<WaitlistedServiceCenter> doInHibernate(Session session) throws HibernateException {
				Transaction t = session.beginTransaction();
				session.delete(waitlistedCenter);				
				t.commit();
				session.flush();
				session.close();
				return null;
			}
		});
	}
}
