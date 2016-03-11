package views.scripts
{
	public class Functions extends Object
	{
		public function Functions()
		{
			super();
		}
		
		static public function getDateFormated(d:Date) : String {
			var t:Date = new Date(d.fullYear, d.month, d.date);
			return t.toString();
		}
	}
}