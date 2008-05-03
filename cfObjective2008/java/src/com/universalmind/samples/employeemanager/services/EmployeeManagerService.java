package com.universalmind.samples.employeemanager.services;

import com.universalmind.samples.employeemanager.dataAccess.IDepartmentDAO;
import com.universalmind.samples.employeemanager.dataAccess.IEmployeeDAO;
import com.universalmind.samples.employeemanager.dataAccess.IManagerDAO;
import com.universalmind.samples.employeemanager.model.Department;
import com.universalmind.samples.employeemanager.model.Employee;
import com.universalmind.samples.employeemanager.model.Manager;

import java.util.ArrayList;

import org.apache.log4j.Logger;


/**
 * Copyright (c) 2008 Universal Mind, Inc.
 * Created by IntelliJ IDEA.
 * Created By: Andrew Powell
 * Date: Apr 13, 2008
 * Time: 12:47:35 PM
 */
public class EmployeeManagerService {

    private IEmployeeDAO empDAO;
    private IManagerDAO mgrDAO;
    private IDepartmentDAO dptDAO;

    private static Logger logger = Logger.getRootLogger();


    public void setEmpDAO(IEmployeeDAO empDAO) {
        this.empDAO = empDAO;
    }

    public void setMgrDAO(IManagerDAO mgrDAO) {
        this.mgrDAO = mgrDAO;
    }

    public void setDptDAO(IDepartmentDAO dptDAO) {
        this.dptDAO = dptDAO;
    }

    public EmployeeManagerService() {
    }

    public ArrayList<Department> getAllDepartments() {
        return dptDAO.getAllDepartments();
    }

    public Manager getManagerForDepartment(String dptID) {
        return mgrDAO.getManagerByDepartment(dptDAO.read(dptID));
    }

    public ArrayList<Employee> getAllEmployees() {
        return empDAO.getAllEmployees();
    }

    public Department getDepartment(String name) {
        return dptDAO.getDepartmentByName(name);
    }

    public Department getDepartment(Manager mgr) {
        return dptDAO.getDepartmentByManager(mgr);
    }

    public boolean addEmployeeToDepartment(Employee emp, Department dpt){
        boolean saveCheck = true;
        try{
            dpt.getEmployees().add(emp);
            dptDAO.update(dpt);
        }
        catch(Exception e){
            logger.error(e.getMessage());
            saveCheck=false;
            
        }
        finally{
            return saveCheck;
        }
    }

    public boolean changeEmployeeDepartment(String emp, String oldDept, String newDept){
        boolean saveCheck = true;
        try{
            Department oldDepartment = this.dptDAO.read(oldDept);
            Department newDepartment = this.dptDAO.read(newDept);
            Employee   employee      = this.empDAO.read(emp);

            if(employee.equals(oldDepartment.getManager())){
                oldDepartment.setManager(null);
            }

            oldDepartment.getEmployees().remove(employee);
            this.dptDAO.update(oldDepartment);

            newDepartment.getEmployees().add(employee);
            this.dptDAO.update(newDepartment);
            
        }
        catch(Exception e){
            logger.error(e.getMessage());
            saveCheck = false;
        }
        finally{
            return saveCheck;
        }
    }

    public boolean saveEmployee(Employee emp, String dptStr){
        boolean saveCheck = true;
        try{
            Employee pEmp = this.empDAO.create(emp);
            Department dpt = this.dptDAO.read(dptStr);
            dpt.getEmployees().add(pEmp);
            this.dptDAO.update(dpt);

        }
        catch(Exception e){
            logger.error(e.getMessage());
            saveCheck = false;
        }
        finally{
            return saveCheck;
        }

    }
}
