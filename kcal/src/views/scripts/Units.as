package views.scripts
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.net.Responder;

	public class Units extends Table
	{

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
		
		public function Create(what:Object, createResponder:Responder):void {
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "INSERT INTO UNITS (unitname, unitdesc) VALUES (@unitname, @unitdesc)";
			stat.execute(-1, createResponder);
		}
		
		public function Update(what:Object, updatedResponder:Responder):void {
				var stat:SQLStatement = new SQLStatement();
				stat.sqlConnection = connection;
				for(var i:Object in what){
					stat.parameters[i] = what[i];
				}
				stat.text = "UPDATE UNITS SET unitname=@unitname, unitdesc=@unitdesc WHERE id=@id_unit";
				stat.execute(-1, updatedResponder);
		}
		
		public function Delete(what:Object):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "DELETE FROM UNITS WHERE id=@id_unit";
			stat.execute();
		}
	}
}