package com.universalmind.samples.employeemanager.dataAccess;

import com.universalmind.samples.employeemanager.model.Department;
import com.universalmind.samples.employeemanager.model.Manager;

/**
 * Copyright (c) 2008 Universal Mind, Inc.
 * Created by IntelliJ IDEA.
 * Created By: Andrew Powell
 * Date: Apr 13, 2008
 * Time: 12:50:49 PM
 */
public interface IManagerDAO {
    Manager create(Object o);

    Manager read(String id);

    void update(Object o);

    void delete(Object o);

    Manager getManagerByDepartment(Department dpt);
}
