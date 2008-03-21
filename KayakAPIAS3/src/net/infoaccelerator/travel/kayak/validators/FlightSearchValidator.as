package net.infoaccelerator.travel.kayak.validators
{
	public class FlightSearchValidator implements ISearchValidator
	{
		public function FlightSearchValidator()
		{
		}

		public function validate(subject:Object):Boolean
		{
			if(validateAirportCode(subject.origin))
				if(validateAirportCode(subject.destination))
					if(validateDate(subject.depart_date))
						if(validateDate(subject.return_date))
							if(validateTime(subject.depart_time))
								if(validateTime(subject.return_time))
									if(validatePassengerCount(subject.travelers))
										if(validateCabin(subject.cabin))
											return true;
										else
											return false;
									else
										return false;
								else
									return false;
							else
								return false;
						else
							return false;
					else
						return false;	
				else
					return false;
			else
				return false;
		}
		
		public function validateAirportCode(target:String):Boolean{
			return ((target.length == 3) ? true : false);
		}
		
		public function validateDate(target:Date):Boolean{
			return true;
		}
		
		public function validateTime(target:String):Boolean{
			if(target == "a" 
			|| target == "r" 
			|| target == "m"
			|| target == "12" 
			|| target == "n" 
			|| target == "e" 
			|| target == "l")
				return true;
				else
					return false;
		}
		
		public function validatePassengerCount(target:Number):Boolean{
			if(target > 0 && target < 9)
				return true;
				else
					return false;
		}
		
		public function validateCabin(target:String):Boolean{
			if(target == "e" || target == "b" || target == "f")
				return true;
				else
					return false;
		}
		
		
		
	}
}