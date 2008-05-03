package com.universalmind.samples.employeemanager.dataAccess;

import com.universalmind.samples.employeemanager.model.Department;
import com.universalmind.samples.employeemanager.model.Manager;

import java.util.ArrayList;

/**
 * Copyright (c) 2008 Universal Mind, Inc.
 * Created by IntelliJ IDEA.
 * Created By: Andrew Powell
 * Date: Apr 13, 2008
 * Time: 12:51:29 PM
 */
public interface IDepartmentDAO {
    Department create(Department o);

    Department read(String id);

    void update(Department o);

    void delete(Department o);

    ArrayList<Department> getAllDepartments();

    Department getDepartmentByName(String dptName);

    Department getDepartmentByManager(Manager mgr);

}
