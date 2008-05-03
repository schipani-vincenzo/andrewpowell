package com.universalmind.samples.employeemanager.dataAccess;

import com.universalmind.samples.employeemanager.model.Employee;

import java.util.ArrayList;

/**
 * Copyright (c) 2008 Universal Mind, Inc.
 * Created by IntelliJ IDEA.
 * Created By: Andrew Powell
 * Date: Apr 13, 2008
 * Time: 12:51:10 PM
 */
public interface IEmployeeDAO {
    Employee create(Employee o);

    Employee read(String id);

    void update(Employee o);

    void delete(Employee o);

    ArrayList<Employee> getAllEmployees();
}
