package views.scripts
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.net.Responder;

	public class Ingredients extends Table
	{
		//current record data
		[Bindable]
		public var id:int;
		[Bindable]
		public var ingname:String;
		[Bindable]
		public var fkcatname:String;
		[Bindable]
		public var fkunitname:String;
		[Bindable]
		public var unitkcal:String;
		
		public function Ingredients(conn:SQLConnection)
		{
			super(conn);
			
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "CREATE TABLE IF NOT EXISTS INGREDIENT (id INTEGER PRIMARY KEY AUTOINCREMENT, ingname TEXT, fkcatname TEXT, fkunitname TEXT, unitkcal DECIMAL(5, 2))";
			stat.execute();
		}
		
		public function selectItems(rowsResponder:Responder):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "SELECT * FROM INGREDIENT ORDER BY ingname";
			stat.execute(-1, rowsResponder);
		}
		
		public function selectByCategory(what:Object, rowsResponder:Responder):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "SELECT * FROM INGREDIENT WHERE fkcatname=@catfilter ORDER BY ingname";
			stat.execute(-1, rowsResponder);
		}
		
		public function newItem():void
		{
			id = -1;
			ingname = "";
			fkcatname = "";
			fkunitname = "";
			unitkcal = "";
			status.operation = "New";
		}
		
		public function editItem(item:Object):void
		{
			id = item.id;
			ingname = item.ingname;
			fkcatname = item.fkcatname;
			fkunitname = item.fkunitname;
			unitkcal = item.unitkcal;
			status.operation = "Edit";
		}
		
		public function saveItem():void
		{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.parameters["@ingname"] = ingname;
			stat.parameters["@fkcatname"] = fkcatname;
			stat.parameters["@fkunitname"] = fkunitname;
			stat.parameters["@unitkcal"] = unitkcal;
			if(id == -1){
				stat.text = "INSERT INTO INGREDIENT (ingname, fkcatname, fkunitname, unitkcal) VALUES (@ingname, @fkcatname, @fkunitname, @unitkcal)";
			}else{
				stat.parameters["@id_ingredient"] = id;
				stat.text = "UPDATE INGREDIENT SET ingname=@ingname, fkcatname=@fkcatname, fkunitname=@fkunitname, unitkcal=@unitkcal WHERE id=@id_ingredient";
			}
			stat.execute();
		}
		
		public function deleteItem(item:Object):void
		{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.parameters["@id_ingredient"] = item.id;
			stat.text = "DELETE FROM INGREDIENT WHERE id=@id_ingredient";
			stat.execute();	
		}
	}
}