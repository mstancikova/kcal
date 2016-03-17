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
				
		public function Create(what:Object, createResponder:Responder):void {
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "INSERT INTO CATEGORY (catname) VALUES (@catname)";
			stat.execute(-1, createResponder);
		}
		
		public function Update(what:Object, updatedResponder:Responder):void {
				var stat:SQLStatement = new SQLStatement();
				stat.sqlConnection = connection;
				for(var i:Object in what){
					stat.parameters[i] = what[i];
				}
				stat.text = "UPDATE CATEGORY SET catname=@catname WHERE id=@id_category";
				stat.execute(-1, updatedResponder);
		}
		
		public function Delete(what:Object):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "DELETE FROM CATEGORY WHERE id=@id_category";
			stat.execute();
		}
	}
}