package com.universalmind.samples.employeemanager.dataAccess;

import com.universalmind.samples.employeemanager.model.Department;
import com.universalmind.samples.employeemanager.model.Manager;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.ArrayList;

/**
 * Copyright (c) 2008 Universal Mind, Inc.
 * Created by IntelliJ IDEA.
 * Created By: Andrew Powell
 * Date: Apr 13, 2008
 * Time: 12:35:04 PM
 */
public class DepartmentDAO extends HibernateDaoSupport implements IDepartmentDAO {

    public DepartmentDAO() {
    }

    public Department create(Department o) {
        String id = (String) getHibernateTemplate().save(o);
        return read(id);
    }

    public Department read(String id) {
        return (Department) getHibernateTemplate().load(Department.class, id);
    }

    public void update(Department o) {
        getHibernateTemplate().update(o);
        getHibernateTemplate().evict(o);
    }

    public void delete(Department o) {
        getHibernateTemplate().delete(o);
        getHibernateTemplate().evict(o);
    }

    public ArrayList<Department> getAllDepartments() {
        DetachedCriteria criteria = getNewCriteria();

        criteria.addOrder(Order.asc("name"));

        return (ArrayList<Department>) getHibernateTemplate().findByCriteria(criteria);
    }

    public Department getDepartmentByName(String dptName) {
        DetachedCriteria criteria = getNewCriteria();

        criteria.add(Restrictions.eq("name", dptName));

        return (Department) getHibernateTemplate().findByCriteria(criteria).get(0);
    }

    public Department getDepartmentByManager(Manager mgr) {
        DetachedCriteria criteria = getNewCriteria();

        criteria.add(Restrictions.eq("manager", mgr));

        return (Department) getHibernateTemplate().findByCriteria(criteria).get(0);
    }

    private DetachedCriteria getNewCriteria() {
        return DetachedCriteria.forClass(Department.class);
    }
}
