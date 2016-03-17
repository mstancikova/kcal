package views.scripts
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.net.Responder;

	public class Categories extends Table
	{

		//current record data
		[Bindable]
		public var id:int;
		[Bindable]
		public var catname:String;
		
		public function Categories(conn:SQLConnection)
		{
			super(conn);
			
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "CREATE TABLE IF NOT EXISTS CATEGORY (id INTEGER PRIMARY KEY AUTOINCREMENT, catname TEXT)";
			stat.execute();
		}
		
		public function selectItems(rowsResponder:Responder):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "SELECT * FROM CATEGORY ORDER BY id";
			stat.execute(-1, rowsResponder);
		}
		
		public function newItem():void
		{
			id = -1;
			catname = "";
			status.operation = "New";
		}
		
		public function editItem(item:Object):void
		{
			id = item.id;
			catname = item.catname;
			status.operation = "Edit";
		}
		
		public function saveItem():void
		{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.parameters["@catname"] = catname;
			if(id == -1){
				stat.text = "INSERT INTO CATEGORY (catname) VALUES (@catname)";
			}else{
				stat.parameters["@id_category"] = id;
				stat.text = "UPDATE CATEGORY SET catname=@catname WHERE id=@id_category";
			}
			stat.execute();
		}
		
		public function deleteItem(item:Object):void
		{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.parameters["@id_category"] = item.id;
			stat.text = "DELETE FROM CATEGORY WHERE id=@id_category";
			stat.execute();	
		}
	}
}