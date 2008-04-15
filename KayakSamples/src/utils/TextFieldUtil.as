package utils
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class TextFieldUtil
	{

		public function TextFieldUtil()
		{}

		/**
		* Evaluates the textField and desired width param and sizes the TextField
		*
		* @returns sized TextField
		* @param {number} desired width
		* @param {TextField} text field to be edited
		* @param {concatText} string to concat
		*/
		public function sizeTextField(textField:TextField, wid:Number, concatText:String):String
		{
			//size the text field and apply ellipses if it's text width is greater than desired width 
			if (textField.textWidth > wid)
			{
				var initWidth:Number = textField.textWidth;
				textField.appendText(concatText);
				var concatWidth:Number = textField.textWidth - initWidth;
				var activeWidth:Number = wid - concatWidth;
				
				//loop until size is right 
				for (var i:int = 0; i < initWidth; i++)
				{
					if(textField.textWidth > activeWidth)
					{			
						textField.text = textField.text.substr(0, (textField.text.length - 1));
					}
					else
					{
						textField.appendText(concatText);
						break;
					}
				}
				return textField.text;
				}
				else
				{
					return textField.text;
				}
			}
		}
	}
}	