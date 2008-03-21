package net.infoaccelerator.travel.kayak.validators
{
	public class HotelSearchValidator implements ISearchValidator
	{
		public function HotelSearchValidator()
		{
		}

		public function validate(subject:Object):Boolean
		{
			if(validateGuestCount(subject.guests))
				if(validateRoomCount(subject.rooms))
					return true;
					else
						return false;
				else
					return false;
		}
		
		private function validateGuestCount(target:Number):Boolean{
			if(target > 0 && target <= 6)
				return true;
			else
				return false;
		}
		
		private function validateRoomCount(target:Number):Boolean{
			if(target > 0 && target <= 3)
				return true;
			else
				return false;
				
		}
		
	}
}