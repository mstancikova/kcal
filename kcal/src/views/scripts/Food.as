package views.scripts
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.net.Responder;

	public class Food extends Table
	{

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
		
		public function Create(what:Object, createResponder:Responder):void {
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "INSERT INTO FOOD (foodname) VALUES (@foodname)";
			stat.execute(-1, createResponder);
		}
		
		public function Update(what:Object, updatedResponder:Responder):void {
				var stat:SQLStatement = new SQLStatement();
				stat.sqlConnection = connection;
				for(var i:Object in what){
					stat.parameters[i] = what[i];
				}
				stat.text = "UPDATE FOOD SET foodname=@foodname WHERE id=@id_food";
				stat.execute(-1, updatedResponder);
		}
		
		public function Delete(what:Object):void{
			var stat:SQLStatement = new SQLStatement();
			stat.sqlConnection = connection;
			for(var i:Object in what){
				stat.parameters[i] = what[i];
			}
			stat.text = "DELETE FROM FOOD WHERE id=@id_food";
			stat.execute();
		}
	}
}