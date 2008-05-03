package com.universalmind.samples.employeemanager.dataAccess;

import com.universalmind.samples.employeemanager.model.Department;
import com.universalmind.samples.employeemanager.model.Manager;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.util.ArrayList;
import java.util.List;

/**
 * Copyright (c) 2008 Universal Mind, Inc.
 * Created by IntelliJ IDEA.
 * Created By: Andrew Powell
 * Date: Apr 13, 2008
 * Time: 12:35:04 PM
 */
public class ManagerDAO extends HibernateDaoSupport implements IManagerDAO {

    public ManagerDAO() {
    }

    public Manager create(Object o) {
        String id = (String) getHibernateTemplate().save(o);
        return read(id);
    }

    public Manager read(String id) {
        return (Manager) getHibernateTemplate().load(Manager.class, id);
    }

    public void update(Object o) {
        getHibernateTemplate().update(o);
        getHibernateTemplate().evict(o);
    }

    public void delete(Object o) {
        getHibernateTemplate().delete(o);
        getHibernateTemplate().evict(o);
    }

    public Manager getManagerByDepartment(Department dpt) {
        DetachedCriteria criteria = getNewCriteria();

        criteria.add(Restrictions.eq("department", dpt));

        List results = getHibernateTemplate().findByCriteria(criteria);

        return (Manager) results.get(0);
    }

    public ArrayList<Manager> getAllManagers(String sortField) {
        DetachedCriteria criteria = getNewCriteria();

        criteria.addOrder(Order.asc(sortField));

        return (ArrayList<Manager>) getHibernateTemplate().findByCriteria(criteria);

    }

    public ArrayList<Manager> getAllManagers() {
        DetachedCriteria criteria = getNewCriteria();

        criteria.addOrder(Order.asc("lastName"));

        return (ArrayList<Manager>) getHibernateTemplate().findByCriteria(criteria);

    }

    private DetachedCriteria getNewCriteria() {
        return DetachedCriteria.forClass(Manager.class);
    }
}
