package views.scripts
{
	import flash.data.SQLConnection;
	import flash.events.EventDispatcher;

	public class Table extends EventDispatcher
	{
		
		protected var connection:SQLConnection;
		
		//status
		[Bindable]
		public var status:Status = new Status();
		
		public function Table(conn:SQLConnection)
		{
			super();
			connection = conn;
		}
	}
}