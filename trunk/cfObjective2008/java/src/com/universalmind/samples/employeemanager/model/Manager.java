package com.universalmind.samples.employeemanager.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Copyright (c) 2008 Universal Mind, Inc.
 * Created by IntelliJ IDEA.
 * Created By: Andrew Powell
 * Date: Apr 12, 2008
 * Time: 3:57:46 PM
 */
public class Manager extends Employee implements Serializable {

    private Double rating;

    public Manager(String firstName, String lastName, Date birthdate, Date hireDate, Manager manager, String title, Double salary, Double rating) {
        super(firstName, lastName, birthdate, hireDate, manager, title, salary);
        this.rating = rating;
    }

    public Manager(Double rating) {
       this.rating = rating;
    }

    public Manager(String firstName, String lastName, Date birthdate, Date hireDate, Manager manager, String title, Double salary) {
        super(firstName, lastName, birthdate, hireDate, manager, title, salary);
    }

    public Manager() {
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;

        Manager manager = (Manager) o;

        if (rating != null ? !rating.equals(manager.rating) : manager.rating != null) return false;

        return true;
    }

    public int hashCode() {
        int result = super.hashCode();
        result = 31 * result + (rating != null ? rating.hashCode() : 0);
        return result;
    }
}
