package com.ts.excelservlet;

import org.codehaus.jackson.annotate.JsonIgnore;

import com.ts.excelservlet.Address_Location;

public class Address_Geometry {

 private Address_Location location ;
 
 private String location_type;
 
 @JsonIgnore
 private Object bounds;
 
 @JsonIgnore
 
 private Object viewport;

 public Address_Location getLocation() {
  return location;
 }

 public void setLocation(Address_Location location) {
  this.location = location;
 }

 public String getLocation_type() {
  return location_type;
 }

 public void setLocation_type(String location_type) {
  this.location_type = location_type;
 }

 

 

 
 
 
}