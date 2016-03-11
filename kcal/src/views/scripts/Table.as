package views.scripts
{
	import flash.data.SQLConnection;

	public class Table extends Object
	{
		
		protected var connection:SQLConnection;
		
		public function Table(conn:SQLConnection)
		{
			super();
			connection = conn;
		}
	}
}