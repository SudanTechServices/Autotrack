package com.ts.excelservlet;

import com.ts.excelservlet.Address_Result;

public class Address_GoogleResponse {	 	
	 private Address_Result[] results ;
	 private String status ;
	 
	 
	 public Address_Result[] getResults() {
	  return results;
	 }
	 public void setResults(Address_Result[] results) {
	  this.results = results;
	 }
	 public String getStatus() {
	  return status;
	 }
	 
	 public void setStatus(String status) {
	  this.status = status;
	 }
}