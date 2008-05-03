package com.universalmind.samples.employeemanager.dataAccess;

import com.universalmind.samples.employeemanager.model.Employee;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.ArrayList;

/**
 * Copyright (c) 2008 Universal Mind, Inc.
 * Created by IntelliJ IDEA.
 * Created By: Andrew Powell
 * Date: Apr 13, 2008
 * Time: 12:35:04 PM
 */
public class EmployeeDAO extends HibernateDaoSupport implements IEmployeeDAO {

    public EmployeeDAO() {
    }

    public Employee create(Employee o) {
        String id = (String) getHibernateTemplate().save(o);
        return read(id);
    }

    public Employee read(String id) {
        return (Employee) getHibernateTemplate().load(Employee.class, id);
    }

    public void update(Employee o) {
        getHibernateTemplate().update(o);
        getHibernateTemplate().evict(o);
    }

    public void delete(Employee o) {
        getHibernateTemplate().delete(o);
        getHibernateTemplate().evict(o);
    }

    public ArrayList<Employee> getAllEmployees() {
        DetachedCriteria criteria = getNewCriteria();

        criteria.addOrder(Order.asc("lastName"));

        return (ArrayList<Employee>) getHibernateTemplate().findByCriteria(criteria);
    }

    private DetachedCriteria getNewCriteria() {
        return DetachedCriteria.forClass(Employee.class);
    }
}
