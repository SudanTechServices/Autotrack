package com.ts.service;

public class FindFuel {
	
double current_good_fuel_value=0.0;
double maximum_fuel_value = 0.0;
double calculated_fuel_value = 0.0;
double fuel_in_liters = 0.0;

public double findFuel(double fuel_from_db,double first_good_fuel_value_double)
{
	System.out.println("from db"+fuel_from_db);
	if(fuel_from_db==0.00)
	{
		first_good_fuel_value_double= fuel_from_db;//engine is still off
	}
	else if(fuel_from_db>=0.50)
		{
			if(first_good_fuel_value_double==0.00)
			{
				//first_good_fuel_value_double=fuel_from_db;//it become new voltage after engine start
				current_good_fuel_value=fuel_from_db;
				System.out.println("current_good after engine start="+current_good_fuel_value);
				first_good_fuel_value_double=fuel_from_db;
			}
			//if(fuel_from_db>first_good_fuel_value_double)
			if((fuel_from_db>=current_good_fuel_value) && (fuel_from_db<=current_good_fuel_value+0.10))
			{
				current_good_fuel_value=fuel_from_db;		
				System.out.println("current_good="+current_good_fuel_value);
			 maximum_fuel_value = 0.5;
			 calculated_fuel_value = ((current_good_fuel_value - 7.0)/(maximum_fuel_value - 7.0))*100;
			 fuel_in_liters = (calculated_fuel_value/100)*53;
			//int fuel_ltr=(int)fuel_in_liters;
			fuel_in_liters=Math.round(fuel_in_liters*100.0)/100.0;

}
}
	return fuel_in_liters;
}
}
