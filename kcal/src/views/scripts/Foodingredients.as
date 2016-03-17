package views.scripts
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.net.Responder;

	public class Foodingredients extends Table
	{

		public function Foodingredients(conn:SQLConnection)
		{
			super(conn);
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "CREATE TABLE IF NOT EXISTS FOODINGREDIENTS (id INTEGER PRIMARY KEY AUTOINCREMENT, xxx TEXT)";
			stat.execute();
		}
		
		public function selectItems(rowsResponder:Responder):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			stat.text = "SELECT * FROM FOODINGREDIENTS ORDER BY id";
			stat.execute(-1, rowsResponder);
		}
		
		public function Create(what:Object, createResponder:Responder):void {
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "INSERT INTO FOODINGREDIENTS (xxx) VALUES (@xxx)";
			stat.execute(-1, createResponder);
		}
		
		public function Update(what:Object, updatedResponder:Responder):void {
				var stat:SQLStatement = new SQLStatement();
				stat.sqlConnection = connection;
				for(var i:Object in what){
					stat.parameters[i] = what[i];
				}
				stat.text = "UPDATE FOODINGREDIENTS SET xxx=@xxx WHERE id=@id_foodingredient";
				stat.execute(-1, updatedResponder);
		}
		
		public function Delete(what:Object):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "DELETE FROM FOODINGREDIENTS WHERE id=@id_foodingredient";
			stat.execute();
		}
	}
}