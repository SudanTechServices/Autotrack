package com.ts.domain;

public class CustomerInfo {
	private String customername;
	
	private String customer_address;
	private String customer_number;
	private String contract_start_date;
	private String contract_end_date;
	private String contact_person;
	private int number_of_licence;
	private String customer_id;
	private String action;
	
	public int getNumber_of_licence() {
		return number_of_licence;
	}
	public void setNumber_of_licence(int number_of_licence) {
		this.number_of_licence = number_of_licence;
	}
	public String getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}
	public String getContact_person() {
		return contact_person;
	}
	public void setContact_person(String contact_person) {
		this.contact_person = contact_person;
	}
	
	
	public String getCustomername() {
		return customername;
	}
	public void setCustomername(String customername) {
		this.customername = customername;
	}
	public String getCustomer_address() {
		return customer_address;
	}
	public void setCustomer_address(String customer_address) {
		this.customer_address = customer_address;
	}
	public String getCustomer_number() {
		return customer_number;
	}
	public void setCustomer_number(String customer_number) {
		this.customer_number = customer_number;
	}
	public String getContract_start_date() {
		return contract_start_date;
	}
	public void setContract_start_date(String contract_start_date) {
		this.contract_start_date = contract_start_date;
	}
	public String getContract_end_date() {
		return contract_end_date;
	}
	public void setContract_end_date(String contract_end_date) {
		this.contract_end_date = contract_end_date;
	}
	/*public int getNumber_of_licence() {
		return number_of_licence;
	}
	public void setNumber_of_licence(int number_of_licence) {
		this.number_of_licence = number_of_licence;
	}*/
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	

	
	
}
