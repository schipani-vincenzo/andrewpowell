package com.universalmind.samples.employeemanager.model;

import java.util.ArrayList;
import java.util.List;
import java.io.Serializable;

/**
 * Copyright (c) 2008 Universal Mind, Inc.
 * Created by IntelliJ IDEA.
 * Created By: Andrew Powell
 * Date: Apr 12, 2008
 * Time: 4:01:54 PM
 */
public class Department implements Serializable {


    private String id;
    private String name;
    private Manager manager;
    private List<Employee> employees = new ArrayList<Employee>();

    public Department(String name, Manager manager, List<Employee> employees) {
        this.name = name;
        this.manager = manager;
        this.employees = employees;
    }

    public Department() {

    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Manager getManager() {
        return manager;
    }

    public void setManager(Manager manager) {
        this.manager = manager;
    }

    public List<Employee> getEmployees() {
        return employees;
    }

    public void setEmployees(List<Employee> employees) {
        this.employees = employees;
    }

    public void removeEmployee(Employee emp){
        this.employees.remove(emp);
    }

    public void addEmployee(Employee emp){
        this.employees.add(emp);
    }

    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Department that = (Department) o;

        if (employees != null ? !employees.equals(that.employees) : that.employees != null) return false;
        if (manager != null ? !manager.equals(that.manager) : that.manager != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;

        return true;
    }

    public int hashCode() {
        int result;
        result = (name != null ? name.hashCode() : 0);
        result = 31 * result + (manager != null ? manager.hashCode() : 0);
        result = 31 * result + (employees != null ? employees.hashCode() : 0);
        return result;
    }
}
