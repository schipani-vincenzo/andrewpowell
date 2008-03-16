package net.infoaccelerator.speedTest.vo;

import java.util.Date;

public class Employee {
	
	private String 	firstName;
	private String 	lastName;
	private Date	birthday;
	private Date	hireDate;
	
	
	
	public Employee() {

	}

	public Employee(String firstName, String lastName, Date birthday,
			Date hireDate) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.birthday = birthday;
		this.hireDate = hireDate;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Date getHireDate() {
		return hireDate;
	}

	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}
	
	
	
	
}
