package views.scripts
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.net.Responder;

	public class Food extends Table
	{
		//current record data
		[Bindable]
		public var id:int;
		[Bindable]
		public var foodname:String;

		public function Food(conn:SQLConnection)
		{
			super(conn);
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "CREATE TABLE IF NOT EXISTS FOOD (id INTEGER PRIMARY KEY AUTOINCREMENT, foodname TEXT)";
			stat.execute();
		}
		
		public function selectItems(rowsResponder:Responder):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "SELECT * FROM FOOD ORDER BY id";
			stat.execute(-1, rowsResponder);
		}
		
		public function newItem():void
		{
			id = -1;
			foodname = "";
			status.operation = "New";
		}
		
		public function editItem(item:Object):void
		{
			id = item.id;
			foodname = item.foodname;
			status.operation = "Edit";
		}
		
		public function setItem(item:Object):void
		{
			id = item.id;
			foodname = item.foodname;
			status.operation = "Current";
		}
		
		public function saveItem():void
		{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.parameters["@foodname"] = foodname;
			if(id == -1){
				stat.text = "INSERT INTO FOOD (foodname) VALUES (@foodname)";
			}else{
				stat.parameters["@id_food"] = id;
				stat.text = "UPDATE FOOD SET foodname=@foodname WHERE id=@id_food";
			}
			stat.execute();
		}
		
		public function deleteItem(item:Object):void
		{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.parameters["@id_food"] = item.id;
			stat.text = "DELETE FROM FOOD WHERE id=@id_food";
			stat.execute();	
		}
		
	}
}