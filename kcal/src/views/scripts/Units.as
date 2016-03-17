package views.scripts
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.net.Responder;

	public class Units extends Table
	{

		//current record data
		[Bindable]
		public var id:int;
		[Bindable]
		public var unitname:String;
		[Bindable]
		public var unitdesc:String;
		
		public function Units(conn:SQLConnection)
		{
			super(conn);
			
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "CREATE TABLE IF NOT EXISTS UNITS (id INTEGER PRIMARY KEY AUTOINCREMENT, unitname TEXT, unitdesc TEXT)";
			stat.execute();
		}
		
		public function selectItems(rowsResponder:Responder):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "SELECT * FROM UNITS ORDER BY id";
			stat.execute(-1, rowsResponder);
		}
		
		public function newItem():void
		{
			id = -1;
			unitname = unitdesc = "";
			status.operation = "New";
		}
		
		public function editItem(item:Object):void
		{
			id = item.id;
			unitname = item.unitname;
			unitdesc = item.unitdesc;
			status.operation = "Edit";
		}
		
		public function saveItem():void
		{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.parameters["@unitname"] = unitname;
			stat.parameters["@unitdesc"] = unitdesc;
			if(id == -1){
				stat.text = "INSERT INTO UNITS (unitname, unitdesc) VALUES (@unitname, @unitdesc)";
			}else{
				stat.parameters["@id_unit"] = id;
				stat.text = "UPDATE UNITS SET unitname=@unitname, unitdesc=@unitdesc WHERE id=@id_unit";
			}
			stat.execute();
		}
		
		public function deleteItem(item:Object):void
		{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.parameters["@id_unit"] = item.id;
			stat.text = "DELETE FROM UNITS WHERE id=@id_unit";
			stat.execute();	
		}
	}
}