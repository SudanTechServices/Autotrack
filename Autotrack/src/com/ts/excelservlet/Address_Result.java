package com.ts.excelservlet;

import org.codehaus.jackson.annotate.JsonIgnore;

public class Address_Result {
 
 private String formatted_address;
 
 
 private Address_Geometry geometry;
 
 @JsonIgnore
 private Object address_components;
 
 @JsonIgnore
 private Object types;

 public String getFormatted_address() {
  return formatted_address;
 }

 public void setFormatted_address(String formatted_address) {
  this.formatted_address = formatted_address;
 }

 
 public Address_Geometry getGeometry() {
  return geometry;
 }

 public void setGeometry(Address_Geometry geometry) {
  this.geometry = geometry;
 }

 
 public void setAddress_components(Object address_components) {
  this.address_components = address_components;
 }

 public Object getTypes() {
  return types;
 }

 public void setTypes(Object types) {
  this.types = types;
 }
 
 
 
}
